/**
 * InvestEd market-data proxy — Cloudflare Worker
 *
 * The app never holds the Finnhub API key. It calls these routes instead, and
 * the Worker adds the key server-side (stored as a Worker secret):
 *   GET /market/stock?symbol=AAPL   -> { c, pc, name }   (quote + company name)
 *   GET /market/search?q=apple      -> Finnhub symbol search passthrough
 *   GET /                            -> health check
 *
 * Responses are cached at Cloudflare's edge (quotes 15s, company names 7 days,
 * searches 1 day), so the free Finnhub tier (~60 calls/min) is shared
 * efficiently across every student using the app.
 *
 * Setup, from backend/:
 *   wrangler secret put FINNHUB_API_KEY
 *   wrangler deploy
 */

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);

    if (request.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders() });
    }
    if (request.method !== "GET") {
      return json({ error: "GET only" }, 405);
    }
    if (url.pathname.startsWith("/market/")) {
      return handleMarket(url, env, ctx);
    }
    return json({
      ok: true,
      service: "invested-market",
      market: env.FINNHUB_API_KEY ? "ready" : "missing FINNHUB_API_KEY",
    }, 200);
  },
};

// ---- Market data (Finnhub) ----
const FINNHUB = "https://finnhub.io/api/v1";
const SYMBOL_RE = /^[A-Z0-9.\-]{1,10}$/;

async function handleMarket(url, env, ctx) {
  if (!env.FINNHUB_API_KEY) {
    return json({ error: "Market data not configured (FINNHUB_API_KEY missing)" }, 503);
  }

  if (url.pathname === "/market/stock") {
    const symbol = (url.searchParams.get("symbol") || "").toUpperCase();
    if (!SYMBOL_RE.test(symbol)) return json({ error: "bad symbol" }, 400);

    // Quote changes constantly; the company name almost never does.
    const [quote, profile] = await Promise.all([
      cachedFinnhub(`/quote?symbol=${symbol}`, 15, env, ctx),
      cachedFinnhub(`/stock/profile2?symbol=${symbol}`, 7 * 24 * 3600, env, ctx).catch(() => null),
    ]);
    if (!quote || typeof quote.c !== "number") return json({ error: "upstream" }, 502);
    return json({ c: quote.c, pc: quote.pc, name: profile?.name || null }, 200);
  }

  if (url.pathname === "/market/search") {
    const q = (url.searchParams.get("q") || "").trim().slice(0, 40);
    if (!q) return json({ result: [] }, 200);
    const data = await cachedFinnhub(`/search?q=${encodeURIComponent(q)}`, 24 * 3600, env, ctx);
    return json({ result: Array.isArray(data?.result) ? data.result : [] }, 200);
  }

  return json({ error: "unknown market route" }, 404);
}

// Fetch from Finnhub through Cloudflare's edge cache. The cache key is the
// path WITHOUT the token, so the secret is never stored in a cache key.
async function cachedFinnhub(path, ttlSeconds, env, ctx) {
  const cache = caches.default;
  const cacheKey = new Request(`https://invested-cache.internal${path}`);
  const hit = await cache.match(cacheKey);
  if (hit) return hit.json();

  const sep = path.includes("?") ? "&" : "?";
  const upstream = await fetch(`${FINNHUB}${path}${sep}token=${env.FINNHUB_API_KEY}`);
  if (!upstream.ok) throw new Error(`finnhub ${upstream.status}`);
  const data = await upstream.json();

  const toCache = new Response(JSON.stringify(data), {
    headers: { "Content-Type": "application/json", "Cache-Control": `max-age=${ttlSeconds}` },
  });
  ctx.waitUntil(cache.put(cacheKey, toCache));
  return data;
}

function json(obj, status) {
  return new Response(JSON.stringify(obj), {
    status,
    headers: { "Content-Type": "application/json", ...corsHeaders() },
  });
}

function corsHeaders() {
  return {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type",
  };
}
