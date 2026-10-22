---
title: "M1: Establish the versioned OpenAPI contract and remove dashboard data shortcuts"
labels: [type/feature, area/api, area/platform, priority/p0, status/ready, size/m]
milestone: "M1"
epic: "E0"
size: "m"
depends_on: [m1-01-setup-and-login, m1-02-rbac-pats-tenant-isolation]
requirements: [FR-API-01, FR-API-02, FR-API-08]
stories: [E0.10]
---

## Context

The API is the contract for the dashboard, CLI, and future clients. If the dashboard reads the database directly or the OpenAPI document is hand-maintained, the CLI and tenant rules will drift while the surface is still small.

## Scope

- Prefix public endpoints with `/api/v1` and publish the version policy.
- Generate OpenAPI from endpoint metadata and `Marsa.Contracts`; commit the artifact at `docs/api/openapi.v1.json`.
- Make the dashboard call application services or the public API, never DbContext or repositories directly.
- Add CI to fail on an unapproved OpenAPI diff and to build a generated client fixture.
- Document additive versus breaking changes and the `/api/v2` rule.

## Acceptance criteria

- [ ] The generated document is deterministic and checked in.
- [ ] V1 routes reject incompatible breaking changes through the OpenAPI diff gate.
- [ ] The dashboard has no direct database access outside Infrastructure.
- [ ] OpenAPI includes error shapes, enums, auth schemes, and idempotency headers.
- [ ] The CLI client fixture compiles from the generated document.

## Likely files

- `src/Marsa.Server/OpenApi/`
- `src/Marsa.Contracts/`
- `docs/api/openapi.v1.json`
- `scripts/check-openapi.sh`
- `.github/workflows/ci.yml`

## Test notes

- OpenAPI snapshot comparison.
- Architecture test that the UI layer has no DbContext dependency.
- Generated client compile test.

## Requirement coverage

- `FR-API-01`
- `FR-API-02`
- `FR-API-08`

## Roadmap stories

- `E0.10`

## Dependencies

<!-- dependency-links -->
- Depends on `m1-01-setup-and-login`.
- Depends on `m1-02-rbac-pats-tenant-isolation`.

## Out of scope

- A public SDK, GraphQL, gRPC, and third-party API keys.
