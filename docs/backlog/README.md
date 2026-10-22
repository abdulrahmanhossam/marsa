# Marsa — MVP Backlog

> Status: **PROPOSED** backlog for 0.1. Last reviewed: 2026-10-22.

The backlog turns the approved requirements and roadmap into 39 implementation issues. Each issue is self-contained enough for a developer or an AI agent to start without re-reading the entire specification.

## 1. What is here

| File | Purpose |
|---|---|
| `issues/*.md` | Issue drafts with YAML frontmatter, context, scope, acceptance criteria, likely files, tests, requirements, and dependencies. |
| `coverage.md` | Generated requirement-to-issue and roadmap-story coverage. |
| `milestones.md` | Generated milestone index. |
| `README.md` | This process guide. |

The drafts are not GitHub issues until a maintainer runs the creation script with `--apply`.

## 2. Coverage

- **151 total requirements**: 121 functional IDs and 30 NFR IDs.
- **102 MUST** + **30 NFR** = **132 mandatory requirements**, all mapped.
- **11 SHOULD** and **1 COULD** are mapped where they fit the MVP; no mandatory gap.
- **7 OUT** requirements are explicitly out of scope for 0.1.
- **104 roadmap stories** are grouped into the 39 issues; none is unmapped.

The validator enforces mandatory coverage:

```bash
python3 scripts/validate-backlog.py
```

## 3. Milestones

| Milestone | Theme | Exit |
|---|---|---|
| M0 | Foundation | Buildable skeleton, local stack, health, migration, server image, CI |
| M1 | Setup and identity | Setup, login, sessions, roles, PATs, tenant isolation, API contract |
| M2 | Projects, detect, and build | Project/source, webhooks, detection, `marsa.json`, hardened export, image build |
| M3 | Deploy and observe | Container runtime, admission, worker recovery, cancellation, logs, realtime |
| M4 | Route and secure | Caddy route set, domains, TLS, health-gated cutover, secrets, audit |
| M5 | Operate and recover | Rollback, CLI, full dashboard, Arabic/RTL, diagnostics, hardening |
| M6 | Release candidate | Install/upgrade, backup/restore, SBOM/license, E2E, release gates |

Work starts at the lowest-numbered ready issue whose dependencies are complete. Do not start an issue marked `status/blocked`.

## 4. Issue format

Frontmatter is machine-readable and is stripped before the issue is posted:

```yaml
title: "M3: ..."
labels: [type/feature, area/deploy, priority/p0, status/ready, size/l]
milestone: "M3"
epic: "E5"
size: "l"
depends_on: [m3-01-runtime-container]
requirements: [FR-DEP-01, NFR-REL-01]
stories: [E5.1]
```

Slugs are stable. Use them in branches, commits, and dependency notes. The body always contains:

- **Context** — why the work exists.
- **Scope** — included behavior.
- **Acceptance criteria** — verifiable outcomes.
- **Likely files** — starting points, not a rigid design.
- **Test notes** — the suites or scenarios that prove it.
- **Requirement coverage** — IDs from `01-product-requirements.md`.
- **Roadmap stories** — IDs from `08-roadmap.md`.
- **Dependencies** — blocking issue slugs.
- **Out of scope** — explicit non-goals.

## 5. Labels

The taxonomy is in [`labels.yml`](../../labels.yml):

- `type/*`: feature, bug, task, docs, security, infra.
- `area/*`: platform, auth, projects, source, detection, build, runtime, deploy, edge, observability, secrets, security, audit, cli, ui, api, ops, testing, docs, reliability, release.
- `priority/*`: p0 through p3.
- `status/*`: ready, blocked, needs-design, needs-review.
- `size/*`: xs through xl.
- `good-first-issue`, `help-wanted`.

## 6. Creating the GitHub objects

Dry-run first. These commands make no GitHub changes:

```bash
./scripts/sync-labels.sh --dry-run
./scripts/create-issues.sh --dry-run
```

Apply only after the repository exists and `gh auth login` succeeds:

```bash
./scripts/sync-labels.sh --apply
./scripts/create-issues.sh --apply
```

The scripts are idempotent by title for issues and by name for labels. Dependency placeholders are replaced with real issue numbers after creation. The scripts never push code, close issues, or change repository settings.

## 7. Roadmap alignment

The backlog follows the requirement milestones. Four roadmap milestone groups disagreed with the approved PRD and were corrected in `08-roadmap.md`:

| Story | Old | Corrected | Reason |
|---|---|---|---|
| E2.1–E2.4 | M1 | M2 | Project CRUD and source connections are M2 in the PRD. |
| E0.9 | M0 | M6 | License/SBOM review is a release gate, not a skeleton task. |
| E5.7 | M4 | M5 | Rollback backend and UX ship together in M5. |
| E9.9 | M2 | M5 | The full bilingual shell ships with the Arabic UX in M5. |

No content was deleted; only the milestone labels were aligned.

## 8. Sizing and parallelism

`size/xl` issues are cohesive but large. Split an XL issue only when the split preserves a testable vertical slice; do not split by layer. Safe parallel streams after M2:

- **Runtime/orchestration:** M3 runtime, worker, reconciler.
- **Edge/secrets:** M4 Caddy, domains, cutover, secrets.
- **CLI/dashboard:** after their backend dependencies are ready.
- **Release:** M6 install/upgrade, backup, supply chain, E2E.

Do not run two issues that both edit the deployment state machine, schema, or Caddy route compiler without coordinating.

## 9. Definition of done

An issue is done when:

- All acceptance criteria pass.
- Unit/integration/contract tests cover the new behavior and failure paths.
- No secret canary appears in logs, events, audit, API, or telemetry.
- Role and tenant boundaries are tested.
- Documentation and ADRs are updated in the same pull request.
- `./eng/verify.sh` passes, or the documentation equivalent does.
- The commit references the requirement and story IDs.
