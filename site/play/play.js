// InvestEd web demo: the Learn path, lessons and the practice Market,
// laid out like the iPhone app ("Banknote" design: ink headers with a
// guilloche, cards tucked into the header, a floating tab bar).
// UNITS comes from lessons.js.

const app = document.getElementById("app");
const tabbar = document.getElementById("tabbar");
const WORKER = "https://invested-chat.elias-dweiri.workers.dev";
const STARTING_CASH = 10000;
const LESSON_XP = 20;

const TABS = [
  { id: "learn", title: "Learn", icon: "book", color: "#1E6B4F", tagline: "Money skills, one lesson at a time" },
  { id: "market", title: "Market", icon: "chart", color: "#1F5F7A", tagline: "$10,000 of practice money, real prices" },
  { id: "shop", title: "Shop", icon: "bag", color: "#A86F14", soon: true },
  { id: "friends", title: "Friends", icon: "people", color: "#B04530", soon: true },
  { id: "profile", title: "Profile", icon: "person", color: "#33403F", soon: true },
];

// Sample prices from the iPhone app, used if live prices can't load.
const SAMPLE = {
  AAPL: ["Apple Inc.", 212.34, 208.90], MSFT: ["Microsoft Corp.", 441.12, 438.50],
  GOOGL: ["Alphabet Inc.", 178.02, 180.11], AMZN: ["Amazon.com Inc.", 198.77, 195.30],
  TSLA: ["Tesla Inc.", 256.90, 264.10], NVDA: ["NVIDIA Corp.", 132.45, 128.77],
  META: ["Meta Platforms Inc.", 512.60, 508.20], NFLX: ["Netflix Inc.", 685.40, 690.15],
};
const LOGO = { AAPL: "#1F1C17", MSFT: "#1F5F7A", GOOGL: "#1E7350", AMZN: "#A86F14", TSLA: "#B04530", NVDA: "#3E7A2E", META: "#2F4F8A", NFLX: "#8E2A20" };

