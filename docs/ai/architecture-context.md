# Architecture context for agents

> Use this when a task touches deployment, persistence, routing, secrets, or project boundaries. The full design is in [`../03-architecture.md`](../03-architecture.md).

## 1. System boundary

One Marsa installation controls one Linux Docker host.

```text
Browser / CLI
     |
   Caddy  --- HTTPS, routes, certificates
     |
 Marsa.Server (API + Razor UI + SignalR + worker)
     |            |
 PostgreSQL     Docker Engine
                  |
             workload containers
```

- PostgreSQL is the only required stateful dependency.
- Caddy is the only public edge.
- Docker is the only build and runtime provider in 0.1.
- No Redis, message broker, Kubernetes, or object store is required.
- One service per deployment; one environment and one service per project in 0.1.

## 2. Code boundaries

| Project | May depend on | Must not depend on |
|---|---|---|
| `Marsa.Domain` | Nothing | EF Core, ASP.NET Core, Docker, Caddy, HTTP, logging |
| `Marsa.Contracts` | Nothing | Domain, persistence, infrastructure |
| `Marsa.Application` | Domain, Contracts | EF Core, `Docker.DotNet`, `Microsoft.AspNetCore.*`, Infrastructure |
| `Marsa.Infrastructure` | Application, Domain, Contracts | HTTP endpoints, Razor components |
| `Marsa.Server` | Application, Infrastructure, Contracts | Test projects |
| `Marsa.Cli` | Contracts | Database, Docker socket, Caddy socket, server internals |
| `Marsa.Testing` | Production projects as needed | Production projects referencing it |

The dashboard calls application services or API equivalents. It never reads `DbContext` directly.

## 3. Durable invariants

1. A deployment row and immutable snapshot exist before work starts.
2. At most one active deployment per environment, enforced by a partial unique index and a lease.
3. An image is referenced by digest; a release is never mutated in place.
4. Rollback is a new deployment, not a history edit.
5. Every tenant-owned row has `organization_id`; queries are scoped.
6. Audit is append-only from the application.
7. Secret plaintext never appears in logs, events, audit, snapshots, or API projections.
8. All timestamps are UTC; lease checks prefer database time.
9. The previous release remains available until retention permits pruning.
10. The active and last-known-good releases are never pruned by routine cleanup.

## 4. Deployment state machine

```text
queued -> preparing -> building -> deploying -> health_checking -> routing -> succeeded
   |          |            |           |              |             |
   +----------+------------+-----------+--------------+-------------+-> failed
   |          |            |           |              |             +-> action_required
   +----------+------------+-----------+--------------+---------------> cancelled
```

- `succeeded_with_warnings` is terminal and may be used when a non-fatal step was skipped with evidence.
- `action_required` means the previous release is still serving and a human must decide.
- Invalid transitions are rejected in the domain, not only in the API.
- No automatic rollback. A failed release leaves the old release serving.

## 5. Admission and worker rules

- Admission locks the environment row, checks for an active deployment, freezes the snapshot, and inserts the deployment.
- Idempotency keys are stored durably; the same key returns the original result.
- Workers claim with `FOR UPDATE SKIP LOCKED` and a lease.
- Heartbeat renews the lease; a dead worker's lease expires and another attempt resumes or fails deterministically.
- Maximum attempts: 3. Lease: 60 seconds. Heartbeat: 15 seconds.
- Every step records start/end, status, stable code, and redacted evidence.
- Cancellation is safe from `queued` through `health_checking`; the old route stays.
- Reconciliation repairs only resources with `io.marsa.*` labels.

## 6. Health and routing

- Health defaults: 60-second total timeout, 5-second interval, 3-second request timeout, 12 retries, 10-second start period, 3 consecutive successes.
- HTTP and TCP probes are supported; failure codes distinguish timeout, refused, non-2xx/3xx, and crash-loop.
- Caddy is controlled over `/run/marsa/caddy/admin.sock`; directory `0700`, socket `0660`.
- The route compiler owns the complete Marsa route set, including the static control route.
- Route changes are serialized and use stable IDs. Foreign routes are preserved.
- The route switches only after health and stabilization pass.
- One verified hostname per service; HTTP redirects to HTTPS; ACME HTTP-01 only.

## 7. Secrets

- AES-256-GCM envelope encryption.
- Master key from a root-owned file or environment; never in the image or database.
- Ciphertext records the key version.
- Secret versions are immutable; snapshots carry encrypted references and versions.
- Plaintext exists only at container creation.
- Missing key fails closed.
- PATs are hashed with SHA-256; user passwords use Identity's password hasher.
- Secret reveal is admin-only, feature-flagged off by default, and audited.

## 8. Logs and realtime

- Build and runtime logs are chunked, sequenced, redacted, and persisted.
- Runtime `stdout` and `stderr` are distinguishable.
- Deployment logs default to 30 days; application logs to 14 days; audit to 1 year.
- SignalR delivers ordered events and replays after the last sequence.
- A slow client must not block the worker.
- Logs and events are not the source of truth; durable rows are.

## 9. Trust boundaries

| Boundary | Untrusted input | Required control |
|---|---|---|
| Internet → Caddy | Host header, TLS, HTTP | Host validation, redirect, certificate isolation |
| Browser → API | Cookies, bearer tokens, forms | Identity, CSRF, PAT scopes, rate limits |
| Git provider → API | Webhook payload, signature | HMAC, timestamp tolerance, dedupe, branch filter |
| Repository → build | Dockerfile, source, scripts | Isolated build, no privileged flags, workspace limits |
| Workload → host | Container config, logs | No socket, no host mounts, limits, dropped caps |
| Server → Docker | Docker API | Narrow adapter, label guards |
| Server → Caddy | Admin API | Unix socket, not public |

## 10. Do not break these

- Do not add a required service to the happy path.
- Do not let a deployment mutate its snapshot.
- Do not route to an unhealthy container.
- Do not expose the Docker socket or Caddy admin port.
- Do not store plaintext secrets or log them.
- Do not remove the control route while compiling tenant routes.
- Do not auto-rollback or auto-migrate.
- Do not add a second service/runtime/host abstraction for a single feature.
