# Known pitfalls

> These are the failure modes most likely to produce a false "done". Read the relevant section before touching the area.

## 1. Docker socket

- Access is **root-equivalent**. A workload with the socket can own the host.
- Never pass the socket to a build or runtime container.
- A name conflict is not ownership. Check `io.marsa.*` labels before any mutation.
- Label spoofing is possible if an attacker can create containers. Treat the Docker API as trusted-admin, not tenant-isolated.
- Docker inspect output can contain env values. Redact before logging.

## 2. Containers

- A running container is not a healthy release. Require HTTP/TCP health plus stabilization.
- `--restart` policy can hide a crash loop. Detect repeated restarts.
- A read-only root fails for images that write to `/app`; document the exception instead of silently disabling it.
- Host port binding on `0.0.0.0` bypasses Caddy. Bind to loopback.
- Image tags are mutable. Pin by digest for prebuilt and rollback targets.
- Removing an image that a retained release references breaks rollback later.

## 3. Caddy

- The admin API is root-equivalent for routing. Never expose port 2019 to workloads or the internet.
- Replacing the whole config can delete foreign routes. Compile only the managed set and preserve unknown config.
- Concurrent writes can lose a route. Serialize updates.
- A failed certificate must not break other hostnames. Isolate per-route config.
- HTTP-01 needs port 80 reachable; do not redirect the challenge path before Caddy handles it.
- Use the staging CA in tests; production ACME rate limits are real.
- A Caddy restart loses in-memory state. Reconcile from the database.

## 4. Health checks

- TCP open does not mean the app is ready. Prefer HTTP for web apps; allow TCP only when configured.
- A 302 to a login page may be a false success. Define accepted status codes.
- Start period too short causes cold-start failures; too long hides a broken app.
- A health check against localhost inside the container may differ from the host port.
- Health success before migrations finish is a false positive.

## 5. ASP.NET Core and auth

- `Secure` cookies on plain HTTP localhost fail silently in some browsers; document the local exception.
- `SameSite=Lax` does not replace CSRF protection for cookie mutations.
- `UseForwardedHeaders` without a trusted-proxy allowlist lets clients spoof scheme/host.
- `HttpContext.User` from a cached cookie can outlive a role change; re-check critical authorization.
- A PAT in a query string leaks into logs and history. Accept it only in the Authorization header.
- Do not log model binding failures with raw values; they may contain secrets.

## 6. EF Core and PostgreSQL

- Application time and database time diverge. Use database time for leases and ordering.
- `DateTime.Now` is a bug; use UTC.
- A transaction that holds a lock while calling Docker/Caddy can stall the queue. Keep external calls outside the critical transaction.
- `SaveChanges` retries can duplicate side effects. Use outbox/idempotency, not blind retries.
- A partial unique index is the invariant; an in-process lock is not enough.
- Long migrations lock tables. Use expand/contract and test on a populated database.
- Deleting audit rows by cascade breaks append-only expectations. Restrict deletes.

## 7. Secrets

- Environment variables are visible in `docker inspect`, crash dumps, and child processes. Keep the exposure window minimal.
- A secret canary in a test must be unique and asserted absent everywhere.
- Do not put secret plaintext in a deployment snapshot, event, or audit row.
- A missing master key must fail closed, not fall back to plaintext.
- Key rotation without re-encryption planning can orphan snapshots.
- PAT hashing is not password hashing; do not use a slow KDF for a 256-bit token.

## 8. Git and source

- Never build a shell string from a repository URL or branch. Use an argument array.
- Git may prompt for credentials and hang. Disable prompts and set a timeout.
- `file://`, SSH, local paths, and embedded credentials are rejected.
- A redirect can move to a private IP. Re-resolve and re-check.
- DNS rebinding can defeat a one-time check. Pin the resolved address for the request.
- `.git` in a build context can leak history and credentials. Exclude it.
- Symlinks and archive bombs can escape the workspace. Validate real paths and limits.

## 9. Logs and realtime

- Logging a whole exception can include request bodies or connection strings. Log the safe message and correlation ID.
- A slow SignalR client must not block the worker; bound per-client queues.
- SignalR is not durable. Reconnect must replay from the last sequence in the database.
- Ordering by timestamp alone is unstable; use a sequence.
- Redaction after persistence is too late. Redact before write.

## 10. Blazor and Arabic

- Server-rendered components can accidentally hold a `DbContext` or a scoped service in a long-lived circuit. Use a factory and short scopes.
- An Arabic translation with English punctuation looks wrong. Review with a native writer.
- `dir="rtl"` does not fix code blocks, numbers, or mixed-direction paths. Force LTR on code/log content.
- Do not concatenate translated fragments; use full messages with placeholders.
- Icons alone are not accessible labels.

## 11. Operations

- A backup without the master key cannot restore secrets. Test the pair.
- `pg_dump` of a live database can be inconsistent without a transaction/snapshot strategy.
- An upgrade that runs migrations after starting the new binary can race. Migrate before serving.
- A full disk can corrupt a build workspace and the database. Warn early and clean only managed artifacts.
- Uninstall that deletes volumes by default is hostile. Require explicit confirmation.
- Logs and metrics can contain high-cardinality IDs; do not use them as metric labels.

## 12. Process pitfalls

- A passing happy-path demo is not a passing acceptance criterion.
- A skipped test is not a passed test.
- A generated file that is not committed will drift.
- A "temporary" auto-rollback, auto-migration, or insecure default tends to ship.
- A decision recorded only in a chat is lost. Put it in the decision log.
