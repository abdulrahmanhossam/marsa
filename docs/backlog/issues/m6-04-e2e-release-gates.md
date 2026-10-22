---
title: "M6: Run the release E2E suite across browsers and failure scenarios"
labels: [type/feature, area/testing, area/release, priority/p0, status/ready, size/l]
milestone: "M6"
epic: "E10"
size: "l"
depends_on: [m6-01-install-and-upgrade, m6-02-backup-restore-runbooks, m5-07-hardening-matrix, m5-04-i18n-rtl-accessibility]
requirements: [NFR-COMP-02]
stories: [E10.7]
---

## Context

The release candidate passes only when the complete product journey works on a disposable host and in the supported browsers. E2E is the integration proof that feature tests cannot provide.

## Scope

- Run happy path, failed build, failed health, rollback, cancellation, and route conflict on a disposable Docker runner.
- Run the browser matrix for current and previous Chrome, Firefox, Safari, and Edge.
- Verify the Arabic RTL flow and the English flow.
- Verify install, upgrade, backup/restore, and diagnostics as release gates.
- Publish test artifacts and a redacted failure bundle.
- Block release on any unexplained failure.

## Acceptance criteria

- [ ] All E2E scenarios pass on the release commit.
- [ ] Supported browser versions pass the primary flow and RTL checks.
- [ ] A failed scenario produces a redacted artifact bundle.
- [ ] Install/upgrade/backup/restore gates pass in the same run.
- [ ] The release checklist is complete and linked from the release notes.

## Likely files

- `tests/Marsa.E2E.Tests/`
- `.github/workflows/e2e.yml`
- `eng/smoke-e2e.sh`
- `docs/release/checklist.md`

## Test notes

- Full E2E suite on a disposable host.
- Browser matrix and RTL run.
- Release-gate orchestration and artifact capture.

## Requirement coverage

- `NFR-COMP-02`

## Roadmap stories

- `E10.7`

## Dependencies

<!-- dependency-links -->
- Depends on `m6-01-install-and-upgrade`.
- Depends on `m6-02-backup-restore-runbooks`.
- Depends on `m5-07-hardening-matrix`.
- Depends on `m5-04-i18n-rtl-accessibility`.

## Out of scope

- Load testing at production scale, chaos engineering, and continuous production canaries.
