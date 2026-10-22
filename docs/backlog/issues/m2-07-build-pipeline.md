---
title: "M2: Build and pin immutable images with streamed, redacted logs"
labels: [type/feature, area/build, area/observability, priority/p0, status/ready, size/xl]
milestone: "M2"
epic: "E4"
size: "xl"
depends_on: [m2-05-marsa-json, m2-06-source-export]
requirements: [FR-BUILD-03, FR-BUILD-04, FR-BUILD-05, FR-BUILD-06, FR-BUILD-07, FR-BUILD-08]
stories: [E4.3, E4.4, E4.7, E4.9]
---

## Context

The build is the point where untrusted repository content becomes a runnable artifact. The result must be immutable and pinned by digest, logs must survive refresh without leaking secrets, and cleanup must never delete an image a retained release still needs.

## Scope

- Run BuildKit builds from the effective plan with bounded CPU, memory, and time.
- Tag images by commit and plan/content hash; record the resulting digest on the deployment.
- Reuse a cached image for the same commit and plan unless a forced rebuild is requested.
- Stream phases and timestamps, redact secrets, and persist build logs before completion.
- Map common failures to stable codes and safe diagnostics.
- Clean failed workspaces and prune only unreferenced managed images under retention.
- Resolve prebuilt image tags to digests at deploy time and return a stable pull error.
- Expose no privileged build flags to users.

## Acceptance criteria

- [ ] A successful build records an immutable image digest.
- [ ] The same commit and plan reuses the image unless forced.
- [ ] Logs survive a page refresh and contain no secret canary.
- [ ] Restore, compile, missing-file, and timeout failures map to documented codes.
- [ ] Cleanup never removes the active or last-known-good image.
- [ ] A prebuilt tag is pinned to a digest and pull failures are actionable.
- [ ] A repository Dockerfile cannot request privileged mode or host mounts through Marsa.

## Likely files

- `src/Marsa.Application/Builds/`
- `src/Marsa.Infrastructure/Build/BuildKitBuilder.cs`
- `src/Marsa.Infrastructure/Build/ImageRetention.cs`
- `src/Marsa.Infrastructure/Build/BuildLogRedactor.cs`

## Test notes

- BuildKit integration fixture with a small ASP.NET and static app.
- Failure-code and timeout tests.
- Retention test proving referenced images are preserved.

## Requirement coverage

- `FR-BUILD-03`
- `FR-BUILD-04`
- `FR-BUILD-05`
- `FR-BUILD-06`
- `FR-BUILD-07`
- `FR-BUILD-08`

## Roadmap stories

- `E4.3`
- `E4.4`
- `E4.7`
- `E4.9`

## Dependencies

<!-- dependency-links -->
- Depends on `m2-05-marsa-json`.
- Depends on `m2-06-source-export`.

## Out of scope

- Remote build agents, build secrets, multi-arch app images, and registry publishing beyond GHCR release artifacts.
