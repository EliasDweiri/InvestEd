/**
 * InvestEd chat proxy — Cloudflare Worker
 *
 * Receives { messages: [{ role: "user"|"assistant", content: "..." }] } from
 * the app (see ChatBotService.swift), forwards to an LLM, and returns
 * { reply: "..." }. Your API key lives ONLY here as a Worker secret, never in
 * the app.
 *
 * Provider is chosen automatically by which secret is set:
 *   • ANTHROPIC_API_KEY -> Claude (Anthropic)   [paid; console.anthropic.com — NOT Claude Pro]
 *   • else OPENAI_API_KEY -> ChatGPT (OpenAI)    [paid; needs billing/credits]
 *   • else GEMINI_API_KEY -> Gemini (Google)     [has a free tier]
 *
 * Setup (pick ONE provider), from backend/:
 *   Claude:   wrangler secret put ANTHROPIC_API_KEY   (paste sk-ant-... at the prompt)
 *   ChatGPT:  wrangler secret put OPENAI_API_KEY      (paste sk-... at the prompt)
 *   Gemini:   wrangler secret put GEMINI_API_KEY      (paste your key at the prompt)
 *   then:     wrangler deploy
 *
 * DIAGNOSE: open the Worker URL in a browser (GET) for a health check showing
 * which provider is live. Add ?debug=1 to a POST to see the provider's real error.
 *
 * MARKET DATA PROXY (GET /market/...)
 * The app never holds the Finnhub key. It calls these routes instead, and the
 * Worker adds the key server-side:
 *   GET /market/stock?symbol=AAPL   -> { c, pc, name }   (quote + company name)
 *   GET /market/search?q=apple      -> Finnhub symbol search passthrough
 * Responses are cached at Cloudflare's edge (quotes 15s, names 7 days,
 * searches 1 day) so the free Finnhub tier (~60 calls/min) is shared
 * efficiently across every student using the app.
 * Setup:  wrangler secret put FINNHUB_API_KEY   then   wrangler deploy
 */

// Anthropic: Haiku 4.5 is the cheapest Claude ($1 in / $5 out per 1M tokens) and
// is plenty for Penny's short, encouraging answers. Bump to "claude-sonnet-5" or
// "claude-opus-4-8" for stronger replies (higher cost). Verified current 2026-07.
const ANTHROPIC_MODEL = "claude-haiku-4-5";
const ANTHROPIC_VERSION = "2023-06-01";

// OpenAI: gpt-4o-mini is the cheapest chat model and works with the classic
// params below. Newer gpt-5.x small models need "max_completion_tokens".
const OPENAI_MODEL = "gpt-4o-mini";

// Gemini fallback list — if the first model is retired, the next is tried.
const GEMINI_MODELS = ["gemini-2.5-flash", "gemini-2.0-flash", "gemini-flash-latest"];

const SYSTEM_PROMPT = `You are Penny, the friendly AI assistant inside InvestEd,
an app that teaches teens and beginners about investing and personal finance
through a virtual $10,000 portfolio and bite-sized lessons.
Keep answers short (2-4 sentences), encouraging, and beginner-friendly.
Explain jargon simply. Never give personalized financial advice or tell the
user to buy or sell a specific real security with real money; frame everything
as education and practice within the app's simulated portfolio.`;

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const debug = url.searchParams.get("debug") === "1";
    const provider = env.ANTHROPIC_API_KEY
      ? "anthropic"
      : env.OPENAI_API_KEY
      ? "openai"
      : env.GEMINI_API_KEY
      ? "gemini"
      : "none";

    if (request.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders() });
    }

    if (url.pathname.startsWith("/market/")) {
      return handleMarket(url, env, ctx);
    }

    if (request.method === "GET") {
      return json({
        ok: true,
        service: "invested-chat",
        provider,
        market: env.FINNHUB_API_KEY ? "ready" : "missing FINNHUB_API_KEY",
        model:
          provider === "anthropic" ? ANTHROPIC_MODEL
          : provider === "openai" ? OPENAI_MODEL
          : provider === "gemini" ? GEMINI_MODELS
          : null,
        hint: provider === "none"
          ? "No key set. Run: wrangler secret put ANTHROPIC_API_KEY  (or OPENAI_API_KEY / GEMINI_API_KEY)"
          : `Using ${provider}. If Penny still fails, POST with ?debug=1 to see the real error.`,
      }, 200);
    }

    if (request.method !== "POST") {
      return json({ error: "POST only" }, 405);
    }

    if (provider === "none") {
      return json({
        reply: "Penny isn't fully set up yet — no chat API key has been added to the server.",
        ...(debug && { debug: "Set ANTHROPIC_API_KEY (or OPENAI_API_KEY / GEMINI_API_KEY) with `wrangler secret put`." }),
      }, 200);
    }

    let body;
    try {
      body = await request.json();
    } catch {
      return json({ error: "Invalid JSON" }, 400);
    }
    const messages = Array.isArray(body.messages) ? body.messages : [];
    if (messages.length === 0) {
      return json({ error: "messages required" }, 400);
    }

    if (provider === "anthropic") return callAnthropic(env, messages, debug);
    if (provider === "openai") return callOpenAI(env, messages, debug);
    return callGemini(env, messages, debug);
  },
};

