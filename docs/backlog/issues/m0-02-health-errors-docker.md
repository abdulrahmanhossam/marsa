---
title: "M0: Add health endpoints, ProblemDetails, request IDs, and Docker capability detection"
labels: [type/feature, area/platform, area/observability, area/api, priority/p0, status/ready, size/m]
milestone: "M0"
epic: "E0"
size: "m"
depends_on: [m0-01-solution-skeleton]
requirements: [FR-BUILD-01, FR-OBS-04, FR-OBS-05, FR-API-03]
stories: [E0.6, E4.1, E7.4]
---

## Context

Operators need an honest health signal before any product workflow exists. Docker is optional at process start but required for deployments, so its absence must degrade readiness without crashing or hiding the cause.

## Scope

- Expose `/health/live`, `/health/ready`, and `/health/degraded` with component detail.
- Add request correlation through `X-Request-Id` and structured JSON logs in production.
- Add a shared ProblemDetails writer with `type`, `title`, `status`, `code`, `traceId`, and a safe message.
- Detect Docker version, BuildKit, architecture, and cgroup availability; report `degraded` when unusable.
- Ensure liveness never depends on PostgreSQL, Caddy, or Docker.

## Acceptance criteria

- [ ] Every response contains a correlation ID; a supplied valid `X-Request-Id` is preserved and an invalid one is replaced.
- [ ] Unhandled errors return the shared ProblemDetails shape with no stack trace or secret.
- [ ] `/health/live` stays successful when PostgreSQL, Caddy, and Docker are unavailable.
- [ ] `/health/ready` fails when PostgreSQL or the schema is unavailable and includes the failing component.
- [ ] Missing Docker produces a degraded component and an actionable log entry, not a crash.
- [ ] Logs are structured JSON in production and include the request and deployment correlation IDs.

## Likely files

- `src/Marsa.Server/Health/`
- `src/Marsa.Server/Middleware/`
- `src/Marsa.Server/Errors/`
- `src/Marsa.Infrastructure/Docker/DockerCapabilityProbe.cs`
- `tests/Marsa.Server.Tests/HealthTests.cs`

## Test notes

- Integration tests with PostgreSQL and Docker unavailable.
- ProblemDetails contract test for every declared error code family.
- Correlation ID propagation test across middleware and logs.

## Requirement coverage

- `FR-BUILD-01`
- `FR-OBS-04`
- `FR-OBS-05`
- `FR-API-03`

## Roadmap stories

- `E0.6`
- `E4.1`
- `E7.4`

## Dependencies

<!-- dependency-links -->
- Depends on `m0-01-solution-skeleton`.

## Out of scope

- Build execution, container management, and readiness for Caddy routes; those arrive with their owning features.