// ---------- icons (drawn to match the app's SF Symbols) ----------
const P = {
  book: '<path d="M2 5h6a4 4 0 0 1 4 4v11a3 3 0 0 0-3-3H2z"/><path d="M22 5h-6a4 4 0 0 0-4 4v11a3 3 0 0 1 3-3h7z"/>',
  chart: '<path d="M3 3v18h18"/><path d="M7 15l4-4 3 3 6-6"/>',
  bag: '<path d="M5 8h14l-1 13H6z"/><path d="M9 8V6a3 3 0 0 1 6 0v2"/>',
  people: '<circle cx="9" cy="8" r="3"/><path d="M3 20a6 6 0 0 1 12 0"/><circle cx="17" cy="9" r="2.5"/><path d="M16.5 14a5 5 0 0 1 4.5 6"/>',
  person: '<circle cx="12" cy="12" r="10"/><circle cx="12" cy="10" r="3"/><path d="M6.5 18.5a6 6 0 0 1 11 0"/>',
  check: '<path d="M5 12.5l4.5 4.5L19 7.5"/>',
  x: '<path d="M6 6l12 12M18 6L6 18"/>',
  heart: '<path fill="currentColor" stroke="none" d="M12 21s-7.5-4.6-9.5-9.3C1.1 8.3 3.3 4.5 7 4.5c2 0 3.5 1.1 5 3 1.5-1.9 3-3 5-3 3.7 0 5.9 3.8 4.5 7.2C19.5 16.4 12 21 12 21z"/>',
  flame: '<path d="M12 22c4 0 7-2.8 7-6.8 0-3.6-2.6-6-4-8.2-.6 2-1.6 3-3 3.5.4-3-1-6-3.5-8.5C8.8 6 5 9 5 15.2 5 19.2 8 22 12 22z"/>',
  star: '<path d="M12 3l2.7 5.6 6.1.9-4.4 4.3 1 6.1L12 17l-5.4 2.9 1-6.1-4.4-4.3 6.1-.9z"/>',
  level: '<circle cx="12" cy="9" r="6"/><path d="M8.5 14L7 22l5-3 5 3-1.5-8"/>',
  search: '<circle cx="11" cy="11" r="7"/><path d="M21 21l-5-5"/>',
  up: '<path d="M7 17L17 7M9 7h8v8"/>',
  down: '<path d="M7 7l10 10M17 9v8H9"/>',
  plus: '<path d="M12 5v14M5 12h14"/>',
  minus: '<path d="M5 12h14"/>',
  // lesson icons (SF Symbol name -> drawing)
  "chart.pie.fill": '<path d="M12 3a9 9 0 1 0 9 9h-9z"/><path d="M15 3.5A9 9 0 0 1 20.5 9H15z"/>',
  "cart.fill": '<circle cx="9" cy="20" r="1.5"/><circle cx="18" cy="20" r="1.5"/><path d="M2 3h3l2.5 12h11.5l2-8H6.2"/>',
  "banknote.fill": '<rect x="2" y="6" width="20" height="12" rx="2"/><circle cx="12" cy="12" r="2.5"/><path d="M6 9.5v.01M18 14.5v.01"/>',
  "building.columns.fill": '<path d="M3 10l9-6 9 6"/><path d="M5 10v8M9.5 10v8M14.5 10v8M19 10v8M3 20h18"/>',
  "tag.fill": '<path d="M3 12V4h8l10 10-8 8z"/><circle cx="7.5" cy="8.5" r="1.5"/>',
  percent: '<path d="M19 5L5 19"/><circle cx="7" cy="7" r="2.5"/><circle cx="17" cy="17" r="2.5"/>',
  "chart.line.uptrend.xyaxis": '<path d="M3 17l6-6 4 4 8-8"/><path d="M15 7h6v6"/>',
  "chart.line.downtrend.xyaxis": '<path d="M3 7l6 6 4-4 8 8"/><path d="M15 17h6v-6"/>',
  "briefcase.fill": '<rect x="3" y="7" width="18" height="13" rx="2"/><path d="M9 7V5a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v2M3 13h18"/>',
  speedometer: '<path d="M4 18a8 8 0 1 1 16 0"/><path d="M12 18l4-6"/>',
  "creditcard.fill": '<rect x="2" y="5" width="20" height="14" rx="2"/><path d="M2 10h20M6 15h4"/>',
  "arrow.up.arrow.down": '<path d="M7 4v16M3 8l4-4 4 4M17 20V4M13 16l4 4 4-4"/>',
};
const icon = (name) => `<svg class="i" viewBox="0 0 24 24" aria-hidden="true">${P[name] || P.book}</svg>`;

// ---------- helpers ----------
const esc = (s) => String(s).replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
const money = (n) => (n < 0 ? "-$" : "$") + Math.abs(n).toLocaleString("en-US", { minimumFractionDigits: 2, maximumFractionDigits: 2 });
const signedMoney = (n) => (n >= 0 ? "+" : "-") + money(Math.abs(n));
const el = (html) => { const t = document.createElement("template"); t.innerHTML = html.trim(); return t.content.firstElementChild; };
const dayKey = (d = new Date()) => d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
const pennyImg = (cls = "") => `<img src="penny.png" alt="Penny" class="${cls}">`;

function guilloche(lines = 16) {
  // Same curve as GuillochePattern.swift: two stacked sine waves per line.
  const W = 440, H = 260;
  let d = "";
  for (let i = 0; i < lines; i++) {
    const t = i / lines, baseY = H * (0.12 + 0.76 * t), phase = i * 0.42;
    for (let x = 0; x <= W; x += 4) {
      const u = (x / W) * Math.PI * 2;
      const y = baseY + 14 * Math.sin(u * 1.5 + phase) + 6 * Math.sin(u * 4 - phase * 1.7);
      d += (x ? "L" : "M") + x + " " + y.toFixed(1);
    }
  }
  return `<svg class="guil" viewBox="0 0 ${W} ${H}" preserveAspectRatio="none" aria-hidden="true"><path d="${d}"/></svg>`;
}

