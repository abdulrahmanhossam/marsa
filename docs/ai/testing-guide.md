# Testing guide

> Use this when implementing an issue or reviewing a change. The full strategy is in [`../09-testing-strategy.md`](../09-testing-strategy.md).

## 1. The pyramid

| Layer | Project | What it proves |
|---|---|---|
| Domain | `Marsa.Domain.Tests` | Invariants, value objects, state transitions |
| Application | `Marsa.Application.Tests` | Use cases, authorization, validation, port orchestration |
| Infrastructure | `Marsa.Infrastructure.Tests` | EF mappings, migrations, Docker, Caddy, crypto, Git |
| Server | `Marsa.Server.Tests` | Endpoints, auth matrix, ProblemDetails, OpenAPI, SignalR |
| CLI | `Marsa.Cli.Tests` | Commands, exit codes, redaction, generated client |
| E2E | `Marsa.E2E.Tests` | Real PostgreSQL, Docker, Caddy, deploy, rollback |

Most tests should be fast domain/application tests. Integration and E2E tests cover the boundaries that cannot be faked honestly.

## 2. Commands

Once the solution exists:

```bash
dotnet restore --locked-mode
dotnet build Marsa.sln -warnaserror
dotnet test Marsa.Domain.Tests
dotnet test Marsa.Application.Tests
dotnet test Marsa.Infrastructure.Tests
dotnet test Marsa.Server.Tests
dotnet test Marsa.Cli.Tests
./eng/verify.sh
```

Documentation and backlog:

```bash
python3 scripts/check-docs.py
python3 scripts/validate-backlog.py
./scripts/sync-labels.sh --dry-run
./scripts/create-issues.sh --dry-run
```

## 3. Fixtures and isolation

- Use a unique PostgreSQL database per test class or transaction rollback; never share state between tests.
- Use Testcontainers for PostgreSQL 17, Caddy, and Docker integration tests.
- Use a temporary directory per build workspace; delete it even on failure.
- Use a fake clock (`TimeProvider`) for leases and retention.
- Use fake ports for source, runtime, edge, and notifications in application tests.
- Do not hit real GitHub/GitLab or public DNS in unit tests. Use a local HTTPS server and fixture payloads.
- Do not use production secrets or hostnames.

## 4. What each feature must test

### Auth and tenancy

- Anonymous, viewer, developer, admin, owner, cross-tenant, revoked token, logged-out cookie.
- Setup replay, second owner, last-owner removal, CSRF, cookie flags, security headers.
- PAT creation, one-time display, scope escalation, immediate revocation.

### Source and detection

- URL schemes, embedded credentials, private IPs, metadata IPs, redirects, DNS re-resolution.
- Webhook signature, timestamp tolerance, duplicate delivery, branch filter, one deployment.
- Detection fixtures for each supported stack and a malicious repository that must not execute.
- `marsa.json` unknown fields, traversal, inline secrets, precedence, plan hash.

### Build and runtime

- `.git` exclusion, traversal, symlink escape, archive bomb, size limits.
- Build success, cache reuse, timeout, failure codes, redacted logs.
- Image retention never removes active or last-known-good images.
- Container labels, unmanaged conflict, privileged/host rejection, limits, env snapshot.
- Health success, timeout, refused, non-2xx, crash loop.
- Idempotent start/stop/remove.

### Deployment

- State transition matrix, concurrent admission race, idempotency replay/conflict.
- Kill -9 at each step, lease expiry, attempt limit, restart recovery.
- Cancellation from each pre-activation state; old release keeps serving.
- Failed health/route never changes the active route.
- Rollback is a new deployment, same gate, history intact.
- Reconciler repairs managed resources and ignores foreign ones.

### Edge and secrets

- Caddy socket permission, full route set, foreign route preservation, restart reconciliation.
- Hostname normalization, DNS verification idempotency, certificate failure isolation, HTTP redirect.
- AES-GCM round trip, tamper detection, key versioning, missing key fails closed.
- Secret canaries in logs, audit, events, API, telemetry, and snapshots.
- Audit append-only and role visibility.

### UI and Arabic

- Setup, login, project, deploy, rollback, domain, secret, audit flows.
- Language persistence, RTL at 360 px and 1280 px, LTR code/log blocks.
- Keyboard-only navigation, focus, labels, error summary, color-independent state.
- Destructive confirmation text and retained resources.

### Operations

- Clean install, upgrade from previous release, migration failure, incompatible schema.
- Backup/restore with and without the master key.
- Disk pressure warning, degraded state, safe cleanup.
- Rate-limit boundaries and `Retry-After`.

## 5. Failure injection matrix

Run these before a release candidate:

| Injection | Expected |
|---|---|
| Docker unavailable | Server starts, readiness degraded, build fails safely |
| Caddy unavailable | Control plane stays up, readiness degraded, old routes untouched |
| PostgreSQL restart | Readiness fails then recovers, no duplicate activation |
| Worker `kill -9` | Lease expires, another attempt resumes or fails deterministically |
| Full disk | Warning before build failure, no state corruption |
| Slow health endpoint | Timeout with `health_timeout`, old release serving |
| Duplicate webhook | One deployment, duplicate ignored |
| Revoked PAT | Immediate 401, no cached authorization |

## 6. Security canaries

Use a unique canary string in test secrets and assert it is absent from:

- application and deployment logs;
- audit rows;
- API responses and downloads;
- SignalR events;
- OpenTelemetry spans/metrics;
- error pages and ProblemDetails;
- build/Caddy/Docker output;
- database snapshots and exports.

A canary test failure is a release blocker.

## 7. Evidence for a task

Report:

- Exact commands run.
- Pass/fail counts and any skipped tests with reasons.
- The requirement IDs covered.
- Any untested path and why.
- A redacted artifact if a visual or operational result matters.

Never claim a suite passed from memory. Never hide a flaky test; fix it or file it with evidence.

## 8. Performance checks

Design targets, not SLAs:

- API read p95 < 200 ms, write p95 < 500 ms excluding deployment work.
- Admission < 1 s.
- Small cached deploy < 3 minutes.
- Log delivery < 1 s on a healthy connection.
- Dashboard initial render < 2 s on a local network.

Measure on a representative host; do not add a benchmark to CI unless it is stable.
