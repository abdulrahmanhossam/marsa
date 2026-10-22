---
title: "M5: Implement explicit rollback and deployment-history retention"
labels: [type/feature, area/deploy, area/edge, priority/p0, status/ready, size/l]
milestone: "M5"
epic: "E5"
size: "l"
depends_on: [m4-03-health-gated-cutover]
requirements: [FR-DEP-09, FR-DEP-12, NFR-REL-09]
stories: [E5.7, E5.9, E6.6]
---

## Context

Rollback is a new deployment, not a history edit. It reuses a prior image digest and snapshot, passes the same health and route gates, and never removes the failed deployment from the record.

## Scope

- Create a rollback deployment pinned to a prior image digest and snapshot.
- Run the same build-skip, health, stabilization, and route gates as a normal deploy.
- Never mutate the failed deployment or prior release history.
- Expose rollback through the API, with CLI and dashboard wiring in M5-02 and M5-03.
- Add configurable deployment retention that preserves active and last-known-good releases.
- Prune old deployments, logs, and images without breaking audit or rollback targets.

## Acceptance criteria

- [ ] Rollback works after a failed health check and after a failed route switch.
- [ ] The rollback is visible as a new deployment linked to the target release.
- [ ] The failed deployment remains in history.
- [ ] Rollback passes the same health gate and does not rebuild.
- [ ] Retention never removes the active or last-known-good release.
- [ ] Pruning is configurable and recorded.

## Likely files

- `src/Marsa.Application/Deployments/RollbackService.cs`
- `src/Marsa.Infrastructure/Persistence/Deployments/RetentionStore.cs`
- `src/Marsa.Domain/Deployments/DeploymentKind.cs`

## Test notes

- Rollback after failed health and failed route tests.
- History immutability test.
- Retention boundary test with active and last-known-good releases.

## Requirement coverage

- `FR-DEP-09`
- `FR-DEP-12`
- `NFR-REL-09`

## Roadmap stories

- `E5.7`
- `E5.9`
- `E6.6`

## Dependencies

<!-- dependency-links -->
- Depends on `m4-03-health-gated-cutover`.

## Out of scope

- Automatic rollback, rollback of a database migration, and arbitrary history editing.
