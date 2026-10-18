#!/usr/bin/env python3
"""
InvestEd content generator.

Reads one JSON file per learning unit from content_src/units/ (sorted by
filename, which controls unit order on the Learn path) and emits a single
Swift file, LessonContentData.swift, built from the type-safe Question/Lesson
factories in LearningModels.swift.

Each unit's gate is a 15-question "Knowledge Check" that this script builds
AUTOMATICALLY by sampling three questions from each of the five lessons — so it
always covers the whole unit and always reuses already-correct questions. Any
"finalTest" in the source JSON is ignored.

Question JSON shapes (the "type" key selects the format):
  mc    {type,id,prompt,choices:[...],correct:int,explanation}
  tf    {type,id,prompt,answer:bool,explanation}
  ms    {type,id,prompt,choices:[...],correct:[int...],explanation}
  order {type,id,prompt,items:[...ordered...],explanation}
  match {type,id,prompt,pairs:[[left,right]...],explanation}
  num   {type,id,prompt,answer:num,tolerance:num,prefix?,suffix?,slider?,min?,max?,step?,explanation}
  cat   {type,id,prompt,categories:[...],items:[[text,category]...],explanation}
  opt   {type,id,prompt,symbol,company,spot,scenario,kind:"call"|"put",target,success,explanation}
"""

import copy
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
UNITS_DIR = os.path.join(ROOT, "content_src", "units")
OUT_PATH = os.path.join(ROOT, "InvestEd", "Con-Mod-Ser-Uti-VMo", "Content", "LessonContentData.swift")

# Which question index to pull from each 7-question lesson for the Knowledge
# Check (3 per lesson x 5 lessons = 15).
KC_PICKS = [1, 3, 5]


def s(value):
    if value is None:
        value = ""
    text = str(value)
    text = text.replace("\\", "\\\\").replace('"', '\\"')
    text = text.replace("\n", "\\n").replace("\t", "\\t").replace("\r", "")
    return '"' + text + '"'


def num(value):
    f = float(value)
    return str(int(f)) if f == int(f) else repr(f)


def gen_question(q, indent="                        "):
    t = q["type"]
    qid = s(q["id"])
    prompt = s(q["prompt"])
    expl = s(q["explanation"])
    i = indent

    if t == "mc":
        choices = ",\n".join(f'{i}    AnswerChoice(id: {n}, text: {s(c)})' for n, c in enumerate(q["choices"]))
        return (f'{i}.multipleChoice(id: {qid}, prompt: {prompt},\n'
                f'{i}    choices: [\n{choices}\n{i}    ], correct: {q["correct"]},\n'
                f'{i}    explanation: {expl})')
    if t == "tf":
        return (f'{i}.trueFalse(id: {qid}, prompt: {prompt}, '
                f'correctIsTrue: {"true" if q["answer"] else "false"},\n{i}    explanation: {expl})')
    if t == "ms":
        choices = ",\n".join(f'{i}    AnswerChoice(id: {n}, text: {s(c)})' for n, c in enumerate(q["choices"]))
        ids = ", ".join(str(x) for x in q["correct"])
        return (f'{i}.multiSelect(id: {qid}, prompt: {prompt},\n'
                f'{i}    choices: [\n{choices}\n{i}    ], correctIDs: [{ids}],\n{i}    explanation: {expl})')
    if t == "order":
        items = ",\n".join(f'{i}    {s(x)}' for x in q["items"])
        return (f'{i}.ordering(id: {qid}, prompt: {prompt},\n{i}    items: [\n{items}\n{i}    ],\n{i}    explanation: {expl})')
    if t == "match":
        pairs = ",\n".join(f'{i}    MatchPair(id: {n}, left: {s(p[0])}, right: {s(p[1])})' for n, p in enumerate(q["pairs"]))
        return (f'{i}.matching(id: {qid}, prompt: {prompt},\n{i}    pairs: [\n{pairs}\n{i}    ],\n{i}    explanation: {expl})')
    if t == "num":
        parts = [f'id: {qid}', f'prompt: {prompt}', f'answer: {num(q["answer"])}', f'tolerance: {num(q["tolerance"])}']
        if q.get("prefix"):
            parts.append(f'prefix: {s(q["prefix"])}')
        if q.get("suffix"):
            parts.append(f'suffix: {s(q["suffix"])}')
        if q.get("slider"):
            parts += ['slider: true', f'min: {num(q.get("min", 0))}', f'max: {num(q.get("max", 100))}', f'step: {num(q.get("step", 1))}']
        return (f'{i}.numeric({", ".join(parts)},\n{i}    explanation: {expl})')
    if t == "cat":
        cats = ", ".join(s(c) for c in q["categories"])
        items = ",\n".join(f'{i}    CategoryItem(id: {n}, text: {s(it[0])}, correctCategory: {s(it[1])})' for n, it in enumerate(q["items"]))
        return (f'{i}.categorize(id: {qid}, prompt: {prompt},\n{i}    categories: [{cats}],\n{i}    items: [\n{items}\n{i}    ],\n{i}    explanation: {expl})')
    if t == "opt":
        return (f'{i}.interactiveOption(id: {qid}, prompt: {prompt},\n'
                f'{i}    challenge: OptionChallenge(symbol: {s(q["symbol"])}, companyName: {s(q["company"])}, spot: {num(q["spot"])},\n'
                f'{i}        scenario: {s(q["scenario"])}, requiredKind: .{q["kind"]}, targetPrice: {num(q["target"])},\n'
                f'{i}        successNote: {s(q["success"])}),\n{i}    explanation: {expl})')
    raise ValueError(f'Unknown question type {t!r} in {q.get("id")}')


