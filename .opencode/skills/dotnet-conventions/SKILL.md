---
name: dotnet-conventions
description: Use when implementing or reviewing C#/.NET code in Marsa, including solution boundaries, Minimal APIs, EF Core, Razor Components, dependency injection, errors, and tests.
---

# Marsa .NET conventions

## Start here

1. Read `docs/04-dotnet-solution-structure.md`.
2. Read `docs/ai/coding-standards.md`.
3. Read the issue and the ADRs it names.
4. Check that the project boundary you are about to cross is allowed.

## Project boundaries

- `Marsa.Domain`: no EF Core, ASP.NET Core, Docker, Caddy, HTTP, or logging.
- `Marsa.Contracts`: wire DTOs only; no Domain or persistence types.
- `Marsa.Application`: use cases and ports; no EF Core, Docker, or ASP.NET Core.
- `Marsa.Infrastructure`: adapters; no endpoints or Razor components.
- `Marsa.Server`: composition, endpoints, UI, SignalR, worker, health.
- `Marsa.Cli`: generated client and commands; no server internals.
- Production projects never reference `Marsa.Testing`.

## Implementation rules

- .NET 10, C# 14, nullable enabled, warnings as errors.
- File-scoped namespaces; one public type per file; `sealed` by default.
- Async methods end in `Async`, take `CancellationToken`, and never use `async void`.
- Use `TimeProvider`; never `DateTime.Now`.
- Use `Guid.CreateVersion7()` through `IIdGenerator`.
- Expected failures use a typed `Result`/stable error code; exceptions are for bugs.
- API errors use ProblemDetails with `type`, `title`, `status`, `code`, `traceId`, and a safe message.
- No secret, SQL, stack trace, or internal path in a response.
- Do not add comments that restate code; use XML docs on public contracts.

## EF Core

- PostgreSQL 17, snake_case tables/columns.
- Reads use `AsNoTracking()` unless tracking is needed.
- Every tenant query applies `organization_id`.
- Transactions wrap state + outbox writes; keep Docker/Caddy calls outside the critical transaction.
- Migrations are explicit and expand/contract; never auto-migrate at startup.
- Enforce single-flight and one-service invariants with partial unique indexes.

## API and UI

- `/api/v1`, generated OpenAPI, cursor pagination, idempotency keys.
- Cookie auth + antiforgery for dashboard; bearer PAT for CLI/API.
- The dashboard calls application services, never `DbContext`.
- Razor Components are server-rendered; no SPA or Node build.
- All strings are localized in English and Arabic; code/log blocks stay LTR.

## Verification

- Add domain tests for invariants, application tests for use cases, server tests for endpoints, and integration tests for adapters.
- Add a failure-path test for every new branch that can lose data or route traffic.
- Run `dotnet build Marsa.sln -warnaserror`, the narrow test project, then the full relevant suite.

## Do not

- Add a dependency that requires a new stateful service.
- Put business logic in an endpoint or Razor component.
- Expose a domain entity or a secret through the API.
- Add a speculative abstraction for a single implementation.
