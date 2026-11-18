// InvestEd web demo: lessons and a practice market in the browser.
// UNITS comes from lessons.js. Question types:
//   mc  -> choices[], correct (index)        tf -> answer (true/false)
//   num -> answer, tolerance, prefix ("$")   ms -> choices[], correct (indexes)

const app = document.getElementById("app");
const xpLabel = document.getElementById("xp");
const WORKER = "https://invested-chat.elias-dweiri.workers.dev";
const STARTING_CASH = 10000;

// Sample prices from the iPhone app, used if live prices can't load.
const SAMPLE = {
  AAPL: ["Apple Inc.", 212.34, 208.90], MSFT: ["Microsoft Corp.", 441.12, 438.50],
  GOOGL: ["Alphabet Inc.", 178.02, 180.11], AMZN: ["Amazon.com Inc.", 198.77, 195.30],
  TSLA: ["Tesla Inc.", 256.90, 264.10], NVDA: ["NVIDIA Corp.", 132.45, 128.77],
  META: ["Meta Platforms Inc.", 512.60, 508.20], NFLX: ["Netflix Inc.", 685.40, 690.15],
};

// ---------- saved progress (kept in this browser only) ----------
function load(key, fallback) {
  try { const v = localStorage.getItem("invested-" + key); return v ? JSON.parse(v) : fallback; }
  catch { return fallback; }
}
function save(key, value) {
  try { localStorage.setItem("invested-" + key, JSON.stringify(value)); } catch {}
}
const state = {
  xp: load("xp", 0),
  done: load("done", {}),                                   // lessonId -> best score
  portfolio: load("portfolio", { cash: STARTING_CASH, shares: {} }),
};
function addXP(n) { state.xp += n; save("xp", state.xp); showXP(); }
function showXP() { xpLabel.textContent = state.xp + " XP"; }

// ---------- helpers ----------
const esc = (s) => String(s).replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
const money = (n) => (n < 0 ? "-$" : "$") + Math.abs(n).toLocaleString("en-US", { minimumFractionDigits: 2, maximumFractionDigits: 2 });
function el(html) { const t = document.createElement("template"); t.innerHTML = html.trim(); return t.content.firstElementChild; }

function tabs(active) {
  const bar = el(`<div class="tabs">
    <button data-t="learn" class="${active === "learn" ? "on" : ""}">Learn</button>
    <button data-t="market" class="${active === "market" ? "on" : ""}">Market</button></div>`);
  bar.onclick = (e) => { const t = e.target.dataset.t; if (t === "learn") showUnits(); if (t === "market") showMarket(); };
  return bar;
}

// ---------- Learn ----------
function showUnits() {
  app.innerHTML = "";
  app.append(tabs("learn"));
  app.append(el(`<div class="intro"><h1>Money skills, one lesson at a time</h1>
    <p class="muted">Three units from the InvestEd app. Answer questions, read why, earn XP.</p></div>`));
  for (const unit of UNITS) {
    const card = el(`<div class="card unit" style="--u:${unit.color}">
      <div class="kicker">${esc(unit.title.split(":")[0])}</div>
      <h2>${esc(unit.title.split(":").slice(1).join(":").trim())}</h2>
      <p class="muted">${esc(unit.subtitle)}</p></div>`);
    unit.lessons.forEach((lesson) => {
      const best = state.done[lesson.id];
      const b = el(`<button class="lesson">${best != null ? "✓ " : ""}${esc(lesson.title)}
        <span class="muted small">${best != null ? `best ${best}/${lesson.questions.length}` : `${lesson.questions.length} questions`}</span></button>`);
      b.onclick = () => startLesson(lesson);
      card.append(b);
    });
    app.append(card);
  }
}

let run; // the lesson in progress

function startLesson(lesson) {
  run = { lesson, i: 0, correct: 0 };
  showQuestion();
}