def gen_lesson(lesson, is_final=False):
    qs = ",\n".join(gen_question(q) for q in lesson["questions"])
    xp = lesson.get("xp")
    xp = str(xp) if isinstance(xp, int) else "Constants.xpPerLesson"
    final_flag = ", isFinalTest: true" if is_final else ""
    return (f'                Lesson(\n'
            f'                    id: {s(lesson["id"])},\n'
            f'                    title: {s(lesson["title"])},\n'
            f'                    iconName: {s(lesson["icon"])},\n'
            f'                    questions: [\n{qs}\n                    ],\n'
            f'                    xpReward: {xp}{final_flag}\n                )')


def topic_of(title):
    """'Unit 7: Paychecks & Taxes' -> 'Paychecks & Taxes'."""
    if ":" in title:
        head, rest = title.split(":", 1)
        if head.strip().lower().startswith("unit"):
            return rest.strip()
    return title.strip()


def build_knowledge_check(unit):
    """Assemble the 15-question Knowledge Check by sampling each lesson."""
    picked = []
    for lesson in unit["lessons"]:
        qs = lesson["questions"]
        for idx in KC_PICKS:
            if idx < len(qs):
                clone = copy.deepcopy(qs[idx])
                clone["id"] = clone["id"] + "-kc"
                picked.append(clone)
    topic = topic_of(unit["title"])
    return {
        "id": unit["id"] + "-check",
        "title": f"{topic}: Knowledge Check",
        "icon": "checkmark.seal.fill",
        "xp": 60,
        "questions": picked,
    }


def gen_unit(unit, position):
    title = f"Unit {position}: {topic_of(unit['title'])}"
    lessons = ",\n".join(gen_lesson(l) for l in unit["lessons"])
    kc = gen_lesson(build_knowledge_check(unit), is_final=True)
    return (f'    private static let {unit["constName"]} = LearningUnit(\n'
            f'            id: {s(unit["id"])},\n'
            f'            title: {s(title)},\n'
            f'            subtitle: {s(unit["subtitle"])},\n'
            f'            colorHex: {s(unit["colorHex"])},\n'
            f'            lessons: [\n{lessons}\n            ],\n'
            f'            finalTest:\n{kc}\n        )')