// ---------- saved progress (this browser only) ----------
function load(key, fallback) {
  try { const v = localStorage.getItem("invested-v2-" + key); return v ? JSON.parse(v) : fallback; } catch { return fallback; }
}
function save(key, value) { try { localStorage.setItem("invested-v2-" + key, JSON.stringify(value)); } catch {} }
const S = {
  xp: load("xp", 0), gold: load("gold", 0),
  streak: load("streak", { count: 0, day: null }),
  done: load("done", {}), // lessonId -> best correct
  pf: load("pf", { cash: STARTING_CASH, pos: {} }), // pos: symbol -> { n, cost }
  tipSeen: load("tipSeen", {}),
};
const level = () => Math.floor(S.xp / 100) + 1;
function streakNow() {
  const { count, day } = S.streak;
  if (!day) return 0;
  const y = new Date(); y.setDate(y.getDate() - 1);
  return day === dayKey() || day === dayKey(y) ? count : 0;
}
function bumpStreak() {
  const today = dayKey();
  if (S.streak.day === today) return;
  const y = new Date(); y.setDate(y.getDate() - 1);
  S.streak = { count: S.streak.day === dayKey(y) ? S.streak.count + 1 : 1, day: today };
  save("streak", S.streak);
}

const ALL = UNITS.flatMap((u, ui) => u.lessons.map((l, li) => ({ ...l, unit: u, ui, li })));
const currentLesson = () => ALL.find((l) => S.done[l.id] == null) || null;

// ---------- frame: header + tab bar ----------
let tab = "learn";

function drawTabbar() {
  tabbar.innerHTML = "";
  for (const t of TABS) {
    const b = el(`<button class="${t.id === tab ? "on" : ""} ${t.soon ? "soon" : ""}" style="--c:${t.color}" aria-label="${t.title}">
      <span class="ic">${icon(t.icon)}</span>${t.title}</button>`);
    b.onclick = () => {
      if (t.soon) return toast(`${t.title} is in the iPhone app. This demo has Learn and Market.`);
      go(t.id);
    };
    tabbar.append(b);
  }
}

function header(t, heroHTML, tip) {
  const showTip = tip && !S.tipSeen[t.id];
  const h = el(`<section class="hdr" style="--tab:${t.color}">${guilloche()}
    <div class="hdr-top"><div><h1>${t.title}</h1><p class="tag">${t.tagline}</p></div>
      <button class="avatar" aria-label="Penny's tip">${pennyImg()}</button></div>
    <div class="tip ${showTip ? "" : "hidden"}"><span><b>Penny:</b> ${tip || ""}</span></div>
    <div class="hero">${heroHTML}</div></section>`);
  h.querySelector(".avatar").onclick = () => {
    const box = h.querySelector(".tip");
    box.classList.toggle("hidden");
    S.tipSeen[t.id] = box.classList.contains("hidden");
    save("tipSeen", S.tipSeen);
  };
  return h;
}

function go(id) {
  tab = id;
  document.querySelector('meta[name="theme-color"]').content = TABS.find((t) => t.id === id).color;
  app.classList.remove("full");
  tabbar.classList.remove("hidden");
  drawTabbar();
  if (id === "learn") showLearn(); else showMarket();
  window.scrollTo(0, 0);
}

