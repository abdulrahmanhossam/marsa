---
title: "M2: Implement project CRUD, archive/restore, and bounded list pagination"
labels: [type/feature, area/projects, area/api, priority/p0, status/ready, size/m]
milestone: "M2"
epic: "E2"
size: "m"
depends_on: [m1-02-rbac-pats-tenant-isolation, m1-04-api-contract]
requirements: [FR-SRC-01, FR-API-04, NFR-SEC-02]
stories: [E2.1]
---

## Context

Projects are the container for source, detection, deployments, domains, and settings. The MVP deliberately allows one environment and one service per project, so the aggregate must enforce that invariant while staying organization-scoped and restorable.

## Scope

- Create, list, read, update, archive, and restore projects through application services.
- Enforce unique slugs per organization and hide archived projects by default.
- Create the default environment and one-service constraint atomically with the project.
- Add cursor pagination with a documented default and maximum page size.
- Validate names and slugs; reject reserved words and path-unsafe values.
- Emit creation, update, archive, and restore audit events through the audit port.

## Acceptance criteria

- [ ] Slugs are unique per organization and stable after creation.
- [ ] Archived projects disappear from default lists and restore with all history intact.
- [ ] A second service or environment cannot be created in 0.1.
- [ ] Cross-tenant reads and writes fail without revealing existence.
- [ ] List endpoints enforce default and maximum page sizes and stable ordering.
- [ ] Every mutation produces a redacted audit event.

## Likely files

- `src/Marsa.Domain/Projects/`
- `src/Marsa.Application/Projects/`
- `src/Marsa.Infrastructure/Persistence/Projects/`
- `src/Marsa.Server/Endpoints/ProjectsEndpoints.cs`

## Test notes

- Domain tests for slug, one-service, and archive invariants.
- Integration tests for CRUD, restore, pagination, and tenant isolation.
- Audit event assertions for each mutation.

## Requirement coverage

- `FR-SRC-01`
- `FR-API-04`
- `NFR-SEC-02`

## Roadmap stories

- `E2.1`

## Dependencies

<!-- dependency-links -->
- Depends on `m1-02-rbac-pats-tenant-isolation`.
- Depends on `m1-04-api-contract`.

## Out of scope

- A project UI, source connections, and deployment history; those are M2-08 and later issues.
