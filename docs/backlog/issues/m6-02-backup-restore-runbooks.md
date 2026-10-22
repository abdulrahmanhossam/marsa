---
title: "M6: Prove backup/restore and publish the operator runbooks"
labels: [type/feature, area/ops, area/docs, priority/p0, status/ready, size/l]
milestone: "M6"
epic: "E10"
size: "l"
depends_on: [m6-01-install-and-upgrade, m4-04-secrets-envelope]
requirements: [FR-OPS-03, FR-OPS-05, NFR-REL-08]
stories: [E10.5, E10.8, E8.7]
---

## Context

A backup without the master key is useless, and a runbook that only its author can follow is not a recovery plan. The drill must restore database, deployment state, and secrets, then pass readiness.

## Scope

- Add a PostgreSQL backup script with checksums and retention guidance.
- Document master-key backup and storage separately from the database.
- Add a restore script and a full drill that restores projects, deployments, secrets, and audit.
- Write install, upgrade, backup, restore, master-key rotation, troubleshooting, and uninstall runbooks.
- Have someone who did not write the feature execute the drill and record gaps.
- Include copy-paste-safe commands with placeholders and warnings.

## Acceptance criteria

- [ ] A backup and restore drill restores the instance and passes readiness.
- [ ] Deployment history and active release are visible after restore.
- [ ] Secrets work with the restored master key; a missing key fails closed.
- [ ] No secret canary appears in backup logs or runbook output.
- [ ] A second operator completes the drill from the runbook.
- [ ] Uninstall is documented without deleting data by surprise.

## Likely files

- `deploy/scripts/backup-postgres.sh`
- `deploy/scripts/restore-postgres.sh`
- `docs/runbooks/backup-restore.md`
- `docs/runbooks/master-key-rotation.md`
- `docs/runbooks/uninstall.md`

## Test notes

- Automated backup/restore drill in CI or a disposable VM.
- Missing-master-key restore failure test.
- Second-operator runbook walkthrough.

## Requirement coverage

- `FR-OPS-03`
- `FR-OPS-05`
- `NFR-REL-08`

## Roadmap stories

- `E10.5`
- `E10.8`
- `E8.7`

## Dependencies

<!-- dependency-links -->
- Depends on `m6-01-install-and-upgrade`.
- Depends on `m4-04-secrets-envelope`.

## Out of scope

- A backup scheduler UI, cloud object storage integration, and point-in-time recovery automation.
