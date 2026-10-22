---
title: "M3: Add safe cancellation, health-gated activation, and managed-resource reconciliation"
labels: [type/feature, area/deploy, area/reliability, priority/p0, status/ready, size/l]
milestone: "M3"
epic: "E5"
size: "l"
depends_on: [m3-04-worker-lease-recovery, m3-02-health-and-release-retention]
requirements: [FR-DEP-06, FR-DEP-07, FR-DEP-11, NFR-REL-04]
stories: [E5.4, E5.5, E5.8, E5.10]
---

## Context

Cancellation and activation are the two places where a mistake takes down the serving release. Reconciliation then keeps the database, containers, and routes aligned without touching foreign resources.

## Scope

- Cancel queued through health-checking deployments at a safe boundary; keep the old release serving.
- Attempt cleanup and record the result even when cancellation races with a step.
- Activate only after health and stabilization pass; leave the old route on failure.
- Detect deleted containers, stopped managed containers, and stale route IDs.
- Repair only resources carrying the `io.marsa.*` ownership labels.
- Mark the server degraded when repair is unsafe; never remove a foreign container or route.
- Never auto-rollback; a failed release leaves the old one serving and requires explicit rollback.

## Acceptance criteria

- [ ] Cancellation from each pre-activation state works and the old release keeps serving.
- [ ] A failed health check leaves the active release unchanged.
- [ ] A deleted managed container and a stale route are detected and repaired.
- [ ] An unmanaged container or foreign route is never mutated.
- [ ] Unsafe drift produces a visible degraded state with a next action.
- [ ] No automatic rollback occurs.

## Likely files

- `src/Marsa.Application/Deployments/CancellationService.cs`
- `src/Marsa.Application/Deployments/ActivationService.cs`
- `src/Marsa.Server/Workers/Reconciler.cs`
- `src/Marsa.Infrastructure/Runtime/ManagedResourceInspector.cs`

## Test notes

- Cancellation race tests against build and health steps.
- Failed activation route-state assertion.
- Reconciler tests with managed and foreign resources.

## Requirement coverage

- `FR-DEP-06`
- `FR-DEP-07`
- `FR-DEP-11`
- `NFR-REL-04`

## Roadmap stories

- `E5.4`
- `E5.5`
- `E5.8`
- `E5.10`

## Dependencies

<!-- dependency-links -->
- Depends on `m3-04-worker-lease-recovery`.
- Depends on `m3-02-health-and-release-retention`.

## Out of scope

- Automatic rollback, self-healing of foreign resources, and cross-host reconciliation.
