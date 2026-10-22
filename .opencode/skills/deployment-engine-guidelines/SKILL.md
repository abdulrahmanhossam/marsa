---
name: deployment-engine-guidelines
description: Use when changing Marsa deployment admission, the state machine, worker leases, health gates, rollback, reconciliation, routing cutover, or deployment error codes.
---

# Deployment engine guidelines

## Non-negotiables

1. Persist the deployment and its immutable snapshot before any work.
2. At most one active deployment per environment, enforced by a partial unique index and a lease.
3. A release activates only after health and stabilization pass.
4. A failed deployment never changes the active route.
5. No automatic rollback. A failed release leaves the old release serving and requires an explicit rollback.
6. Every step is idempotent and safe to replay after a crash.
7. Reconciliation mutates only resources with `io.marsa.*` ownership labels.
8. Never auto-migrate at web startup.

## State machine

```text
queued -> preparing -> building -> deploying -> health_checking -> routing
  -> succeeded | succeeded_with_warnings | action_required | failed | cancelled
```

- Reject invalid transitions in the domain.
- `action_required` means the previous release is serving and a human must decide.
- `cancelled` is allowed from `queued` through `health_checking`; the old route stays.
- A terminal state is final; a retry is a new deployment.

## Admission

- Lock the environment row, check for an active deployment, freeze the snapshot, insert, then enqueue.
- `deployment.active_exists` for a concurrent request.
- `Idempotency-Key` returns the original deployment for the same payload; `idempotency.conflict` for a different payload.
- A forced redeploy bypasses image reuse, not single-flight admission.

## Worker and recovery

- Claim with `FOR UPDATE SKIP LOCKED`.
- Lease 60 seconds; heartbeat 15 seconds; maximum 3 attempts.
- A dead worker's lease expires; another attempt resumes from the last durable step or fails deterministically.
- Inspect existing containers, images, and routes before creating replacements.
- Graceful shutdown drains within the configured timeout and leaves recoverable state.
- Kill -9 at every step must be tested.

## Health and cutover

- Defaults: 60-second total, 5-second interval, 3-second request timeout, 12 retries, 10-second start, 3 consecutive successes.
- Distinguish timeout, connection refused, non-2xx/3xx, and crash loop.
- Prepare the route only after health; switch atomically; keep the old route on failure.
- The previous container and image remain available for rollback.
- A crash during switch must be repaired without duplicate routes.

## Rollback

- Rollback is a new deployment pinned to a prior image digest and snapshot.
- It passes the same health and route gates.
- History is never mutated; the failed deployment remains visible.
- Retention never prunes the active or last-known-good release.

## Error codes

Use stable codes, for example:

```text
deployment.active_exists
deployment.invalid_transition
deployment.cancelled
build.failed
build.timeout
start.failed
health.timeout
health.crashed
route.conflict
route.apply_failed
source.auth_failed
source.repo_too_large
```

Errors carry safe diagnostics, a correlation ID, and the next action. Never include secrets or raw container env.

## Required tests

- Transition matrix.
- Concurrent admission race.
- Idempotency replay and conflict.
- Kill -9 at build, health, and activation.
- Failed health and failed route leave the old route serving.
- Cancellation from every pre-activation state.
- Reconciler ignores foreign containers/routes.
- Retention preserves active and last-known-good releases.
