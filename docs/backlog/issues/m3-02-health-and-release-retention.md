---
title: "M3: Gate releases on HTTP/TCP health and retain the previous release"
labels: [type/feature, area/runtime, area/deploy, priority/p0, status/ready, size/m]
milestone: "M3"
epic: "E4"
size: "m"
depends_on: [m3-01-runtime-container]
requirements: [FR-RUN-05, FR-RUN-08, NFR-REL-03]
stories: [E4.8, E5.5]
---

## Context

A running container is not a healthy release. Health has to cover HTTP and TCP, distinguish timeout from crash-loop, and leave the previous container available for an explicit rollback.

## Scope

- Implement HTTP and TCP probes with path, port, interval, timeout, retries, start period, and stabilization window.
- Apply the defaults from the architecture document and allow plan overrides within bounds.
- Never activate a release that fails health or crashes repeatedly.
- Retain the previous container and image until retention permits pruning.
- Record health attempts, status codes, and failure codes without secrets.

## Acceptance criteria

- [ ] A passing probe plus stabilization window activates the release.
- [ ] A failing probe or crash loop fails the deployment without changing the active route.
- [ ] Timeout, connection refused, non-2xx/3xx, and crash-loop cases have distinct codes.
- [ ] The previous release remains available for rollback after a successful cutover.
- [ ] Health evidence is visible in the deployment detail and after restart.

## Likely files

- `src/Marsa.Application/Health/HealthGate.cs`
- `src/Marsa.Infrastructure/Runtime/ContainerHealthProbe.cs`
- `src/Marsa.Domain/Deployments/HealthCheck.cs`

## Test notes

- HTTP/TCP probe tests with controlled servers.
- Crash-loop and timeout tests.
- Previous-release retention test.

## Requirement coverage

- `FR-RUN-05`
- `FR-RUN-08`
- `NFR-REL-03`

## Roadmap stories

- `E4.8`
- `E5.5`

## Dependencies

<!-- dependency-links -->
- Depends on `m3-01-runtime-container`.

## Out of scope

- Script-based health checks, gRPC health, and multi-endpoint gates.
