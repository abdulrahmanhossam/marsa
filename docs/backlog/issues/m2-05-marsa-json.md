---
title: "M2: Add the versioned marsa.json schema, validation, and configuration precedence"
labels: [type/feature, area/detection, area/api, priority/p0, status/ready, size/m]
milestone: "M2"
epic: "E3"
size: "m"
depends_on: [m2-04-detection-engine]
requirements: [FR-DET-05, FR-DET-06, FR-DET-08, FR-DET-09]
stories: [E3.7, E3.8]
---

## Context

`marsa.json` is the repository-owned contract for build and runtime settings. It must reject unknown fields and inline secrets, preserve precedence, and allow monorepos only through an explicit root.

## Scope

- Define schema v1 for build, start, port, health, static output, and project root.
- Validate with JSON path errors for unknown fields, invalid hostnames, unsafe paths, and inline secrets.
- Apply precedence: API override > `marsa.json` > detection.
- Store the effective plan per commit with a plan hash; changing overrides creates a new hash.
- Require an explicit project root or Dockerfile for monorepos; no recursive package guessing.
- Publish the schema at `docs/api/marsa.schema.v1.json` and reference it from the config template.

## Acceptance criteria

- [ ] Unknown fields and inline secrets fail with a JSON path; a valid file applies its overrides.
- [ ] API overrides win over `marsa.json`, which wins over detection.
- [ ] The effective plan and its hash are visible in the API and UI.
- [ ] A monorepo without an explicit root fails with guidance.
- [ ] A future schema version is required for new fields; v1 rejects them.

## Likely files

- `src/Marsa.Contracts/Configuration/MarsaJsonV1.cs`
- `src/Marsa.Application/Detection/ConfigResolver.cs`
- `docs/api/marsa.schema.v1.json`
- `tests/Marsa.Application.Tests/Configuration/`

## Test notes

- Schema validation table including unknown fields, traversal, and secret-shaped values.
- Precedence and plan-hash tests.
- Monorepo root selection tests.

## Requirement coverage

- `FR-DET-05`
- `FR-DET-06`
- `FR-DET-08`
- `FR-DET-09`

## Roadmap stories

- `E3.7`
- `E3.8`

## Dependencies

<!-- dependency-links -->
- Depends on `m2-04-detection-engine`.

## Out of scope

- Compose files, multi-service roots, and remote config includes.
