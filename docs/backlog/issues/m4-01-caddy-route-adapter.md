---
title: "M4: Control Caddy over a Unix socket with stable, managed route compilation"
labels: [type/feature, area/edge, area/security, priority/p0, status/ready, size/l]
milestone: "M4"
epic: "E6"
size: "l"
depends_on: [m3-04-worker-lease-recovery]
requirements: [FR-EDGE-01, FR-EDGE-05, FR-EDGE-07, NFR-REL-04]
stories: [E6.1, E6.2, E6.7]
---

## Context

Caddy is the only component exposed to the internet. Marsa must reach its admin API over a permissioned Unix socket, compile the entire managed route set atomically, and preserve configuration it does not own.

## Scope

- Connect to Caddy only through `/run/marsa/caddy/admin.sock` with documented ownership and mode.
- Compile the complete Marsa-managed route set, including the control route and per-service routes.
- Use stable route IDs and update by replace/remove rather than appending duplicates.
- Validate route conflicts before applying; preserve unknown foreign configuration.
- Reconcile on startup and periodically, removing only orphaned managed routes.
- Fail closed with a degraded state when the socket or admin API is unavailable.

## Acceptance criteria

- [ ] The admin endpoint is not reachable from a public interface.
- [ ] The compiled route set contains exactly the expected managed routes.
- [ ] Duplicate host/path conflicts are rejected before a write.
- [ ] Foreign routes and unknown configuration survive add, replace, remove, and reconcile.
- [ ] A Caddy restart is repaired without manual database edits.
- [ ] An unavailable socket produces a clear degraded component, not a crash.

## Likely files

- `src/Marsa.Infrastructure/Edge/CaddyAdminClient.cs`
- `src/Marsa.Infrastructure/Edge/RouteCompiler.cs`
- `src/Marsa.Application/Edge/RouteReconciler.cs`
- `deploy/caddy/Caddyfile.template`

## Test notes

- Route compiler golden tests for the full managed set.
- Caddy integration tests for add/replace/remove and foreign-route preservation.
- Socket permission and restart reconciliation tests.

## Requirement coverage

- `FR-EDGE-01`
- `FR-EDGE-05`
- `FR-EDGE-07`
- `NFR-REL-04`

## Roadmap stories

- `E6.1`
- `E6.2`
- `E6.7`

## Dependencies

<!-- dependency-links -->
- Depends on `m3-04-worker-lease-recovery`.

## Out of scope

- HA Caddy, external load balancers, CDN integration, and public admin API access.