def check_question(q, loc, problems):
    t = q.get("type")
    if t == "mc":
        if not (0 <= q.get("correct", -1) < len(q.get("choices", []))):
            problems.append(f"{loc}: mc 'correct' index out of range")
    elif t == "tf":
        if not isinstance(q.get("answer"), bool):
            problems.append(f"{loc}: tf 'answer' must be true/false")
    elif t == "ms":
        n = len(q.get("choices", []))
        correct = q.get("correct", [])
        if not correct or any(not (0 <= c < n) for c in correct):
            problems.append(f"{loc}: ms 'correct' empty or out of range")
    elif t == "order":
        if len(q.get("items", [])) < 2:
            problems.append(f"{loc}: order needs >= 2 items")
    elif t == "match":
        if len(q.get("pairs", [])) < 2 or any(len(p) != 2 for p in q.get("pairs", [])):
            problems.append(f"{loc}: match needs >= 2 [left,right] pairs")
    elif t == "num":
        if q.get("answer") is None:
            problems.append(f"{loc}: num missing 'answer'")
    elif t == "cat":
        cats = set(q.get("categories", []))
        if len(cats) < 2:
            problems.append(f"{loc}: cat needs >= 2 categories")
        for it in q.get("items", []):
            if len(it) != 2 or it[1] not in cats:
                problems.append(f"{loc}: cat item {it} category not in {sorted(cats)}")
    elif t == "opt":
        if q.get("kind") not in ("call", "put"):
            problems.append(f"{loc}: opt 'kind' must be call or put")
    else:
        problems.append(f"{loc}: unknown type {t!r}")


def main():
    files = sorted(f for f in os.listdir(UNITS_DIR) if f.endswith(".json"))
    if not files:
        print("No unit JSON files in", UNITS_DIR, file=sys.stderr)
        sys.exit(1)

    units = []
    for fname in files:
        with open(os.path.join(UNITS_DIR, fname)) as fh:
            try:
                units.append(json.load(fh))
            except json.JSONDecodeError as e:
                print(f"JSON error in {fname}: {e}", file=sys.stderr)
                sys.exit(1)

    seen_ids = set()
    problems = []
    for u in units:
        if len(u["lessons"]) != 5:
            problems.append(f"{u['id']}: expected 5 lessons, got {len(u['lessons'])}")
        for l in u["lessons"]:
            if len(l["questions"]) != 7:
                problems.append(f"{l['id']}: expected 7 questions, got {len(l['questions'])}")
            if l["id"] in seen_ids:
                problems.append(f"Duplicate lesson id {l['id']}")
            seen_ids.add(l["id"])
            for q in l["questions"]:
                if q["id"] in seen_ids:
                    problems.append(f"Duplicate question id {q['id']}")
                seen_ids.add(q["id"])
                check_question(q, q.get("id", l["id"]), problems)

    if problems:
        print(f"Content validation found {len(problems)} problem(s):", file=sys.stderr)
        for p in problems[:80]:
            print("  - " + p, file=sys.stderr)
        sys.exit(1)

    array_entries = ",\n".join(f'        {u["constName"]}' for u in units)
    unit_blocks = "\n\n".join(gen_unit(u, i + 1) for i, u in enumerate(units))

    header = (
        "import Foundation\n\n"
        "// !!! GENERATED FILE — do not edit by hand. !!!\n"
        "// Source of truth: content_src/units/*.json  (regenerate: python3 tools/gen_content.py)\n"
        "//\n"
        "// Twelve units. Each has five lessons (seven questions each) plus a\n"
        "// 15-question Knowledge Check — auto-assembled from all five lessons —\n"
        "// that gates the next unit. Questions span eight interactive formats.\n"
        "enum LessonContentData {\n"
        f"    static let units: [LearningUnit] = [\n{array_entries}\n    ]\n\n"
        f"{unit_blocks}\n"
        "}\n"
    )
    with open(OUT_PATH, "w") as fh:
        fh.write(header)

    lesson_q = sum(len(l["questions"]) for u in units for l in u["lessons"])
    print(f"Wrote {OUT_PATH}")
    print(f"Units: {len(units)}  Lessons: {sum(len(u['lessons']) for u in units)}  "
          f"Lesson questions: {lesson_q}  Knowledge Checks: {len(units)} x 15 = {len(units) * 15}")


if __name__ == "__main__":
    main()