// ---------- Learn ----------
function showLearn() {
  const t = TABS[0];
  const cur = currentLesson();
  const unit = cur ? cur.unit : UNITS[UNITS.length - 1];
  const doneCount = ALL.filter((l) => S.done[l.id] != null).length;
  const hero = `
    <div class="unitline">${esc(unit.title)}<span>${doneCount} of ${ALL.length} lessons</span></div>
    <div class="track"><i style="width:${(doneCount / ALL.length) * 100}%"></i></div>
    <div class="chips">
      <div class="chip">${icon("flame")}<div><b>${streakNow()}</b><small>streak</small></div></div>
      <div class="chip">${icon("star")}<div><b>${S.xp}</b><small>XP</small></div></div>
      <div class="chip">${icon("level")}<div><b>${level()}</b><small>level</small></div></div>
      <div class="chip"><span class="coin"></span><div><b>${S.gold}</b><small>Gold</small></div></div>
    </div>`;
  app.innerHTML = "";
  app.append(header(t, hero, "Tap the glowing lesson to start. Each one takes about two minutes, and every answer comes with the why."));
  const content = el(`<div class="content"></div>`);
  UNITS.forEach((u, ui) => {
    const lessons = ALL.filter((l) => l.ui === ui);
    const n = lessons.filter((l) => S.done[l.id] != null).length;
    content.append(el(`<div class="unit" style="--u:${u.color}"><div style="flex:1;min-width:0">
      <div class="kicker">Unit ${ui + 1}</div><h2>${esc(u.title.replace(/^Unit \d+:\s*/, ""))}</h2>
      <p>${esc(u.subtitle)}</p>
      <div class="meta"><div class="track"><i style="width:${(n / lessons.length) * 100}%"></i></div>${n}/${lessons.length} · with Penny</div>
      </div><div class="pig">${pennyImg()}</div></div>`));
    content.append(pathFor(u, lessons, cur));
  });
  content.append(el(`<p class="foot">This demo has the first 3 of InvestEd's 12 units. The iPhone app adds the placement test, options trading, friends, leagues and the shop.<br>
    Practice money only. Not financial advice. <a href="https://github.com/EliasDweiri/InvestEd">Source on GitHub</a> · <a href="../index.html">About InvestEd</a></p>`));
  app.append(content);
  if (cur && cur.li > 0) {
    const node = app.querySelector(`[data-id="${cur.id}"]`);
    if (node) setTimeout(() => node.scrollIntoView({ block: "center", behavior: "instant" }), 0);
  }
}

function pathFor(u, lessons, cur) {
  const OFF = [0, -64, -34, 44, 70, 18];   // zig-zag like the app's path
  const STEP = 142, TOP = 46;
  const box = el(`<div class="path" style="--h:${TOP + lessons.length * STEP - 20}px;--u:${u.color}"></div>`);
  const pts = lessons.map((_, i) => [OFF[i % OFF.length], TOP + i * STEP + 35]);
  const d = pts.map(([x, y], i) => (i ? "L" : "M") + x + " " + y).join(" ");
  const H = TOP + lessons.length * STEP;
  box.append(el(`<svg class="line" width="400" height="${H}" viewBox="-200 0 400 ${H}"><path d="${d}"/></svg>`));
  lessons.forEach((l, i) => {
    const state = S.done[l.id] != null ? "done" : cur && cur.id === l.id ? "cur" : "next";
    const node = el(`<button class="node ${state}" data-id="${l.id}" style="left:calc(50% + ${pts[i][0]}px);top:${TOP + i * STEP}px" aria-label="${esc(l.title)}">
      ${state === "cur" ? `<span class="start">START +${LESSON_XP} XP</span>` : ""}
      <span class="disc">${icon(state === "done" ? "check" : l.icon)}</span>
      <span class="label">${esc(l.title)}</span></button>`);
    node.onclick = () => startLesson(l);
    box.append(node);
  });
  return box;
}

// ---------- Lesson player ----------
let run;

function startLesson(lesson) {
  run = { lesson, i: 0, correct: 0, hearts: 5, startLevel: level() };
  app.classList.add("full");
  tabbar.classList.add("hidden");
  showQuestion();
}

