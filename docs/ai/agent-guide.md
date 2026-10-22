# Agent guide

> This is the default operating loop for any agent working on Marsa.

## 1. Start with state, not assumptions

1. Read [`../00-progress.md`](../00-progress.md) and [`../00-identity.md`](../00-identity.md).
2. Read the issue draft and all `depends_on` issues.
3. Read the requirement IDs and ADRs named in the issue.
4. Check whether the repository is still documentation-only. Do not create a solution or code that is not requested by an issue.
5. Restate the goal, the acceptance evidence, and the non-goals in your plan.

## 2. Classify the task

| Type | First sources | Typical output |
|---|---|---|
| Documentation | `03`–`12`, ADRs, backlog | Corrected docs, links, coverage |
| Backlog | `01`, `08`, `docs/backlog` | Issue, coverage, labels |
| .NET implementation | `04`, ADRs, issue | Code + tests + docs |
| Runtime/deploy | `03`, `05`, `07` | State machine, lease, Docker, health |
| Edge/secrets | `03`, `06`, `07` | Caddy, TLS, crypto, audit |
| UI/Arabic | `01` §5.12, `03` §11 | Razor, resources, RTL, a11y |
| Release/ops | `09`–`12`, runbooks | Scripts, SBOM, install, backup |

If a task spans more than two rows, propose a split before implementing.

## 3. Plan before editing

Write a short plan with:

- The user-visible behavior that changes.
- Files likely to change.
- The invariant most at risk.
- Tests that will prove it.
- What you are deliberately not doing.

For an issue, use `size` and `depends_on` to decide whether to split. Do not split by layer; split by testable vertical slice.

## 4. Work in small, reversible steps

- Prefer one concern per commit.
- Keep migrations expand/contract.
- Keep API changes additive within `/api/v1`.
- Keep Caddy route writes atomic and idempotent.
- Keep deployment steps re-runnable after a crash.
- Keep secrets out of every intermediate artifact.

If a step cannot be reversed, stop and write the rollback plan first.

## 5. Uncertainty protocol

When docs conflict:

1. Quote the conflicting statements.
2. Choose the option that preserves the one-host, one-service, PostgreSQL-only, no-secret-leak invariants.
3. Prefer the PRD over the roadmap; prefer an ADR over an informal note; prefer a verified fact over an inference.
4. Record the choice as **PROPOSED** in [`../07-risks-and-open-questions.md`](../07-risks-and-open-questions.md), with rejected alternatives.
5. Add a follow-up issue or a question only if the choice is genuinely blocking.

Do not ask a question that the documents already answer. Do not invent a public URL, legal conclusion, or vendor commitment.

## 6. Evidence, not confidence

Before saying a task is done:

- Run the narrowest relevant tests, then the full suite if practical.
- Run `python3 scripts/validate-backlog.py` for backlog changes.
- Run `python3 scripts/check-docs.py` for documentation changes.
- Keep command output that proves the result.
- If a command cannot run, say exactly why and what remains unverified.

Never write "tests pass" when they were not executed. Never hide a skip.

## 7. Reporting format

Use this structure for substantial tasks:

```text
Changed: <files and behavior>
Verified: <commands and results>
Risks: <remaining uncertainty or follow-up>
Next: <one concrete action>
```

Keep it short. For phase work, the owner may ask for a two-line status; follow that instruction.

## 8. Stop conditions

Stop and report, rather than guessing, when:

- A required file is missing and cannot be recreated from the repository.
- A change would delete or rewrite approved requirements without a decision.
- A security boundary would be weakened (Docker socket, secrets, auth).
- A command would push, publish, or mutate GitHub.
- The task requires a legal, trademark, or pricing decision.
- You cannot verify a claim that is central to the change.

## 9. Files to treat with care

| Path | Rule |
|---|---|
| `docs/00-identity.md` | Naming is owner-decided; do not change without explicit instruction. |
| `docs/01-product-requirements.md` | Approved baseline; changes need traceability and a decision. |
| `docs/07-risks-and-open-questions.md` | Append decisions; do not delete history. |
| `docs/00-progress.md` | Update at phase boundaries; keep resume instructions current. |
| `docs/backlog/issues/*` | Stable slugs; regenerate coverage after edits. |
| `scripts/*` | Dry-run default; never auto-apply. |
| `.github/workflows/*` | Least privilege; no secrets in logs. |
| Future `src/Marsa.Domain` | No infrastructure dependencies. |

## 10. Sensitive operations

- Docker socket access is root-equivalent.
- Repository content and Dockerfiles are code execution.
- HMAC comparison must be constant-time.
- PATs are hashed, never encrypted for lookup.
- Master key loss is unrecoverable; never rotate without a backup.
- Caddy's admin socket must never be exposed to workloads.

When in doubt, choose the option that keeps the control plane recoverable.
