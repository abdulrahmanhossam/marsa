---
title: "M3: Claim work with leases and recover deterministically after a worker crash"
labels: [type/feature, area/deploy, area/reliability, priority/p0, status/ready, size/l]
milestone: "M3"
epic: "E5"
size: "l"
depends_on: [m3-03-deployment-admission]
requirements: [FR-DEP-05, NFR-REL-02, NFR-REL-05, NFR-REL-06]
stories: [E5.3, E5.6]
---

## Context

The hosted worker must make progress after a restart without activating two releases. A lease, a heartbeat, bounded attempts, and idempotent step inspection are the core of that guarantee.

## Scope

- Claim due deployments with `FOR UPDATE SKIP LOCKED` and a time-bounded lease.
- Renew the heartbeat while a step runs; expire a dead worker's lease after the configured interval.
- Resume from the last durable completed step or fail deterministically when resumption is unsafe.
- Inspect existing containers, images, and routes before creating replacements.
- Enforce a maximum attempt count and record every attempt.
- Handle graceful shutdown with a bounded drain and recoverable in-flight steps.

## Acceptance criteria

- [ ] Kill -9 during build, health, and activation never produces duplicate activation.
- [ ] Another worker recovers an expired lease within two lease durations.
- [ ] Attempt limits stop a poison deployment and return a stable failure.
- [ ] Queued work and step history survive a server restart.
- [ ] Shutdown waits within the configured timeout and leaves recoverable state.
- [ ] Re-running a completed step is a no-op.

## Likely files

- `src/Marsa.Server/Workers/DeploymentWorker.cs`
- `src/Marsa.Application/Deployments/LeaseService.cs`
- `src/Marsa.Infrastructure/Persistence/Deployments/DeploymentLeaseStore.cs`

## Test notes

- Crash injection at each step boundary.
- Concurrent worker claim and heartbeat expiry test.
- Graceful shutdown and restart recovery test.

## Requirement coverage

- `FR-DEP-05`
- `NFR-REL-02`
- `NFR-REL-05`
- `NFR-REL-06`

## Roadmap stories

- `E5.3`
- `E5.6`

## Dependencies

<!-- dependency-links -->
- Depends on `m3-03-deployment-admission`.

## Out of scope

- A separate worker process, distributed queues, and multi-host scheduling.