function showQuestion() {
  const { lesson, i } = run;
  const q = lesson.questions[i];
  const sub = { mc: "Choose one answer.", tf: "True or false?", ms: "Choose all that apply.", num: "Type your answer." }[q.type];
  app.innerHTML = "";
  window.scrollTo(0, 0);
  const view = el(`<div class="lesson">
    <div class="ltop"><button class="x" aria-label="Quit lesson">${icon("x")}</button>
      <div class="lbar"><i style="width:${(i / lesson.questions.length) * 100}%"></i></div>
      <div class="hearts" aria-label="${run.hearts} hearts left">${[0, 1, 2, 3, 4].map((h) => `<span class="${h < run.hearts ? "" : "lost"}">${icon("heart")}</span>`).join("")}</div></div>
    <h2 class="qtitle">${esc(q.prompt.replace(/\s*\(Choose all that apply\.\)\s*$/i, ""))}</h2>
    <p class="qsub">${sub}</p>
    <div class="answers"></div>
    <div class="spacer"></div>
    <div class="cta"><button class="btn check" disabled>Check</button></div></div>`);
  view.querySelector(".x").onclick = () => go("learn");
  const answers = view.querySelector(".answers");
  const check = view.querySelector(".check");
  let picked = q.type === "ms" ? new Set() : null;

  if (q.type === "num") {
    const box = el(`<label class="numbox">${q.prefix ? `<span>${esc(q.prefix)}</span>` : ""}<input type="text" inputmode="decimal" autocomplete="off" placeholder="0" aria-label="Your answer"></label>`);
    const input = box.querySelector("input");
    input.oninput = () => {
      input.value = input.value.replace(/[^0-9.,-]/g, "").slice(0, 12);
      input.style.width = Math.max(1, input.value.length) * 0.62 + 0.3 + "em";
      check.disabled = input.value.trim() === "";
    };
    input.onkeydown = (e) => { if (e.key === "Enter" && !check.disabled) check.click(); };
    box.onclick = () => input.focus();
    answers.append(box);
    setTimeout(() => input.focus(), 50);
  } else {
    const choices = q.type === "tf" ? ["True", "False"] : q.choices;
    const wrap = el(`<div class="${q.type === "tf" ? "tf" : "opts"}"></div>`);
    choices.forEach((text, idx) => {
      const b = el(`<button class="opt ${q.type === "ms" ? "box" : ""}"><span class="mark">${icon("check")}</span><span>${esc(text)}</span></button>`);
      b.onclick = () => {
        if (run.answered) return;
        if (q.type === "ms") {
          picked.has(idx) ? picked.delete(idx) : picked.add(idx);
          b.classList.toggle("sel");
          check.disabled = picked.size === 0;
        } else {
          wrap.querySelectorAll(".opt").forEach((o) => o.classList.remove("sel"));
          b.classList.add("sel");
          picked = idx;
          check.disabled = false;
        }
      };
      wrap.append(b);
    });
    answers.append(wrap);
  }

  run.answered = false;
  check.onclick = () => {
    const right = isCorrect(q, picked, view);
    run.answered = true;
    if (right) run.correct++;
    else {
      run.hearts--;
      const hs = view.querySelectorAll(".hearts span");
      if (hs[run.hearts]) hs[run.hearts].classList.add("lost");
      view.querySelector(".hearts").classList.add("shake");
    }
    mark(q, view, picked, right);
    feedback(q, right);
  };
  app.append(view);
}

function isCorrect(q, picked, view) {
  if (q.type === "mc") return picked === q.correct;
  if (q.type === "tf") return (picked === 0) === q.answer;
  if (q.type === "ms") return picked.size === q.correct.length && q.correct.every((c) => picked.has(c));
  const v = parseFloat(view.querySelector("input").value.replace(/,/g, ""));
  return Math.abs(v - q.answer) <= (q.tolerance || 0) + 1e-9;
}

function mark(q, view, picked, right) {
  const opts = [...view.querySelectorAll(".opt")];
  const rightIdx = q.type === "mc" ? [q.correct] : q.type === "tf" ? [q.answer ? 0 : 1] : q.type === "ms" ? q.correct : [];
  opts.forEach((o, idx) => {
    o.classList.remove("sel");
    const chosen = q.type === "ms" ? picked.has(idx) : picked === idx;
    if (rightIdx.includes(idx) && (chosen || !right)) o.classList.add("right");
    else if (chosen) { o.classList.add("wrong"); o.querySelector(".mark").innerHTML = icon("x"); }
  });
  const nb = view.querySelector(".numbox");
  if (nb) { nb.classList.add(right ? "right" : "wrong"); nb.querySelector("input").disabled = true; }
  view.querySelector(".check").classList.add("hidden");
}

