---
name: doc-writing
description: Use when writing or editing Marsa documentation, ADRs, requirements, backlog issues, runbooks, Arabic content, README indexes, or progress logs.
---

# Marsa documentation rules

## Identity

Use exactly:

| Context | Value |
|---|---|
| Product | Marsa / مرسى |
| Brand | Ofuq |
| GitHub handle | `ofuqq` |
| Repository | `ofuqq/marsa` |
| CLI | `marsa` |
| Config | `marsa.json` |
| Env prefix | `MARSA_` |
| Docker labels | `io.marsa.*` |
| Token prefix | `marsa_pat_` |
| Namespaces | `Marsa.*` |
| NuGet | `ofuqq.Marsa.*` |
| npm | `@ofuqq/*` |
| URN | `urn:marsa` |

Never use `ofuq/marsa`, `Ofuq.Marsa.*`, or `@marsa/*`. Use `ofuqq` only in URLs, remotes, badges, and registry identifiers; prose uses Ofuq.

## Claims

Mark content honestly:

- **VERIFIED**: checked against a source or command on the date shown.
- **INFERRED**: derived from evidence, not directly confirmed.
- **PROPOSED**: a Marsa decision awaiting owner confirmation.
- **UNKNOWN**: not verified.

Do not invent a public domain, a legal conclusion, a price, or a vendor commitment. Use `urn:marsa:*` and relative links until a domain is owned.

## Structure

- Start with a short purpose and status line.
- Use stable headings and cross-links.
- Keep requirement IDs and milestone IDs verbatim.
- Add a "Rejected alternatives" line for a proposed decision.
- Update the decision log in `docs/07-risks-and-open-questions.md`.
- Update the owner's private progress log and handoff at a phase boundary; never commit them.
- Update indexes and coverage when files or requirements change.

## ADRs

- Copy the structure of `docs/adr/0001-modular-monolith.md`.
- Include context, decision, consequences (positive and negative), alternatives, references.
- Add the ADR to `docs/adr/README.md`.
- Keep status `Proposed` until the owner confirms.
- Supersede, never rewrite history.

## Backlog issues

- Keep the slug stable.
- Use the frontmatter fields: `title`, `labels`, `milestone`, `epic`, `size`, `depends_on`, `requirements`, `stories`.
- Include context, scope, acceptance criteria, likely files, tests, coverage, dependencies, out of scope.
- Regenerate `docs/backlog/coverage.md` and `milestones.md` after edits.
- Run `python3 scripts/validate-backlog.py`.

## Arabic

- Write natural Modern Standard Arabic, not machine-translated English.
- Keep English technical terms when they are the clearest, but explain them on first use. The owner may keep a private glossary; never commit or link it.
- Use Arabic punctuation and numerals consistently.
- Keep code, commands, paths, and logs LTR.
- Test RTL at 360 px and 1280 px.
- Do not concatenate translated fragments; use full messages with placeholders.

## Verification

```bash
python3 scripts/check-docs.py
python3 scripts/validate-backlog.py
```

A relative link must resolve. A required root file must exist. A claim without a status is a defect.
