---
title: "M2: Detect ASP.NET Core, Node/Next.js, static, Dockerfile, and prebuilt image plans"
labels: [type/feature, area/detection, priority/p0, status/ready, size/xl]
milestone: "M2"
epic: "E3"
size: "xl"
depends_on: [m2-02-source-connections]
requirements: [FR-DET-01, FR-DET-02, FR-DET-03, FR-DET-04, FR-DET-07]
stories: [E3.1, E3.2, E3.3, E3.4, E3.5, E3.6, E3.9, E3.10]
---

## Context

Detection converts a repository into an explainable build and runtime plan. It must be deterministic, never execute repository code on the host, and give the operator evidence rather than a black-box guess.

## Scope

- Detect ASP.NET Core, Node/Next.js, static `index.html`, Dockerfile, and prebuilt OCI references.
- Record detector name/version, evidence files, confidence, port, health path, and commands.
- Cache plans by commit and detector version; repeated detection returns the same plan.
- Require an explicit port/health override where evidence is insufficient.
- Return `detection.unsupported` with missing evidence and a Dockerfile/`marsa.json` suggestion.
- Never execute repository scripts, package managers, or host binaries during detection.

## Acceptance criteria

- [ ] A fixture for each supported stack produces the expected plan and evidence.
- [ ] Same commit plus detector version returns byte-identical effective plans.
- [ ] No repository script executes during detection; only file reads and bounded parsing occur.
- [ ] Low-confidence plans are marked and require confirmation.
- [ ] Unsupported repositories receive an actionable code and guidance.
- [ ] The plan contains no host paths, secrets, or unbounded command output.

## Likely files

- `src/Marsa.Application/Detection/`
- `src/Marsa.Infrastructure/Detection/`
- `src/Marsa.Contracts/Detection/`
- `tests/Marsa.Application.Tests/Detection/`

## Test notes

- Golden fixture tests for every supported stack.
- Determinism test across repeated runs and order changes.
- Malicious repository test proving no host execution.

## Requirement coverage

- `FR-DET-01`
- `FR-DET-02`
- `FR-DET-03`
- `FR-DET-04`
- `FR-DET-07`

## Roadmap stories

- `E3.1`
- `E3.2`
- `E3.3`
- `E3.4`
- `E3.5`
- `E3.6`
- `E3.9`
- `E3.10`

## Dependencies

<!-- dependency-links -->
- Depends on `m2-02-source-connections`.

## Out of scope

- Python, Go, Ruby, PHP, Java, and monorepo recursive detection; only explicit roots are supported.
