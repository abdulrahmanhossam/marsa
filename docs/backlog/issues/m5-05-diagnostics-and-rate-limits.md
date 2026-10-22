---
title: "M5: Add the redacted diagnostics view and API rate limits"
labels: [type/feature, area/ops, area/api, area/security, priority/p1, status/ready, size/m]
milestone: "M5"
epic: "E10"
size: "m"
depends_on: [m4-05-audit-trail, m1-03-preflight-and-public-url]
requirements: [FR-OPS-04, FR-API-07, NFR-SEC-12]
stories: [E10.1, E10.2]
---

## Context

Operators need a redacted view of host, database, Docker, Caddy, disk, and version health, and the API needs bounded rate limits so login, setup, deploy, webhooks, and log streaming cannot be trivially exhausted.

## Scope

- Add a diagnostics command/page for host, database, Docker, Caddy, disk, and version.
- Redact secrets, paths containing credentials, and full environment maps.
- Return a next action for each failed component.
- Rate-limit login, setup, deploy, webhooks, and log streaming with documented errors and `Retry-After`.
- Apply per-IP and per-identity limits without throttling normal use.
- Audit repeated limit violations without logging credentials.

## Acceptance criteria

- [ ] The diagnostics report shows each component and a next action.
- [ ] No secret or credential appears in the report.
- [ ] Rate limits return the documented error and `Retry-After`.
- [ ] Normal interactive use is not throttled.
- [ ] Limit violations are bounded and auditable.

## Likely files

- `src/Marsa.Server/Endpoints/DiagnosticsEndpoints.cs`
- `src/Marsa.Server/Components/Pages/Settings/Diagnostics.razor`
- `src/Marsa.Server/RateLimiting/`

## Test notes

- Diagnostics redaction test.
- Rate-limit boundary and `Retry-After` tests.
- Normal-use non-throttling test.

## Requirement coverage

- `FR-OPS-04`
- `FR-API-07`
- `NFR-SEC-12`

## Roadmap stories

- `E10.1`
- `E10.2`

## Dependencies

<!-- dependency-links -->
- Depends on `m4-05-audit-trail`.
- Depends on `m1-03-preflight-and-public-url`.

## Out of scope

- A public status page, external monitoring integration, and adaptive rate limiting.
