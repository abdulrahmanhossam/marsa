# Coding standards

> Status: **PROPOSED** for the .NET implementation. The solution does not exist yet; these rules are the contract for the first code.

## 1. Baseline

- .NET 10 LTS, C# 14, nullable enabled, warnings as errors.
- Central package management; locked restore in CI.
- File-scoped namespaces; one public type per file.
- `sealed` by default unless inheritance is designed.
- Async methods end in `Async`, take `CancellationToken`, and never use `async void` outside event handlers.
- No `.Result`, `.Wait()`, or fire-and-forget tasks without a tracked background mechanism.
- UTC for persisted time; `TimeProvider` for testable clocks.
- `Guid.CreateVersion7()` through `IIdGenerator`, not ad hoc `Guid.NewGuid()`.

## 2. Names and types

- Namespaces: `Marsa.<Layer>.<Feature>`.
- Aggregates and entities: singular nouns (`Deployment`, `Project`, `SecretVersion`).
- Commands: `<Verb><Noun>Command`; queries: `<Noun>Query`; handlers: `<Command>Handler`.
- DTOs in `Marsa.Contracts` use `record` with `required`/`init`.
- Domain values use value objects when validation or units matter (`Hostname`, `Slug`, `ImageReference`).
- Avoid primitive obsession for identifiers, paths, and hostnames.
- Do not expose EF entities or domain aggregates on the wire.

## 3. Errors and results

- Expected failures use a typed `Result`/`Error` with a stable code (for example `deployment.active_exists`).
- Exceptions are for bugs and truly exceptional conditions, not validation.
- API errors use ProblemDetails: `type`, `title`, `status`, `code`, `traceId`, and a safe message.
- Error messages never contain secrets, SQL, stack traces, or internal paths.
- Log the cause with a correlation ID; return a safe message.
- Map infrastructure exceptions at the adapter boundary to stable application errors.

## 4. Persistence

- PostgreSQL 17 with EF Core; snake_case tables and columns.
- Migrations are explicit, reviewed, and expand/contract. Never auto-migrate at startup.
- Reads use `AsNoTracking()` unless tracking is required.
- Every tenant query applies `organization_id`, preferably through a global filter plus an explicit guard.
- Use database time for leases and ordering.
- Transactions wrap state changes and outbox writes.
- Unique partial indexes enforce one active deployment and one service per environment.
- Do not lazy-load. Load what the use case needs.
- Do not store JSON where a relational constraint is required.

## 5. API

- Minimal APIs under `/api/v1`; OpenAPI generated from code.
- Validate at the boundary with a stable error code and a field path.
- Return `202 Accepted` for deployment admission, `201 Created` with `Location` for resource creation, and `409` for invariant conflicts.
- Support `Idempotency-Key` on retryable mutations.
- Pagination is cursor-based with a default and maximum page size.
- Cookie auth for the dashboard, bearer PATs for CLI/API; both use the same authorization service.
- Cookie mutations require antiforgery; bearer requests are exempt.
- Rate-limit login, setup, deploy, webhooks, and log streaming.
- Do not add a private dashboard data layer; call the same application services.

## 6. Domain and orchestration

- State transitions live in the domain and reject invalid edges.
- A command either succeeds atomically or leaves a recoverable state.
- Step handlers are idempotent: inspect before create, update by stable ID, tolerate replay.
- External calls have timeouts and bounded retries; retries only for idempotent operations.
- The deployment snapshot is immutable; never read live project settings during a run.
- No auto-rollback and no automatic migration.
- Reconciliation only touches `io.marsa.*` resources.

## 7. Docker and Caddy adapters

- Pass arguments as arrays; never build a shell string.
- Never expose the Docker socket to a workload.
- Reject privileged mode, host networking, host PID/IPC, and host mounts.
- Apply CPU, memory, PID, and log limits by default.
- Use loopback-only host ports for health and Caddy upstreams.
- Caddy writes are atomic and preserve foreign configuration.
- Redact Docker/Caddy output before it reaches a log or API.

## 8. UI and Arabic

- Razor Components, server-rendered; no SPA or Node build pipeline.
- No business logic in components; call application services.
- All user-visible text comes from resources, not literals in markup.
- Arabic and English are equal; RTL flips layout, but code and logs stay LTR.
- Destructive actions require a confirmation that explains impact and retention.
- Errors show what failed, what was preserved, and the next action.
- Do not rely on color alone; include text and icons with accessible names.

## 9. Logging and telemetry

- Use structured `ILogger` with named properties, not string concatenation.
- Include `requestId`, `deploymentId`, `organizationId`, and `step` where relevant.
- Never log bodies, cookies, Authorization headers, env maps, or secret values.
- OpenTelemetry export is opt-in and never required for health.
- Metrics must not carry high-cardinality IDs.

## 10. Security

- Validate URLs, redirects, DNS targets, hostnames, paths, env keys, and image references with allowlists.
- Use constant-time comparison for HMACs and hashes.
- Encrypt secrets with the master-key protector; never roll your own crypto.
- PATs: 256 bits of entropy, `marsa_pat_` prefix, SHA-256 hash, scope limited by role.
- Never trust `X-Forwarded-*` unless the proxy is configured as trusted.
- Keep dependencies minimal; a new package needs a license and maintenance check.

## 11. Tests

- Domain: invariants and state transitions.
- Application: handlers with fake ports, authorization, validation.
- Infrastructure: PostgreSQL, Docker, Caddy, crypto, migrations.
- Server: endpoint contracts, auth matrix, ProblemDetails, OpenAPI, SignalR.
- CLI: parsing, exit codes, redaction, generated client.
- E2E: happy path, failed build/health, rollback, cancellation, route conflict.
- Every bug fix gets a regression test.

## 12. Style

- Follow `.editorconfig`; run `dotnet format` before review.
- Prefer guard clauses and early returns.
- Keep methods short enough to test; extract orchestration from adapters.
- Do not add comments that restate code. Use XML docs on public contracts and comments only for non-obvious "why".
- No dead code, commented-out blocks, or speculative abstractions.
- Every public behavior should be traceable to a requirement or ADR.
