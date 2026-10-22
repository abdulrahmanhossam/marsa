---
title: "M3: Make deployment admission durable, single-flight, and idempotent"
labels: [type/feature, area/deploy, area/api, priority/p0, status/ready, size/xl]
milestone: "M3"
epic: "E5"
size: "xl"
depends_on: [m3-01-runtime-container, m2-01-project-crud]
requirements: [FR-DEP-01, FR-DEP-02, FR-DEP-03, FR-DEP-04, FR-DEP-08, FR-API-05, NFR-REL-01]
stories: [E5.1, E5.2]
---

## Context

Admission is the boundary between a user request and long-running work. It must freeze an immutable snapshot, reject a second active deployment, enforce valid state transitions, and return the same result for retried idempotency keys.

## Scope

- Persist a deployment and its immutable snapshot before enqueueing any work.
- Enforce one active deployment per environment with a partial unique index and a locked environment row.
- Implement the canonical state machine with explicit allowed transitions.
- Record each step with start/end, status, stable code, and redacted evidence.
- Store idempotency records for deploy, rollback, domain, and secret mutations.
- Return `deployment.active_exists` and `idempotency.conflict` with safe details.
- Support a forced redeploy that creates a new deployment only after the previous one is terminal.

## Acceptance criteria

- [ ] A deployment row and snapshot exist before any worker can claim work.
- [ ] Concurrent deploy requests cannot create two active deployments.
- [ ] Every invalid state transition is rejected and tested.
- [ ] The same idempotency key returns the original deployment; a different payload returns a conflict.
- [ ] The step timeline is readable after restart.
- [ ] A forced redeploy bypasses reuse but not single-flight admission.

## Likely files

- `src/Marsa.Domain/Deployments/Deployment.cs`
- `src/Marsa.Domain/Deployments/DeploymentState.cs`
- `src/Marsa.Application/Deployments/AdmissionService.cs`
- `src/Marsa.Infrastructure/Persistence/Deployments/`
- `src/Marsa.Server/Endpoints/DeploymentsEndpoints.cs`

## Test notes

- State machine transition matrix.
- Concurrent admission race with PostgreSQL.
- Idempotency replay/conflict tests.

## Requirement coverage

- `FR-DEP-01`
- `FR-DEP-02`
- `FR-DEP-03`
- `FR-DEP-04`
- `FR-DEP-08`
- `FR-API-05`
- `NFR-REL-01`

## Roadmap stories

- `E5.1`
- `E5.2`

## Dependencies

<!-- dependency-links -->
- Depends on `m3-01-runtime-container`.
- Depends on `m2-01-project-crud`.

## Out of scope

- The worker execution loop, cancellation, routing, and rollback; those are M3-04, M3-05, M4-03, and M5-01.
