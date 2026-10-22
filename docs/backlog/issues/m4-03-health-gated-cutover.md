---
title: "M4: Switch routes only after health passes and preserve the old route on failure"
labels: [type/feature, area/edge, area/deploy, priority/p0, status/ready, size/m]
milestone: "M4"
epic: "E6"
size: "m"
depends_on: [m4-01-caddy-route-adapter, m3-02-health-and-release-retention]
requirements: [FR-EDGE-06, NFR-REL-03]
stories: [E6.5, E6.6]
---

## Context

Cutover is the moment traffic moves. It must be a single atomic route replacement performed only after the new release passes the health gate, with the previous route remaining on any failure.

## Scope

- Order the deployment as health check, route prepare, atomic switch, and success.
- Keep the old route active until the new container is healthy and stabilized.
- On switch failure, restore or retain the previous route and fail with a stable code.
- Record the route ID, hostname, upstream, and switch timestamp on the deployment.
- Make repeated activation idempotent and safe after a worker crash.

## Acceptance criteria

- [ ] Traffic reaches the new release only after health passes.
- [ ] A failed health check performs no route write.
- [ ] A failed route write leaves the previous route serving.
- [ ] A crash during switch is detected and repaired without duplicate routes.
- [ ] The deployment detail shows the route transition and failure evidence.

## Likely files

- `src/Marsa.Application/Edge/CutoverService.cs`
- `src/Marsa.Infrastructure/Edge/CaddyRouteWriter.cs`
- `src/Marsa.Domain/Deployments/RouteTransition.cs`

## Test notes

- Failure injection before, during, and after the route write.
- Old-route-serving assertion.
- Crash/replay idempotency test.

## Requirement coverage

- `FR-EDGE-06`
- `NFR-REL-03`

## Roadmap stories

- `E6.5`
- `E6.6`

## Dependencies

<!-- dependency-links -->
- Depends on `m4-01-caddy-route-adapter`.
- Depends on `m3-02-health-and-release-retention`.

## Out of scope

- Blue/green at the DNS layer, weighted traffic, and automatic rollback.
