---
title: "M4: Add the append-only audit trail and role-scoped visibility"
labels: [type/feature, area/audit, area/security, priority/p0, status/ready, size/m]
milestone: "M4"
epic: "E8"
size: "m"
depends_on: [m1-02-rbac-pats-tenant-isolation]
requirements: [FR-SEC-07, FR-SEC-08, NFR-SEC-11]
stories: [E8.5, E8.6]
---

## Context

Sensitive actions need an attributable record that application users cannot alter. Audit must be written before or with the action, redacted at write time, and filtered by role without exposing secret metadata.

## Scope

- Record setup, login, role, project, source, deploy, rollback, secret, domain, and token events.
- Store actor, source IP/user agent, action, resource type/id, result, and correlation ID.
- Make the table append-only for the application; provide no update or delete endpoint.
- Redact secrets, tokens, and sensitive values before insert.
- Scope visibility: developers see their own actions, admins see all, viewers see no sensitive metadata.
- Add filterable pagination and an export-safe projection.

## Acceptance criteria

- [ ] Every sensitive action produces one audit event with a stable action code.
- [ ] No audit row contains a password, token, secret value, or full environment map.
- [ ] The application has no update/delete path for audit rows.
- [ ] Role visibility matches the permission matrix.
- [ ] Events survive restart and correlate to the request or deployment.
- [ ] The audit list is filterable and paginated.

## Likely files

- `src/Marsa.Domain/Audit/AuditEvent.cs`
- `src/Marsa.Application/Audit/AuditWriter.cs`
- `src/Marsa.Infrastructure/Persistence/Audit/AuditStore.cs`
- `src/Marsa.Server/Endpoints/AuditEndpoints.cs`

## Test notes

- Audit coverage matrix per sensitive action.
- Redaction and immutability tests.
- Role visibility and pagination tests.

## Requirement coverage

- `FR-SEC-07`
- `FR-SEC-08`
- `NFR-SEC-11`

## Roadmap stories

- `E8.5`
- `E8.6`

## Dependencies

<!-- dependency-links -->
- Depends on `m1-02-rbac-pats-tenant-isolation`.

## Out of scope

- Tamper-evident hash chains, external SIEM export, and audit retention beyond one year.