function feedback(q, right) {
  const praise = ["Nice!", "Exactly!", "You got it!", "Correct!", "Great job!"];
  const last = run.i + 1 >= run.lesson.questions.length;
  const out = !right && run.hearts <= 0;
  const answer = q.type === "num" && !right ? `The answer is ${esc(q.prefix || "")}${Number(q.answer).toLocaleString("en-US")}. ` : "";
  const sh = el(`<div class="sheet ${right ? "good" : "bad"}" role="status">
    <h3><span class="badge">${icon(right ? "check" : "x")}</span>${right ? praise[run.i % praise.length] : "Not quite"}</h3>
    <p>${answer}${esc(q.explanation)}</p>
    <button class="btn">${out ? "Continue" : last ? "Finish lesson" : "Continue"}</button></div>`);
  document.body.append(sh);
  requestAnimationFrame(() => requestAnimationFrame(() => sh.classList.add("show")));
  sh.querySelector(".btn").focus({ preventScroll: true });
  sh.querySelector(".btn").onclick = () => {
    sh.remove();
    if (out) return showOutOfHearts();
    run.i++;
    if (run.i < run.lesson.questions.length) showQuestion(); else showComplete();
  };
}

function showOutOfHearts() {
  app.innerHTML = "";
  const v = el(`<div class="result"><div class="bigpig" style="box-shadow:0 0 0 10px color-mix(in srgb,var(--red) 15%,transparent)">${pennyImg()}</div>
    <h2>Out of hearts</h2><p>Penny says: mistakes are how money lessons stick. Give “${esc(run.lesson.title)}” another try.</p>
    <div class="spacer"></div><div class="cta"><button class="btn">Try again</button><button class="btn ghost">Back to the path</button></div></div>`);
  v.querySelector(".btn").onclick = () => startLesson(run.lesson);
  v.querySelector(".ghost").onclick = () => go("learn");
  app.append(v);
}

function showComplete() {
  const { lesson, correct } = run;
  const total = lesson.questions.length;
  const first = S.done[lesson.id] == null;
  const xp = first ? LESSON_XP : 5;            // replays still earn a little
  const gold = first ? correct * 2 + (correct === total ? 5 : 0) : 0;
  S.xp += xp; S.gold += gold;
  S.done[lesson.id] = Math.max(S.done[lesson.id] || 0, correct);
  bumpStreak();
  save("xp", S.xp); save("gold", S.gold); save("done", S.done);
  const leveled = level() > run.startLevel;
  app.innerHTML = "";
  const v = el(`<div class="result"><div class="bigpig">${pennyImg()}</div>
    <h2>${correct === total ? "Perfect lesson!" : "Lesson complete!"}</h2>
    <p>${esc(lesson.title)} · ${esc(lesson.unit.title.replace(/^Unit \d+:\s*/, ""))}</p>
    <div class="pills">
      <div class="pill" style="--pc:var(--gold)"><small>XP</small><b>${icon("star")}+${xp}</b></div>
      ${gold ? `<div class="pill" style="--pc:var(--shop)"><small>Gold</small><b><span class="coin"></span>+${gold}</b></div>` : ""}
      <div class="pill" style="--pc:var(--green)"><small>Correct</small><b>${correct}/${total}</b></div>
    </div>
    ${leveled ? `<div class="levelup">Level ${level()}!</div>` : ""}
    <div class="spacer"></div><div class="cta"><button class="btn">Continue</button></div></div>`);
  v.querySelector(".btn").onclick = () => go("learn");
  app.append(v);
}

// ---------- Market ----------
let quotes = null, live = false, filter = "";

