# Self-review checklist

> Run this before claiming a task is done. A checked box needs evidence, not optimism.

## 1. Scope and traceability

- [ ] The change matches the issue and its acceptance criteria.
- [ ] Out-of-scope work is not included.
- [ ] Requirement IDs and ADRs are referenced where relevant.
- [ ] The change does not silently alter an approved requirement.
- [ ] Docs, ADR, decision log, and coverage are updated together.

## 2. Correctness

- [ ] The happy path works.
- [ ] Invalid input and invalid state transitions fail with a stable code.
- [ ] The database invariant is enforced by a constraint, not only by code.
- [ ] The operation is idempotent where a retry is possible.
- [ ] A crash at each step leaves a recoverable state.
- [ ] The snapshot is immutable and the previous release stays serving on failure.
- [ ] No auto-rollback or auto-migration was introduced.

## 3. Security

- [ ] Anonymous, viewer, developer, admin, owner, and cross-tenant paths are tested.
- [ ] CSRF applies to cookie mutations; bearer requests are exempt.
- [ ] No secret, token, password, master key, or private URL is logged or returned.
- [ ] A secret canary is absent from logs, audit, events, API, telemetry, and errors.
- [ ] URLs, redirects, DNS targets, hostnames, paths, env keys, and image references are validated.
- [ ] HMAC comparison is constant-time.
- [ ] The Docker socket and Caddy admin socket are not exposed to workloads.
- [ ] Privileged mode, host mounts, host networking, and host PID/IPC are rejected.
- [ ] A new dependency has an approved license and no unnecessary native requirement.

## 4. Persistence and migrations

- [ ] The migration is expand/contract and tested on a populated database.
- [ ] Startup does not migrate automatically.
- [ ] Queries are organization-scoped.
- [ ] UTC and database time are used correctly.
- [ ] Leases, unique indexes, and retention protect active and last-known-good releases.
- [ ] Audit remains append-only from the application.

## 5. Edge and routing

- [ ] Caddy is reached only over the Unix socket.
- [ ] The managed route set is complete and foreign routes are preserved.
- [ ] Route writes are serialized and idempotent.
- [ ] A failed health check or route write leaves the old route serving.
- [ ] Hostname validation and DNS verification are idempotent.
- [ ] Certificate failure is isolated to the affected route.

## 6. UI and Arabic

- [ ] All new strings exist in English and Arabic.
- [ ] RTL is correct at 360 px and 1280 px.
- [ ] Code and log blocks stay LTR.
- [ ] Keyboard navigation, focus, labels, and error summary work.
- [ ] State is not communicated by color alone.
- [ ] Destructive actions explain impact and what is retained.
- [ ] Errors state what failed, what was preserved, and the next action.
- [ ] No secret plaintext is rendered.

## 7. Tests and evidence

- [ ] New behavior has tests; bug fixes have regression tests.
- [ ] Failure paths are covered, not only the happy path.
- [ ] Relevant suites ran locally and the results are included.
- [ ] No test was skipped or hidden without a reason.
- [ ] `python3 scripts/check-docs.py` passes for docs changes.
- [ ] `python3 scripts/validate-backlog.py` passes for backlog changes.
- [ ] The dry-run scripts still parse.

## 8. Operations

- [ ] Install/upgrade path is documented if the change affects it.
- [ ] Backup/restore still works with the master key.
- [ ] Diagnostics show the new failure mode with a next action.
- [ ] Disk pressure behavior is considered.
- [ ] Logs and metrics are bounded and redacted.
- [ ] The change does not add a required service to the happy path.

## 9. Final report

- [ ] Changed files and behavior are listed.
- [ ] Verified commands and results are listed.
- [ ] Remaining risk or follow-up is stated.
- [ ] No claim of "done" without evidence.
- [ ] No push, issue creation, PR, or release was performed.
