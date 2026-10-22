---
title: "M1: Add roles, personal access tokens, and tenant-isolation enforcement"
labels: [type/feature, area/auth, area/api, priority/p0, status/ready, size/l]
milestone: "M1"
epic: "E1"
size: "l"
depends_on: [m1-01-setup-and-login]
requirements: [FR-AUTH-03, FR-AUTH-04, FR-AUTH-08, NFR-SEC-02]
stories: [E1.3, E1.4, E1.6]
---

## Context

Setup creates one tenant, but every later query still has to be organization-scoped. Roles and PATs must enforce the same authorization decisions as sessions, and the last owner must remain recoverable.

## Scope

- Implement owner, admin, developer, and viewer with an explicit permission matrix.
- Enforce the last-owner invariant and audit role changes.
- Implement PAT creation, listing, rotation, and revocation; show plaintext once and store only a hash.
- Prefix tokens with `marsa_pat_` and make the prefix recognizable by redaction rules.
- Add a global tenant filter or equivalent repository guard and a cross-tenant test matrix.
- Permit PAT scopes only within the user's role; revocation takes effect on the next request.

## Acceptance criteria

- [ ] Every endpoint is tested for anonymous, viewer, developer, admin, owner, and cross-tenant access.
- [ ] A developer cannot perform admin-only actions; a viewer cannot read sensitive metadata.
- [ ] The last owner cannot be removed or demoted.
- [ ] A PAT is shown once, stored only as a hash, and stops working immediately after revocation.
- [ ] A token cannot grant scopes above its user's role.
- [ ] Cross-organization reads and writes fail closed without revealing whether the resource exists.

## Likely files

- `src/Marsa.Domain/Identity/Role.cs`
- `src/Marsa.Application/Authorization/`
- `src/Marsa.Infrastructure/Identity/PersonalAccessTokenStore.cs`
- `src/Marsa.Server/Endpoints/TokensEndpoints.cs`
- `tests/Marsa.Server.Tests/AuthorizationMatrixTests.cs`
- `tests/Marsa.Infrastructure.Tests/TenantIsolationTests.cs`

## Test notes

- Role matrix test for every endpoint and HTTP method.
- Cross-tenant read/write probes for each aggregate.
- PAT lifecycle, scope escalation, and immediate revocation tests.

## Requirement coverage

- `FR-AUTH-03`
- `FR-AUTH-04`
- `FR-AUTH-08`
- `NFR-SEC-02`

## Roadmap stories

- `E1.3`
- `E1.4`
- `E1.6`

## Dependencies

<!-- dependency-links -->
- Depends on `m1-01-setup-and-login`.

## Out of scope

- OIDC, SCIM, teams, and per-project custom roles; all are post-MVP.
