---
title: "M0: Add the local stack, migration bundle, server image, and CI gates"
labels: [type/infra, area/platform, area/testing, area/ops, priority/p0, status/ready, size/l]
milestone: "M0"
epic: "E0"
size: "l"
depends_on: [m0-01-solution-skeleton, m0-02-health-errors-docker]
requirements: [NFR-COMP-01]
stories: [E0.3, E0.4, E0.7, E0.8]
---

## Context

M0 is complete only when a new contributor can start the dependencies, apply the schema, run the server, and build the same image CI will use. The server image must run as non-root with a read-only root and no Git runtime dependency.

## Scope

- Add `deploy/compose.dev.yaml` for PostgreSQL 17 and Caddy, with health checks and named volumes.
- Create the initial EF Core migration and an explicit migration bundle command.
- Add `deploy/server.Dockerfile` as a multi-stage, non-root, read-only-root compatible image for amd64 and arm64.
- Add `deploy/compose.yaml` for PostgreSQL, Caddy, and the server.
- Add `.github/workflows/ci.yml` for restore, build, analyzers, unit and integration tests, and migration validation.
- Pin SDK and actions; restore in locked mode.

## Acceptance criteria

- [ ] `docker compose -f deploy/compose.dev.yaml up -d postgres caddy` reaches healthy state.
- [ ] `dotnet run --project src/Marsa.Server` serves `/health/live` against the local stack.
- [ ] The initial migration applies to an empty PostgreSQL 17 database; the bundle is deterministic.
- [ ] The server image starts as a non-root user and passes its health check.
- [ ] CI runs on Linux for pull requests and blocks on build, analyzer, or test failure.
- [ ] No Git binary or GPL tooling is present in the server runtime image.

## Likely files

- `deploy/compose.dev.yaml`
- `deploy/compose.yaml`
- `deploy/server.Dockerfile`
- `deploy/caddy/Caddyfile.template`
- `src/Marsa.Infrastructure/Persistence/Migrations/`
- `tests/Marsa.Infrastructure.Tests/MigrationTests.cs`
- `.github/workflows/ci.yml`

## Test notes

- Testcontainers PostgreSQL 17 migration test.
- Image smoke test for health, non-root user, and read-only root.
- CI dry run of restore, build, migration bundle, and tests.

## Requirement coverage

- `NFR-COMP-01`

## Roadmap stories

- `E0.3`
- `E0.4`
- `E0.7`
- `E0.8`

## Dependencies

<!-- dependency-links -->
- Depends on `m0-01-solution-skeleton`.
- Depends on `m0-02-health-errors-docker`.

## Out of scope

- Production install/upgrade scripts, backups, and multi-arch release publication; M6 owns those.
