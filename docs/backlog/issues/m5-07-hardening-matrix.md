---
title: "M5: Run the authorization, input, Docker-guardrail, and failure-injection hardening matrix"
labels: [type/security, area/security, area/testing, priority/p0, status/ready, size/l]
milestone: "M5"
epic: "E10"
size: "l"
depends_on: [m5-02-cli, m4-03-health-gated-cutover, m3-05-cancel-activate-reconcile]
requirements: [NFR-REL-07]
stories: [E10.1, E10.2, E10.3, E10.4]
---

## Context

The MVP is exposed to a small team, so the authorization and failure paths need adversarial tests rather than a happy-path demo. This issue closes the gap between feature-level tests and release confidence.

## Scope

- Run the endpoint authorization matrix for anonymous, viewer, developer, admin, owner, cross-tenant, and revoked token.
- Add negative tests for hostname, path, repo URL, branch, env key, and image reference validators.
- Prove Docker label guards and unmanaged-resource refusal under name conflicts.
- Inject Docker down, Caddy down, PostgreSQL restart, worker kill, full disk, and slow health.
- Record the observed behavior against the runbook and file follow-ups for unsafe gaps.
- Verify all external calls have timeouts and bounded retries.

## Acceptance criteria

- [ ] Every endpoint has an authorization matrix result and no unexplained allow.
- [ ] All validator negative suites pass, including SSRF and traversal.
- [ ] An unmanaged container is never mutated, including on name conflict.
- [ ] Each injected failure produces a documented state and next action.
- [ ] No external call lacks a timeout or retry bound.
- [ ] Unsafe gaps block the M6 exit instead of being waived silently.

## Likely files

- `tests/Marsa.Server.Tests/AuthorizationMatrixTests.cs`
- `tests/Marsa.E2E.Tests/FailureInjection/`
- `tests/Marsa.Infrastructure.Tests/Validation/`
- `docs/09-testing-strategy.md`

## Test notes

- Authorization matrix suite.
- Validator negative suite.
- Failure-injection matrix on a disposable Docker runner.

## Requirement coverage

- `NFR-REL-07`

## Roadmap stories

- `E10.1`
- `E10.2`
- `E10.3`
- `E10.4`

## Dependencies

<!-- dependency-links -->
- Depends on `m5-02-cli`.
- Depends on `m4-03-health-gated-cutover`.
- Depends on `m3-05-cancel-activate-reconcile`.

## Out of scope

- Penetration testing by a third party, fuzzing at scale, and 24/7 monitoring.
