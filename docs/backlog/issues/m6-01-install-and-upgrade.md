---
title: "M6: Deliver clean-host install and expand/contract upgrade"
labels: [type/infra, area/ops, area/release, priority/p0, status/ready, size/xl]
milestone: "M6"
epic: "E10"
size: "xl"
depends_on: [m5-03-dashboard-primary-flow, m4-03-health-gated-cutover]
requirements: [FR-OPS-01, FR-OPS-02]
stories: [E10.6]
---

## Context

A release candidate must install on a fresh Linux host and upgrade from the previous release without breaking the serving version. The upgrade must run the migration bundle explicitly and be reversible only through a documented restore.

## Scope

- Write `install.sh` for a supported Linux host with Docker, PostgreSQL, Caddy, and the server.
- Generate the setup token and master key with restrictive permissions.
- Write `upgrade.sh` that backs up, runs the migration bundle, starts the new version, and verifies readiness.
- Use expand/contract migrations during rollout; never migrate automatically at web startup.
- Refuse to start when the database schema is newer than the binary.
- Document supported host prerequisites and failure recovery.

## Acceptance criteria

- [ ] A fresh supported VM installs from the release artifact and reaches setup over HTTPS or localhost.
- [ ] Upgrade from the previous release preserves data and passes readiness.
- [ ] A failed migration leaves the old version running or recoverable.
- [ ] The server refuses an incompatible newer schema with a clear message.
- [ ] Install and upgrade do not print secrets.
- [ ] Unsupported hosts fail preflight with a fix hint.

## Likely files

- `deploy/scripts/install.sh`
- `deploy/scripts/upgrade.sh`
- `deploy/systemd/marsa.service`
- `deploy/compose.yaml`
- `docs/runbooks/install.md`
- `docs/runbooks/upgrade.md`

## Test notes

- Clean VM install test.
- Upgrade from the previous release with data preserved.
- Failed-migration and incompatible-schema tests.

## Requirement coverage

- `FR-OPS-01`
- `FR-OPS-02`

## Roadmap stories

- `E10.6`

## Dependencies

<!-- dependency-links -->
- Depends on `m5-03-dashboard-primary-flow`.
- Depends on `m4-03-health-gated-cutover`.

## Out of scope

- Kubernetes, multi-host installation, and an auto-update service.