async function loadQuotes() {
  const res = await Promise.all(Object.keys(SAMPLE).map(async (s) => {
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
  quotes = Object.fromEntries(res.map(([s, q]) => [s, q]));
  live = res.every((r) => r[2]);
}

async function showMarket() {
  if (!quotes) {
    drawMarket(true);
    await loadQuotes();
    if (tab !== "market" || app.classList.contains("full")) return;
  }
  drawMarket();
}

function drawMarket(loading) {
  const t = TABS[1];
  const pf = S.pf;
  const stocks = loading ? 0 : Object.entries(pf.pos).reduce((s, [k, p]) => s + p.n * quotes[k].price, 0);
  const total = pf.cash + stocks;
  const chg = total - STARTING_CASH;
  const hero = `<div class="kicker">Portfolio value</div>
    <div class="big">${loading ? money(pf.cash + Object.values(pf.pos).reduce((s, p) => s + p.cost, 0)) : money(total)}</div>
    <span class="chg">${icon(chg >= 0 ? "up" : "down")}${signedMoney(chg)} (${((chg / STARTING_CASH) * 100).toFixed(2)}%) all-time</span>
    <div class="chips two">
      <div class="chip">${icon("banknote.fill")}<div><b>${money(pf.cash)}</b><small>cash</small></div></div>
      <div class="chip">${icon("up")}<div><b>${loading ? "…" : money(stocks)}</b><small>stocks</small></div></div></div>`;
  app.innerHTML = "";
  app.append(header(t, hero, "Every trade here uses real prices and fake money. Tap a stock to buy your first share."));
  const content = el(`<div class="content"></div>`);
  const search = el(`<label class="card search">${icon("search")}<input type="search" placeholder="Search stocks — AAPL, Tesla…" value="${esc(filter)}" aria-label="Search stocks"></label>`);
  content.append(search);

  if (loading) {
    content.append(el(`<div class="card empty">Loading prices…</div>`));
    app.append(content);
    return;
  }

  const held = Object.entries(pf.pos);
  content.append(el(`<div class="kicker sec">Your holdings</div>`));
  const hold = el(`<div class="card list"></div>`);
  if (!held.length) hold.append(el(`<div class="empty">No stocks yet. Pick one below to make your first trade.</div>`));
  for (const [s, p] of held) {
    const q = quotes[s], val = p.n * q.price, gain = val - p.cost;
    const row = el(`<button class="row"><span class="logo" style="background:${LOGO[s]}">${s.slice(0, 4)}</span>
      <span class="l"><span class="sym">${s}</span><span class="nm">${p.n} share${p.n === 1 ? "" : "s"} · avg ${money(p.cost / p.n)}</span></span>
      <span class="r"><span class="px">${money(val)}</span><small class="${gain >= 0 ? "up" : "down"}">${signedMoney(gain)}</small></span></button>`);
    row.onclick = () => openTrade(s, "sell");
    hold.append(row);
  }
  content.append(hold);

  content.append(el(`<div class="kicker sec">Popular stocks</div>`));
  const list = el(`<div class="card list"></div>`);
  const drawList = () => {
    list.innerHTML = "";
    const f = filter.trim().toLowerCase();
    const rows = Object.entries(quotes).filter(([s, q]) => !f || s.toLowerCase().includes(f) || q.name.toLowerCase().includes(f));
    if (!rows.length) list.append(el(`<div class="empty">No match. The demo has 8 popular stocks; the app searches every U.S. ticker.</div>`));
    for (const [s, q] of rows) {
      const pct = ((q.price - q.prev) / q.prev) * 100;
      const row = el(`<button class="row"><span class="logo" style="background:${LOGO[s]}">${s.slice(0, 4)}</span>
        <span class="l"><span class="sym">${s}</span><span class="nm">${esc(q.name)}</span></span>
        <span class="r"><span class="px">${money(q.price)}</span><small class="${pct >= 0 ? "up" : "down"}">${pct >= 0 ? "+" : ""}${pct.toFixed(2)}%</small></span></button>`);
      row.onclick = () => openTrade(s, "buy");
      list.append(row);
    }
  };
  search.querySelector("input").oninput = (e) => { filter = e.target.value; drawList(); };
  drawList();
  content.append(list);

  const note = el(`<p class="note">${live ? "Live prices from Finnhub." : "Sample prices — live prices couldn't load."} Practice money only, never real.<br><button>Reset portfolio to $10,000</button></p>`);
  note.querySelector("button").onclick = () => {
    S.pf = { cash: STARTING_CASH, pos: {} }; save("pf", S.pf); drawMarket(); toast("Portfolio reset to $10,000.");
  };
  content.append(note);
  app.append(content);
}

function openTrade(sym, side) {
  const q = quotes[sym];
  const scrim = el(`<div class="scrim"></div>`);
  const sh = el(`<div class="trade" role="dialog" aria-label="Trade ${sym}"><div class="grab"></div>
    <div class="head"><span class="logo" style="background:${LOGO[sym]}">${sym.slice(0, 4)}</span>
      <div><h3>${sym}</h3><div class="nm" style="color:var(--muted);font-size:14px">${esc(q.name)}</div></div>
      <button class="x" aria-label="Close">${icon("x")}</button></div>
    <div class="big" style="font-size:36px;margin:16px 0 4px">${money(q.price)}</div>
    <div class="${q.price >= q.prev ? "up" : "down"}" style="font-weight:600;font-size:14px">${signedMoney(q.price - q.prev)} (${(((q.price - q.prev) / q.prev) * 100).toFixed(2)}%) today</div>
    <div class="seg"><button data-s="buy">Buy</button><button data-s="sell">Sell</button></div>
    <div class="card stepper"><button class="m" aria-label="Fewer shares">${icon("minus")}</button>
      <input type="text" inputmode="numeric" value="1" aria-label="Shares"><button class="p" aria-label="More shares">${icon("plus")}</button></div>
    <div class="kv"><span>Estimated total</span><b class="tot"></b></div>
    <div class="kv"><span class="availL"></span><b class="avail"></b></div>
    <button class="btn go"></button></div>`);
  document.body.append(scrim, sh);
  requestAnimationFrame(() => requestAnimationFrame(() => { scrim.classList.add("show"); sh.classList.add("show"); }));
  const close = () => { scrim.classList.remove("show"); sh.classList.remove("show"); setTimeout(() => { scrim.remove(); sh.remove(); }, 280); };
  scrim.onclick = close;
  sh.querySelector(".x").onclick = close;
  const input = sh.querySelector("input");
  const n = () => Math.max(0, Math.floor(Number(input.value) || 0));
  const update = () => {
    const owned = S.pf.pos[sym]?.n || 0;
    sh.querySelectorAll(".seg button").forEach((b) => b.classList.toggle("on", b.dataset.s === side));
    sh.querySelector(".tot").textContent = money(n() * q.price);
    sh.querySelector(".availL").textContent = side === "buy" ? "Cash available" : "Shares you own";
    sh.querySelector(".avail").textContent = side === "buy" ? money(S.pf.cash) : owned;
    const go = sh.querySelector(".go");
    go.style.setProperty("--b", side === "buy" ? "var(--green)" : "var(--red)");
    const ok = n() > 0 && (side === "buy" ? n() * q.price <= S.pf.cash + 1e-9 : n() <= owned);
    go.disabled = !ok;
    go.textContent = n() === 0 ? "Choose shares"
      : !ok ? (side === "buy" ? "Not enough cash" : `You own ${owned} share${owned === 1 ? "" : "s"}`)
      : `${side === "buy" ? "Buy" : "Sell"} ${n()} ${sym} for ${money(n() * q.price)}`;
  };
  sh.querySelectorAll(".seg button").forEach((b) => (b.onclick = () => { side = b.dataset.s; update(); }));
  sh.querySelector(".m").onclick = () => { input.value = Math.max(1, n() - 1); update(); };
  sh.querySelector(".p").onclick = () => { input.value = n() + 1; update(); };
  input.oninput = () => { input.value = input.value.replace(/\D/g, "").slice(0, 6); update(); };
  sh.querySelector(".go").onclick = () => {
    const k = n(), pf = S.pf, pos = pf.pos[sym] || { n: 0, cost: 0 };
    if (side === "buy") {
      pf.cash = Math.round((pf.cash - k * q.price) * 100) / 100;
      pf.pos[sym] = { n: pos.n + k, cost: pos.cost + k * q.price };
      if (!load("firstTrade", false)) { save("firstTrade", true); S.xp += 10; save("xp", S.xp); }
    } else {
      pf.cash = Math.round((pf.cash + k * q.price) * 100) / 100;
      const left = pos.n - k;
      if (left > 0) pf.pos[sym] = { n: left, cost: pos.cost * (left / pos.n) }; else delete pf.pos[sym];
    }
    save("pf", pf);
    close();
    drawMarket();
    toast(`${side === "buy" ? "Bought" : "Sold"} ${k} ${sym} at ${money(q.price)}.`);
  };
  update();
}

let toastTimer;
function toast(msg) {
  let t = document.querySelector(".toast");
  if (!t) { t = el(`<div class="toast" role="status"></div>`); document.body.append(t); }
  t.textContent = msg;
  requestAnimationFrame(() => t.classList.add("show"));
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => t.classList.remove("show"), 2600);
}

go("learn");
