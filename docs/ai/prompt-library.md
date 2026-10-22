# Prompt library

> Reusable prompts for Marsa tasks. Replace `<...>` placeholders. Do not include secrets or private URLs in a prompt.

## 1. Implement an issue

```text
You are implementing Marsa issue `<issue-slug>`.

Read, in order: docs/00-progress.md, AGENTS.md, docs/ai/architecture-context.md,
the issue draft, every depends_on issue, and the requirement/ADR IDs it names.

Deliver a small vertical slice that satisfies every acceptance criterion.
Add tests for the failure paths. Do not change the one-host, one-service,
PostgreSQL-only, Docker/Caddy, or secret-handling invariants. Do not push,
create issues, or open a PR.

Before editing, write: goal, files, invariant at risk, tests, and out of scope.
After editing, run the narrow tests and report: changed, verified, risks, next.
```

## 2. Review a change

```text
Review this diff as a Marsa maintainer.

Focus on:
1. Correctness against the issue's acceptance criteria.
2. State-machine, single-flight, snapshot, and rollback invariants.
3. Tenant/role authorization and CSRF.
4. Secret leaks in logs, audit, events, API, telemetry, or errors.
5. Docker/Caddy privilege and ownership boundaries.
6. Migration compatibility and idempotency.
7. Arabic/RTL and accessibility for UI changes.
8. Missing tests, flaky tests, or false "pass" claims.

Return blocking findings first, with file:line and a concrete fix. Do not
rewrite the author's style. Do not approve without evidence.
```

## 3. Fix a bug

```text
Reproduce this bug with the smallest command or failing test:
<reproduction>

Find the violated invariant, not only the symptom. Patch the smallest
responsible layer. Add a regression test that fails on the old behavior.
Check adjacent paths for the same class of bug. Report the reproduction,
root cause, fix, and test evidence. Do not push or create a PR.
```

## 4. Write documentation

```text
Update `<file>` for Marsa.

Use the approved sources: docs/01-product-requirements.md, the ADRs, and
docs/00-identity.md. Mark claims VERIFIED, INFERRED, PROPOSED, or UNKNOWN.
Use relative links and canonical names: Marsa, Ofuq, ofuqq, marsa, MARSA_,
io.marsa.*, urn:marsa. Do not invent a public domain.

Keep the existing structure, add cross-links, and update the index or
docs/00-progress.md if phase state changes. Run python3 scripts/check-docs.py.
```

## 5. Record a decision

```text
Write an ADR for this decision: <decision>.

Follow docs/adr/0001-modular-monolith.md. Include context, decision,
consequences (positive and negative), rejected alternatives, and references.
Add it to docs/adr/README.md and append it to the decision log in
docs/07-risks-and-open-questions.md as PROPOSED. Update affected docs.
Do not present it as approved.
```

## 6. Threat-model a feature

```text
Threat-model `<feature>` for Marsa.

Assets: control plane, Docker socket, Caddy admin socket, PostgreSQL,
master key, PATs, tenant data, deployment logs.
Trust boundaries: internet -> Caddy, browser -> API, Git -> webhook,
repository -> build, workload -> host, server -> Docker/Caddy.

List threats, existing controls, residual risk, and tests. Prioritize
secret leaks, SSRF, path traversal, privilege escalation, cross-tenant
access, replay, and denial of service. Do not add a new service.
```

## 7. Review Arabic and RTL

```text
Review these screens/strings for Arabic and RTL:
<paths>

Check: natural Modern Standard Arabic, no machine-translation artifacts,
correct RTL layout at 360 px and 1280 px, LTR code/log blocks, localized
dates/numbers, no clipped controls, keyboard focus, labels, and error
summaries. Do not concatenate translated fragments. Report specific fixes.
```

## 8. Prepare a release candidate

```text
Prepare the Marsa release candidate.

Verify: M6 acceptance gates, migration bundle, upgrade from the previous
release, backup/restore with the master key, SBOM/checksums/license
inventory, no GPL/unknown component, E2E matrix, and runbooks.

Do not push, tag, publish, or create a release. Report the exact commands
for the owner, the evidence, and any remaining risk.
```

## 9. Challenge a PROPOSED decision

```text
Evaluate PROPOSED decision `<ID>`.

State the decision, the requirement it serves, and the failure mode it
prevents. Compare at least two alternatives on security, operability,
complexity, and reversibility. Recommend keep, change, or defer, with
evidence. If changing it, list every doc, ADR, issue, and requirement
that must be updated. Do not rewrite history.
```

## 10. Phase close

```text
Close Phase `<N>`.

Re-read the phase deliverables. Run the phase checks. Update
docs/00-progress.md with status, files, decisions, risks, and the next
action. Commit with `docs: phase N <summary>` or `feat: phase N <summary>`.
Report the commit and a two-line status. Do not push.
```