function showQuestion() {
  const { lesson, i } = run;
  const q = lesson.questions[i];
  const pct = Math.round((i / lesson.questions.length) * 100);
  app.innerHTML = "";
  const head = el(`<div class="qhead"><button class="close" aria-label="Quit lesson">✕</button>
    <div class="bar"><i style="width:${pct}%"></i></div><span class="muted small">${i + 1}/${lesson.questions.length}</span></div>`);
  head.querySelector(".close").onclick = showUnits;
  app.append(head);

  const card = el(`<div class="card"><h2 class="prompt">${esc(q.prompt)}</h2><div class="answers"></div>
    <div class="feedback" hidden></div><button class="primary check" disabled>Check</button></div>`);
  const answers = card.querySelector(".answers");
  const check = card.querySelector(".check");
  let picked = q.type === "ms" ? new Set() : null;

  if (q.type === "mc" || q.type === "ms" || q.type === "tf") {
    const choices = q.type === "tf" ? ["True", "False"] : q.choices;
    choices.forEach((text, idx) => {
      const b = el(`<button class="choice">${esc(text)}</button>`);
      b.onclick = () => {
        if (card.dataset.answered) return;
        if (q.type === "ms") {
          picked.has(idx) ? picked.delete(idx) : picked.add(idx);
          b.classList.toggle("selected");
          check.disabled = picked.size === 0;
        } else {
          answers.querySelectorAll(".choice").forEach((c) => c.classList.remove("selected"));
          b.classList.add("selected");
          picked = idx;
          check.disabled = false;
        }
      };
      answers.append(b);
    });
    if (q.type === "ms") answers.prepend(el(`<p class="muted small">Choose all that apply.</p>`));
  } else if (q.type === "num") {
    const box = el(`<label class="num">${q.prefix ? `<span>${esc(q.prefix)}</span>` : ""}
      <input type="number" inputmode="decimal" step="any" placeholder="Your answer"></label>`);
    const input = box.querySelector("input");
    input.oninput = () => { check.disabled = input.value.trim() === ""; };
    input.onkeydown = (e) => { if (e.key === "Enter" && !check.disabled) check.click(); };
    answers.append(box);
    setTimeout(() => input.focus(), 0);
  }

  check.onclick = () => {
    if (card.dataset.answered) { next(); return; }
    const right = isCorrect(q, picked, card);
    card.dataset.answered = "1";
    if (right) run.correct++;
    markChoices(q, answers, picked);
    const fb = card.querySelector(".feedback");
    fb.hidden = false;
    fb.className = "feedback " + (right ? "good" : "bad");
    fb.innerHTML = `<b>${right ? "Correct!" : "Not quite."}</b> ${q.type === "num" && !right ? `The answer is ${esc(q.prefix || "")}${Number(q.answer).toLocaleString("en-US")}. ` : ""}${esc(q.explanation)}`;
    check.textContent = run.i + 1 < run.lesson.questions.length ? "Continue" : "See results";
  };
  app.append(card);
}

function isCorrect(q, picked, card) {
  if (q.type === "mc") return picked === q.correct;
  if (q.type === "tf") return (picked === 0) === q.answer;
  if (q.type === "ms") return picked.size === q.correct.length && q.correct.every((c) => picked.has(c));
  if (q.type === "num") {
    const v = parseFloat(card.querySelector("input").value.replace(/,/g, ""));
    return Math.abs(v - q.answer) <= (q.tolerance || 0) + 1e-9;
  }
  return false;
}

function markChoices(q, answers, picked) {
  const buttons = [...answers.querySelectorAll(".choice")];
  const rightSet = q.type === "mc" ? [q.correct] : q.type === "tf" ? [q.answer ? 0 : 1] : q.type === "ms" ? q.correct : [];
  buttons.forEach((b, idx) => {
    const chosen = q.type === "ms" ? picked.has(idx) : picked === idx;
    if (rightSet.includes(idx)) b.classList.add("right");
    else if (chosen) b.classList.add("wrong");
  });
  const input = answers.querySelector("input");
  if (input) input.disabled = true;
}

function next() {
  run.i++;
  if (run.i < run.lesson.questions.length) showQuestion();
  else showResults();
}

function showResults() {
  const { lesson, correct } = run;
  const total = lesson.questions.length;
  const xp = correct * 5 + (correct === total ? 10 : 0);
  addXP(xp);
  state.done[lesson.id] = Math.max(state.done[lesson.id] || 0, correct);
  save("done", state.done);
  app.innerHTML = "";
  const card = el(`<div class="card center"><div class="big">${correct}/${total}</div>
    <h2>${correct === total ? "Perfect lesson!" : correct >= total / 2 ? "Nice work!" : "Keep practicing!"}</h2>
    <p class="muted">You earned <b>${xp} XP</b> on “${esc(lesson.title)}.”</p>
    <button class="primary">Back to lessons</button></div>`);
  card.querySelector("button").onclick = showUnits;
  app.append(card);
}

// ---------- Market ----------
let quotes = null;      // symbol -> { name, price, prev }
let live = false;