// ---- Claude (Anthropic) ----
async function callAnthropic(env, messages, debug) {
  // The app already uses "user"/"assistant" roles. Anthropic requires the FIRST
  // message to be a user turn, so drop Penny's opening greeting (and any other
  // leading assistant turns).
  let chat = messages.slice(-20).map((m) => ({
    role: m.role === "assistant" ? "assistant" : "user",
    content: String(m.content ?? "").slice(0, 4000),
  }));
  while (chat.length && chat[0].role !== "user") chat.shift();
  if (chat.length === 0) chat = [{ role: "user", content: "Hi Penny!" }];

  let upstream;
  try {
    upstream = await fetch("https://api.anthropic.com/v1/messages", {
      method: "POST",
      headers: {
        "content-type": "application/json",
        "x-api-key": env.ANTHROPIC_API_KEY,
        "anthropic-version": ANTHROPIC_VERSION,
      },
      body: JSON.stringify({
        model: ANTHROPIC_MODEL,
        max_tokens: 512,
        temperature: 0.7,
        system: SYSTEM_PROMPT,
        messages: chat,
      }),
    });
  } catch (e) {
    return failure(0, `fetch failed: ${e}`, "anthropic", debug);
  }

  if (!upstream.ok) {
    const detail = await upstream.text();
    console.error("Anthropic error", upstream.status, detail);
    return failure(upstream.status, detail, "anthropic", debug);
  }

  const data = await upstream.json();
  const reply =
    (data?.content ?? []).filter((b) => b.type === "text").map((b) => b.text).join("") ||
    "Hmm, I couldn't come up with an answer. Try rephrasing?";
  return json({ reply, ...(debug && { debug: { provider: "anthropic", model: ANTHROPIC_MODEL } }) }, 200);
}

// ---- ChatGPT (OpenAI) ----
async function callOpenAI(env, messages, debug) {
  const chat = messages.slice(-20).map((m) => ({
    role: m.role === "assistant" ? "assistant" : "user",
    content: String(m.content ?? "").slice(0, 4000),
  }));

  let upstream;
  try {
    upstream = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${env.OPENAI_API_KEY}`,
      },
      body: JSON.stringify({
        model: OPENAI_MODEL,
        messages: [{ role: "system", content: SYSTEM_PROMPT }, ...chat],
        temperature: 0.7,
        max_tokens: 512,
      }),
    });
  } catch (e) {
    return failure(0, `fetch failed: ${e}`, "openai", debug);
  }

  if (!upstream.ok) {
    const detail = await upstream.text();
    console.error("OpenAI error", upstream.status, detail);
    return failure(upstream.status, detail, "openai", debug);
  }

  const data = await upstream.json();
  const reply =
    data?.choices?.[0]?.message?.content ??
    "Hmm, I couldn't come up with an answer. Try rephrasing?";
  return json({ reply, ...(debug && { debug: { provider: "openai", model: OPENAI_MODEL } }) }, 200);
}

// ---- Gemini (Google) ----
async function callGemini(env, messages, debug) {
  const contents = messages.slice(-20).map((m) => ({
    role: m.role === "assistant" ? "model" : "user",
    parts: [{ text: String(m.content ?? "").slice(0, 4000) }],
  }));
  const payload = JSON.stringify({
    system_instruction: { parts: [{ text: SYSTEM_PROMPT }] },
    contents,
    generationConfig: { temperature: 0.7, maxOutputTokens: 512 },
  });

  let lastStatus = 0;
  let lastDetail = "";
  for (const model of GEMINI_MODELS) {
    let upstream;
    try {
      upstream = await fetch(
        `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json", "x-goog-api-key": env.GEMINI_API_KEY },
          body: payload,
        }
      );
    } catch (e) {
      lastDetail = `fetch failed: ${e}`;
      continue;
    }
    if (!upstream.ok) {
      lastStatus = upstream.status;
      lastDetail = await upstream.text();
      console.error("Gemini error", model, upstream.status, lastDetail);
      if (upstream.status === 404) continue; // model gone — try the next
      break; // bad key / quota — will just repeat
    }
    const data = await upstream.json();
    const reply =
      data?.candidates?.[0]?.content?.parts?.map((p) => p.text).join("") ??
      "Hmm, I couldn't come up with an answer. Try rephrasing?";
    return json({ reply, ...(debug && { debug: { provider: "gemini", model } }) }, 200);
  }
  return failure(lastStatus, lastDetail, "gemini", debug);
}

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

function failure(status, detail, provider, debug) {
  return json({
    reply: "Sorry, I had trouble thinking just now — try again in a moment!",
    ...(debug && {
      debug: {
        provider,
        status,
        detail: String(detail).slice(0, 600),
        likelyCause:
          status === 401 || status === 403
            ? "Invalid API key, or the account isn't authorized (Anthropic/OpenAI: no billing/credits; Gemini: API not enabled)."
            : status === 429
            ? "Rate limit / quota / no credits."
            : status === 400
            ? "Bad request (often an invalid key or unsupported model)."
            : "See detail above.",
      },
    }),
  }, 200);
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
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type",
  };
}
