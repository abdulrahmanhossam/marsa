---
title: "M2: Export the selected commit into a hardened private build workspace"
labels: [type/security, area/build, area/source, priority/p0, status/ready, size/m]
milestone: "M2"
epic: "E4"
size: "m"
depends_on: [m2-02-source-connections]
requirements: [FR-BUILD-02, NFR-SEC-07]
stories: [E4.2]
---

## Context

A repository is untrusted input. Exporting the commit must exclude `.git`, reject path traversal and symlink escapes, enforce archive limits, and leave a workspace that only the build worker can read.

## Scope

- Export the resolved commit, not the working tree, into a per-deployment private directory.
- Exclude `.git`, `.marsa`, and configured ignored paths; block absolute, `..`, and symlink escapes.
- Enforce file count, total size, path length, and decompression limits.
- Set restrictive permissions and clean the workspace on failure or cancellation.
- Record a workspace manifest and content hash for the build.
- Use the Git CLI process boundary with argument arrays and redacted credentials.

## Acceptance criteria

- [ ] `.git` and unsafe paths are absent from the workspace.
- [ ] Traversal, symlink escape, archive bomb, and oversized exports are blocked.
- [ ] The workspace is readable only by the build worker and is removed after failure.
- [ ] The exported content hash is recorded on the deployment.
- [ ] Git arguments are not passed through a shell and credentials never appear in logs.

## Likely files

- `src/Marsa.Infrastructure/Sources/GitCliSourceFetcher.cs`
- `src/Marsa.Infrastructure/Build/WorkspaceExporter.cs`
- `tests/Marsa.Infrastructure.Tests/Build/WorkspaceExportTests.cs`

## Test notes

- Malicious fixture repository with traversal, symlink, and large files.
- Workspace permission and cleanup tests.
- Git argument-injection and credential-redaction tests.

## Requirement coverage

- `FR-BUILD-02`
- `NFR-SEC-07`

## Roadmap stories

- `E4.2`

## Dependencies

<!-- dependency-links -->
- Depends on `m2-02-source-connections`.

## Out of scope

- Submodules, Git LFS, sparse checkout, and remote build workers.