async function loadQuotes() {
  const symbols = Object.keys(SAMPLE);
  const results = await Promise.all(symbols.map(async (s) => {
    try {
      const ctrl = new AbortController();
      const timer = setTimeout(() => ctrl.abort(), 6000);
      const r = await fetch(`${WORKER}/market/stock?symbol=${s}`, { signal: ctrl.signal });
      clearTimeout(timer);
      if (!r.ok) throw 0;
      const d = await r.json();
      if (!(d.c > 0)) throw 0;
      return [s, { name: d.name || SAMPLE[s][0], price: d.c, prev: d.pc || d.c }, true];
    } catch {
      return [s, { name: SAMPLE[s][0], price: SAMPLE[s][1], prev: SAMPLE[s][2] }, false];
    }
  }));
  quotes = Object.fromEntries(results.map(([s, q]) => [s, q]));
  live = results.every(([, , ok]) => ok);
}

async function showMarket() {
  app.innerHTML = "";
  app.append(tabs("market"));
  if (!quotes) {
    app.append(el(`<p class="muted">Loading prices…</p>`));
    await loadQuotes();
    if (!app.querySelector(".tabs .on[data-t=market]")) return; // user switched tabs
  }
  drawMarket();
}

function drawMarket() {
  const p = state.portfolio;
  const stockValue = Object.entries(p.shares).reduce((sum, [s, n]) => sum + n * quotes[s].price, 0);
  const total = p.cash + stockValue;
  const change = total - STARTING_CASH;
  app.innerHTML = "";
  app.append(tabs("market"));
  app.append(el(`<div class="card summary"><div class="kicker">Portfolio value</div>
    <div class="big">${money(total)}</div>
    <div class="${change >= 0 ? "up" : "down"}">${change >= 0 ? "+" : ""}${money(change)} all-time</div>
    <div class="row"><span>Cash <b>${money(p.cash)}</b></span><span>Stocks <b>${money(stockValue)}</b></span></div>
    <p class="muted small">${live ? "Live prices from Finnhub." : "Sample prices (live prices couldn't load)."} Practice money only.</p></div>`));

  const list = el(`<div class="card"><h2>Stocks</h2></div>`);
  for (const [s, q] of Object.entries(quotes)) {
    const pct = ((q.price - q.prev) / q.prev) * 100;
    const owned = p.shares[s] || 0;
    const row = el(`<div class="stock"><div><b>${s}</b> <span class="muted small">${esc(q.name)}</span>
      ${owned ? `<div class="small">You own ${owned} share${owned === 1 ? "" : "s"}</div>` : ""}</div>
      <div class="right-col"><b>${money(q.price)}</b><div class="small ${pct >= 0 ? "up" : "down"}">${pct >= 0 ? "+" : ""}${pct.toFixed(2)}%</div></div>
      <div class="trade"><input type="number" min="1" step="1" value="1" aria-label="Shares of ${s}">
      <button class="buy">Buy</button><button class="sell" ${owned ? "" : "disabled"}>Sell</button></div></div>`);
    const qty = () => Math.max(1, Math.floor(Number(row.querySelector("input").value) || 1));
    row.querySelector(".buy").onclick = () => trade(s, qty());
    row.querySelector(".sell").onclick = () => trade(s, -qty());
    list.append(row);
  }
  app.append(list);
  const reset = el(`<button class="link">Reset to $10,000</button>`);
  reset.onclick = () => { state.portfolio = { cash: STARTING_CASH, shares: {} }; save("portfolio", state.portfolio); drawMarket(); };
  app.append(reset);
}

function trade(symbol, n) {
  const p = state.portfolio;
  const price = quotes[symbol].price;
  const owned = p.shares[symbol] || 0;
  if (n > 0 && n * price > p.cash + 1e-9) { toast(`Not enough cash for ${n} ${symbol}.`); return; }
  if (n < 0 && -n > owned) { toast(`You only own ${owned} ${symbol}.`); return; }
  p.cash = Math.round((p.cash - n * price) * 100) / 100;
  const left = owned + n;
  if (left) p.shares[symbol] = left; else delete p.shares[symbol];
  save("portfolio", p);
  if (n > 0 && !load("firstTrade", false)) { save("firstTrade", true); addXP(10); }
  drawMarket();
  toast(`${n > 0 ? "Bought" : "Sold"} ${Math.abs(n)} ${symbol} at ${money(price)}.`);
}

function toast(msg) {
  const t = el(`<div class="toast" role="status">${esc(msg)}</div>`);
  document.body.append(t);
  setTimeout(() => t.remove(), 2600);
}

showXP();
showUnits();
