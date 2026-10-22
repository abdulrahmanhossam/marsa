# Definition of Done

> Applies to every implementation task, whether written by a human or an AI agent.
> This document extends the checklist in [`review-checklist.md`](review-checklist.md) and the contract in [`../../AGENTS.md`](../../AGENTS.md).

## 1. The change is complete

- [ ] The issue's acceptance criteria pass.
- [ ] The smallest vertical slice was implemented; out-of-scope work is excluded.
- [ ] Failure paths are handled, not only the happy path.
- [ ] Tests that fail without the change exist and pass with it.
- [ ] The relevant suites ran locally, and the evidence is reported.
- [ ] No secret, token, password, master key, private URL, or customer data appears in code, tests, logs, screenshots, or fixtures.
- [ ] Authorization and tenant boundaries are tested.
- [ ] The one-host, one-service, PostgreSQL, Caddy, and Docker invariants still hold.
- [ ] No dependency has an unapproved license or an unnecessary native requirement.
- [ ] Public docs, ADRs, the decision log, and indexes are current.
- [ ] No push, issue creation, PR, or release happened without explicit owner instruction.

## 2. Arabic explanation gate

**A code change is not done until the owner has a beginner-friendly Arabic explanation.**

Create one private file:

```text
.local/learn/NNN-<issue-or-topic>.ar.md
```

Requirements:

- The file is local only. Never commit it, push it, link it from public docs, or include it in a release artifact.
- Use the next unused number and keep the issue slug or a short topic slug.
- Write for a beginner who knows basic programming but not deployment or this codebase.
- Do not paste the whole diff. Explain the idea and walk the files.
- Do not claim a command or test passed unless it was run.

### Required contents

1. **ما تغيّر ولماذا** — what changed and why.
2. **مفهوم جديد من الصفر** — each new concept from zero, with an everyday analogy.
3. **جولة ملفًا بملف** — a file-by-file walkthrough.
4. **كيف تشغّله** — the exact command and what the owner should see.
5. **كيف تختبره** — a concrete test, including one failure case.
6. **ما الذي قد يخطئ** — realistic failure modes and how to recognize them.
7. **اختبار سريع** — three quiz questions with answers.
8. **ماذا تقرأ بعد ذلك** — the next public spec, issue, or explanation.

### Quality bar

- Modern Standard Arabic, natural rather than a literal translation.
- Explain an English technical term the first time it appears.
- Use a real analogy: a harbor, a queue at a counter, a shipping container, a checklist, a spare key.
- Keep code, commands, paths, and logs LTR inside RTL text.
- State what is not implemented yet; never imply a future feature already works.
- Include one concrete failure the owner can reproduce.
- Link only to public repository files or public URLs the owner controls.

## 3. Docs-only changes

A documentation-only change does not require a new Arabic code explanation, but it still needs:

- [ ] Correct links and canonical names.
- [ ] No public link to the private owner workspace.
- [ ] `python3 scripts/check-docs.py` passing.
- [ ] A note in the owner's private progress log if a phase or decision changed.

If a docs change teaches a new engineering concept, add a short Arabic explanation anyway when the owner asks.

## 4. Handoff update

At the end of every phase and every merged issue:

- [ ] Update the private handoff at `.local/handoff/claude-handoff.md` (English, under 300 lines).
- [ ] Update the private progress log at `.local/progress.md` when phase state or decisions change.
- [ ] Keep both local-only; never add them to Git.
- [ ] Sanitize before the owner uploads the handoff to another service.

## 5. Final evidence

Before reporting completion, include:

```text
Changed: <files and behavior>
Verified: <commands and results>
Risks: <remaining uncertainty or follow-up>
Next: <one concrete action>
Explanation: .local/learn/NNN-<topic>.ar.md
```

The explanation line is required for code changes and may be omitted for docs-only changes.
