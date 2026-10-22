---
name: explain-as-you-build
description: Use whenever code is written or changed in Marsa. Creates the required beginner-friendly Arabic explanation in .local/learn/ before the work can be considered done.
---

# Explain as you build

## Rule

Every code change — by a human or an AI agent — needs a private Arabic explanation **before it counts as done**.

The file is:

```text
.local/learn/NNN-<issue-or-topic>.ar.md
```

Use the next unused number. Keep the issue slug or a short topic slug. Examples:

```text
001-m0-01-solution-skeleton.ar.md
002-m0-02-health-endpoints.ar.md
003-rollback-state-machine.ar.md
```

The file is **local only**:

- never commit it;
- never push it;
- never link it from public docs;
- never include it in a release artifact;
- never paste secrets, private URLs, hostnames, or `.env` values into it.

## When to use

Use this skill when a task:

- adds or changes C#, Razor, SQL, Docker, Caddy, shell, or configuration code;
- adds a migration, endpoint, worker, test fixture, or deployment step;
- fixes a bug whose cause is not obvious to a beginner;
- changes a user-visible behavior that the owner will need to understand.

Do **not** require a new explanation for a docs-only typo or link fix. If a docs change teaches a new engineering concept, add a short explanation when the owner asks.

## Required structure

Use these headings in Arabic:

```markdown
# NNN — العنوان

> التاريخ: YYYY-MM-DD
> المهمة: <issue or topic>
> الحالة: مكتمل / جزئي

## ما تغيّر ولماذا
## المفهوم الجديد من الصفر
## جولة ملفًا بملف
## كيف تشغّله
## كيف تختبره
## ما الذي قد يخطئ
## اختبار سريع
<details><summary>الإجابات</summary>...</details>
## ماذا تقرأ بعد ذلك
```

### 1. ما تغيّر ولماذا

State the user-visible or operational change in two or three sentences. Then explain why it was needed. Name the issue and requirement IDs when they exist.

Bad:

> أضفت خدمة جديدة.

Good:

> أضفنا فحصًا لصحة التطبيق قبل تحويل الزائر إليه. السبب أن النشر القديم يجب أن يبقى يعمل إذا فشل الجديد، بدل أن يرى المستخدم صفحة خطأ.

### 2. المفهوم الجديد من الصفر

Pick the one or two concepts a beginner cannot infer from the diff. Explain each from zero with an everyday analogy.

Examples of useful analogies:

- deployment state machine → a queue ticket that moves through defined counters, never jumps backward;
- health check → knocking on the door and waiting for an answer before opening it to guests;
- immutable snapshot → a sealed shipping manifest; later edits create a new manifest;
- worker lease → a time-limited key to a storage room; if the holder disappears, the key expires;
- envelope encryption → a locked box plus a separate key kept somewhere else;
- reverse proxy → a receptionist who sends each visitor to the right room;
- Docker socket → a master key to the building, not a guest key.

Do not use a second unexplained technical term inside the explanation.

### 3. جولة ملفًا بملف

For every changed file, write:

- the path;
- what it is responsible for;
- what changed;
- why the change belongs there;
- one thing that would break if the file were wrong.

Keep it short. Do not paste the entire diff. A 15-line excerpt is enough when it illustrates the idea.

### 4. كيف تشغّله

Give the exact command from the repository root. State:

- prerequisites;
- the command;
- what the owner should see;
- how long it normally takes;
- the first place to look if it fails.

Example:

```bash
python3 scripts/check-docs.py
```

Expected:

```text
Documentation checks passed (... Markdown files).
```

### 5. كيف تختبره

Give a concrete manual test and one failure test. Prefer a command the owner can copy.

For each test, state:

- setup;
- action;
- expected result;
- what a failure looks like.

If the feature cannot be tested yet, say so and give the closest check that does work. Never invent a passing result.

### 6. ما الذي قد يخطئ

List realistic failure modes, not generic warnings:

- wrong configuration;
- missing permission;
- port already in use;
- database not ready;
- health check too short for a cold start;
- old container still holding a port;
- route applied before health passed;
- secret redaction missing in one log path.

For each, state how to recognize it and the safest next action.

### 7. اختبار سريع

Write exactly three questions:

1. one recall question (what is the concept?);
2. one application question (what happens in this situation?);
3. one failure question (how do you detect or recover?).

Put answers in a collapsed block:

```markdown
<details>
<summary>الإجابات</summary>

1. ...
2. ...
3. ...

</details>
```

### 8. ماذا تقرأ بعد ذلك

Link to the next public document, issue, or explanation. Use public repository paths only. Do not link to `.local/`.

## Writing style

- Modern Standard Arabic. Natural, not a word-for-word translation.
- Short paragraphs. One idea per paragraph.
- Explain an English term on first use: `health check (فحص الصحة)`.
- Keep commands, paths, code, and logs LTR.
- Use Arabic punctuation consistently.
- Prefer a concrete example over an abstract definition.
- Admit uncertainty. "لم نجرّب هذا بعد" is better than a false claim.

## Verification before completion

- [ ] The file exists at `.local/learn/NNN-<issue-or-topic>.ar.md`.
- [ ] All eight sections are present.
- [ ] The command and expected output are exact.
- [ ] At least one failure path is explained.
- [ ] Three questions and answers are present.
- [ ] No secret or private URL appears.
- [ ] No public document links to the file.
- [ ] The file is ignored by Git (`git check-ignore -v .local/learn/<file>`).

## Reporting

In the final task report, include:

```text
Explanation: .local/learn/NNN-<issue-or-topic>.ar.md
```

Do not mark the task done if the explanation is missing.
