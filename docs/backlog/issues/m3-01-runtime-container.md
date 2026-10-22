---
title: "M3: Run workloads with ownership labels, resource limits, and no privileged access"
labels: [type/feature, area/runtime, area/security, priority/p0, status/ready, size/l]
milestone: "M3"
epic: "E4"
size: "l"
depends_on: [m2-07-build-pipeline]
requirements: [FR-RUN-01, FR-RUN-02, FR-RUN-03, FR-RUN-04, FR-RUN-06, NFR-SEC-03]
stories: [E4.5, E4.6]
---

## Context

Marsa shares the Docker daemon with the host, so it must never mutate a container it did not create. Workloads get a loopback port, an immutable env snapshot, resource limits, and the safest container settings the image supports.

## Scope

- Create containers with `io.marsa.*` ownership labels and a managed-by label guard.
- Refuse to start, stop, remove, or inspect unmanaged containers, even on a name conflict.
- Reject privileged mode, host networking, host PID/IPC, and host path mounts.
- Apply CPU, memory, PID, and log-size limits; drop capabilities and set `no-new-privileges`.
- Use a non-root user and read-only root filesystem where the image permits; document exceptions.
- Create a loopback-only host port for the health check and Caddy target.
- Inject environment from the deployment snapshot, never from live project edits.
- Make start, inspect, stop, remove, and log idempotent.

## Acceptance criteria

- [ ] A conflicting unmanaged container is left untouched and the deployment fails safely.
- [ ] Privileged, host-network, host-mount, and host-PID requests are rejected.
- [ ] Defaults apply resource, capability, and log-size limits.
- [ ] Changing project settings after admission does not alter the running container's environment.
- [ ] Repeating start/stop does not create duplicates or errors.
- [ ] The deployment records the container ID, labels, image digest, and effective limits.

## Likely files

- `src/Marsa.Infrastructure/Runtime/DockerRuntime.cs`
- `src/Marsa.Application/Runtime/ContainerSpecFactory.cs`
- `src/Marsa.Domain/Deployments/Release.cs`
- `tests/Marsa.Infrastructure.Tests/Runtime/`

## Test notes

- Docker integration tests for label guards and idempotent lifecycle.
- Inspect assertions for limits, capabilities, network, and mounts.
- Snapshot immutability test.

## Requirement coverage

- `FR-RUN-01`
- `FR-RUN-02`
- `FR-RUN-03`
- `FR-RUN-04`
- `FR-RUN-06`
- `NFR-SEC-03`

## Roadmap stories

- `E4.5`
- `E4.6`

## Dependencies

<!-- dependency-links -->
- Depends on `m2-07-build-pipeline`.

## Out of scope

- Compose, multi-container services, custom networks beyond the project network, and user-supplied container flags.
