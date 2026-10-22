# Agent workflows

> Reusable procedures for common Marsa tasks. Each workflow preserves the safety rules in `AGENTS.md`.

## 1. Implement a backlog issue

1. Read the issue and all `depends_on` issues.
2. Confirm the milestone is current and the issue is `status/ready`.
3. Read the requirement IDs and ADRs in the issue.
4. Write a plan with tests and out-of-scope items.
5. Branch: `feat/<issue-slug>` or `fix/<issue-slug>`.
6. Implement the smallest vertical slice.
7. Add tests for the failure path, not only the happy path.
8. Update docs, ADRs, decision log, and coverage if behavior changed.
9. Run the narrow tests, then the full relevant suite.
10. Self-review with `review-checklist.md`.
11. Report evidence and remaining risk.

Do not create the GitHub issue or push. The user controls GitHub writes.

## 2. Fix a bug

1. Reproduce with a failing test or a precise command.
2. Find the invariant that was violated, not only the symptom.
3. Patch the smallest responsible layer.
4. Add a regression test that fails on the old behavior.
5. Check whether the same class of bug exists in adjacent paths.
6. Document the cause and any operational impact.
7. Report the reproduction, fix, and test evidence.

If the fix changes a public contract, add an OpenAPI/ADR note and a migration path.

## 3. Write or correct documentation

1. Identify the source of truth for the claim (requirement, ADR, verified fact, or analysis).
2. Mark new uncertainty as **PROPOSED**, **INFERRED**, **UNKNOWN**, or **VERIFIED**.
3. Use relative links and canonical names.
4. Do not invent a public URL; use `urn:marsa:*`.
5. Update the indexes and `docs/00-progress.md` if phase state changes.
6. Run `python3 scripts/check-docs.py`.

Do not rewrite history to make a decision look cleaner. Add a correction note or superseding ADR.

## 4. Record a decision

Use an ADR when the decision is architectural, hard to reverse, or constrains multiple components.

1. Copy the structure of `docs/adr/0001-modular-monolith.md`.
2. Include context, decision, consequences, alternatives, and references.
3. Add the ADR to `docs/adr/README.md`.
4. Add or update the decision in `docs/07-risks-and-open-questions.md`.
5. Update affected docs and requirements in the same change.
6. Mark it **PROPOSED** until the owner confirms.

For a small non-architectural choice, append to the decision log instead of creating an ADR.

## 5. Change the database schema

1. State the invariant and the backward-compatibility plan.
2. Use expand/contract:
   - expand: add nullable columns/tables/indexes;
   - migrate reads/writes;
   - contract in a later release.
3. Add the EF migration and a migration bundle check.
4. Test on an empty database, the previous release schema, and a populated database.
5. Never auto-migrate at startup.
6. Update `05-data-model.md` and the retention/backup notes.
7. Document the downgrade path (usually restore).

## 6. Change the API

1. Prefer additive changes within `/api/v1`.
2. Update `Marsa.Contracts` and regenerate OpenAPI.
3. Add or update contract tests and the generated CLI client fixture.
4. Update `06-api-contracts.md` and the examples.
5. A breaking change requires `/api/v2`, an ADR, and a migration note.
6. Never expose a domain entity or a secret.

## 7. Change deployment orchestration

1. Draw the state/step change.
2. Preserve single-flight admission and the immutable snapshot.
3. Make the step idempotent and crash-safe.
4. Keep the old route until health and stabilization pass.
5. Add a failure-injection test at the new boundary.
6. Update the state machine in `03-architecture.md`, `05-data-model.md`, and the ADR.
7. Do not add auto-rollback or auto-migration.

## 8. Add a UI screen

1. Read the role matrix and the API contract.
2. Use Razor Components and application services; no direct database access.
3. Add English and Arabic resources from the start.
4. Test at 360 px and 1280 px, keyboard-only, and RTL.
5. Add a confirmation for destructive actions.
6. Show what failed, what was preserved, and the next action.
7. Ensure logs/code blocks stay LTR.

## 9. Add a dependency

1. Check the license against `docs/12-license-and-clean-room.md`.
2. Check maintenance, native requirements, and supply-chain risk.
3. Prefer the platform or an existing dependency.
4. Add the package centrally, pin the version, and update the SBOM/notices.
5. Do not add a dependency that requires a new stateful service.

## 10. Prepare a release

1. Confirm all M6 acceptance gates.
2. Run the E2E suite and failure injection.
3. Verify migrations, backup/restore, and upgrade from the previous release.
4. Generate SBOM, checksums, license inventory, and notices.
5. Check no GPL/unknown component is in the default distribution.
6. Update changelog, release notes, and known issues.
7. Do not push, tag, or publish. Report the exact commands for the owner.

## 11. Phase close

1. Re-read the phase deliverables and acceptance gates.
2. Run the phase checks.
3. Update `docs/00-progress.md`: status, files, decisions, risks, next action.
4. Commit with `docs: phase N <summary>` or `feat: phase N <summary>`.
5. Report a two-line status, then continue unless blocked.

## 12. Context reset

1. Read `docs/00-progress.md`.
2. Read `docs/00-identity.md`.
3. Read the current phase section and its linked files.
4. Read the active issue and dependencies.
5. Do not re-litigate confirmed decisions; do not trust memory over files.
