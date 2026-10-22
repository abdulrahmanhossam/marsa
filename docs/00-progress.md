# Marsa — Project Documentation Progress

> Running log. Update after every phase so another session can resume without re-reading the whole conversation.
> Last updated: 2026-10-22 (Phase 4 complete)
> Repository: `/home/abdulrahman/projects/marsa`
> Prior analysis (read-only): `/home/abdulrahman/projects/ofuq-openship-analysis/`
> Source analyzed there: Openship @ `95b8ef715` (branch `feat/GH-1168-disable-service-swap`, based on upstream `b21503155`).

**Legend.** **VERIFIED** = checked publicly on the date shown. **INFERRED** = derived from the prior analysis. **PROPOSED** = a Marsa decision awaiting confirmation. **UNKNOWN** = not verified.

---

## 0. Working agreement

- This repository is **documentation and project setup only** at this stage. No product code.
- No GitHub writes, issues, pushes, or releases. No `gh` mutation commands.
- Clean-room: behavior and design in our own words. No copied Openship code, comments, tests, schemas, migrations, assets, or prose. No GPL component in the default distribution.
- One file at a time; after writing, re-read for contradictions and cross-link.
- Phase 2 is approved. Continue autonomously through Phase 7; stop only if truly blocked.
- Do not ask questions. Mark needed decisions **PROPOSED** and record them in `docs/07-risks-and-open-questions.md`.
- Every phase ends with a two-line status, then the next phase starts immediately.
- License is **PROPOSED** Apache-2.0; do not treat it as final until the user confirms.

---

## 1. Phase status

| Phase | Status | Deliverables |
|---|---|---|
| 1. Name and positioning | **CONFIRMED** | `docs/00-vision.md`, `docs/00-identity.md`; name checks recorded below |
| 2. Differentiation and requirements | **CONFIRMED** | `docs/02-differentiation.md`, `docs/01-product-requirements.md`, `docs/08-roadmap.md` |
| 3. Technical documentation | **COMPLETE** | `docs/03`–`07`, `09`–`12`, 20 ADRs, decision/risk log |
| 4. GitHub setup and backlog | **COMPLETE** | 39 issue drafts, coverage, labels, templates, CI, dry-run scripts |
| 5. AI-agent files | **IN PROGRESS** | `AGENTS.md`, `docs/ai/`, `.opencode/skills/`, `opencode.json` |
| 6. Arabic explainer | Not started | `docs/ar/project-explained.ar.md`, `docs/ar/glossary.ar.md` |
| 7. Final review | Not started | Link/naming/contradiction review; updates to indexes |

---

## 2. Phase 1 — Name and positioning

### 2.1 Work performed

- Confirmed the prior analysis folder is present. Note: the original request said `../ofuq-openship-analysis/`; the working directory itself was that folder, so the user approved creating the new repository at `/home/abdulrahman/projects/marsa` and keeping the analysis read-only.
- Checked GitHub organization/user/repository, NuGet, npm, and domain records with public read-only requests on 2026-10-22.
- Proposed fallback names and checked their obvious public collisions.
- Wrote `docs/00-vision.md`.

### 2.2 Availability results (VERIFIED on 2026-10-22)

| Target | Result | Notes |
|---|---|---|
| GitHub organization `ofuqq` | **Confirmed by owner**; HTTP 200 | Handle has two `q`s. Earlier free-handle check was for `ofuq`, which is not the project handle. |
| GitHub repository `ofuqq/marsa` | **Confirmed by owner**; HTTP 200 | Remote `https://github.com/ofuqq/marsa.git`; default branch `main`. |
| NuGet `ofuqq.Marsa` | HTTP 404 | Appears available. Publish and prefix reservation unverified. |
| npm `@ofuqq/marsa` | HTTP 404 | Appears available. Scope policy and publish unverified. |
| `marsa.dev` | Registered; expires 2027-03-04; DNS to Vercel | Not available at normal registration. Price UNKNOWN. |
| `marsa.io` | Registered; expires 2027-07-26; Cloudflare NS; domain does not resolve | Not available. A third-party directory (Tracxn) lists a Jordan-based “Marsa” at this domain as a cloud container deployment company founded in 2020, marked deadpooled. That is a prior use in the same product category. |
| `marsa.app` | Registered; expires 2027-09-22; Cloudflare | Not available. |
| Trademark | **UNKNOWN** | No legal search performed. Existing Marsa brands exist outside software. |
| Social handles | **UNKNOWN** | Not checked. |

**Honest limits:** these are public-registry observations, not reservations. GitHub can refuse a handle; NuGet/npm can refuse a publish; domains can be listed for sale at unknown prices; trademarks require a qualified search.

### 2.3 Fallback names (contingency)

1. **Rasif** (رصيف) — quay/platform. Strongest fallback; exact GitHub org, npm, and `ofuqq.Rasif` appear free; no public DNS/WHOIS record found for `rasif.dev`, `rasif.io`, `rasif.app` in a quick check (not a registrability guarantee).
2. **Marfa** (مرفأ) — harbor. Exact GitHub org, npm, and `ofuqq.Marfa` appear free, but the name collides with Marfa, Texas, and `marfa.io`/`marfa.app` are in use.

### 2.4 Decisions confirmed in Phase 1

- Product name: **Marsa** (DECIDED). Brand: **Ofuq**. GitHub handle: **`ofuqq`**. Repository: `ofuqq/marsa`. Tagline: “Where your code docks.”
- Naming roles: CLI `marsa`, config `marsa.json`, env prefix `MARSA_`, Docker labels `io.marsa.*`, token prefix `marsa_pat_`, namespaces `Marsa.*`, NuGet `ofuqq.Marsa.*`, npm `@ofuqq/*`. Canonical source: `docs/00-identity.md`.
- Public domain is **not decided** because all three obvious domains are registered. Specs must not claim one. Use `urn:marsa:...` identifiers and relative links until a domain is secured.
- Product positioning: narrow, .NET-first, Arabic-first, single-host, legible, safe by default.
- License: **PROPOSED** Apache-2.0 (not final).
- MVP excludes MCP/AI mutation, mail, Compose, multi-service, multi-host, app catalog, and a plugin marketplace.

### 2.5 Phase 1 gate outcome

- [x] **Marsa** retained; Rasif/Marfa remain documented fallbacks only.
- [x] Naming roles approved; GitHub handle `ofuqq` and repository URL confirmed.
- [x] Name values centralized in `docs/00-identity.md`.
- [x] Vision target users and non-goals accepted by the instruction to continue to Phase 2.
- [ ] Public domain remains undecided; resolve before launch.
- [ ] Trademark clearance remains required before public launch; track in `docs/07-security.md` and `docs/12-license-and-clean-room.md`.
- [ ] Apache-2.0 remains a proposal, not a final legal decision.

### 2.6 Files written

| File | Purpose |
|---|---|
| `docs/00-vision.md` | Problem, users, vision, principles, non-goals, success criteria, name checks, fallbacks. |
| `docs/00-identity.md` | Single source of truth for product name, brand, GitHub handle, repository URL, and identifier prefixes. |
| `docs/00-progress.md` | This log. |

---

## 3. Phase 2 — Differentiation and requirements

### 3.1 Work performed

- Re-read the prior analysis for the MVP boundary, architecture invariants, risks, and license constraints.
- Checked public product pages and repository metadata for Openship, Coolify, Dokku, and DeployWise on 2026-10-22.
- Wrote `docs/02-differentiation.md`: honest comparison, four differentiation bets, costs, validation plan, “where we will not win,” positioning, and sources.
- Wrote `docs/01-product-requirements.md`: MVP behavior, stable requirement IDs, non-functional requirements, data invariants, acceptance gates, metrics, and open questions.
- Wrote `docs/08-roadmap.md`: M0–M6 milestones, epics/stories, dependencies, definition of done, release plan, post-MVP direction, and kill criteria.
- Checked the three documents for internal contradictions and naming consistency with `docs/00-identity.md`.

### 3.2 Proposed decisions for the Phase 2 gate

- **Differentiation:** lead with .NET-native legibility, with Arabic/RTL as the most distinctive wedge; keep the product narrow and legible; do not compete on breadth.
- **MVP boundary:** one Linux host, one service per deployment, Docker, PostgreSQL, Caddy, local auth, dashboard + CLI + API; no Compose, multi-host, catalog, or managed databases.
- **Requirements:** every MVP behavior has a requirement ID and acceptance criteria; `01-product-requirements.md` is the baseline.
- **Roadmap:** M0–M6 is the construction order; the initial backlog contains only the MVP milestone. Sizes are relative; no calendar estimates.
- **Validation:** the differentiation bets remain hypotheses until interviews and concierge tests are run.

### 3.3 Open items for Phase 2 confirmation

- [ ] Approve the four differentiation bets and the “where we will not win” list.
- [ ] Approve the MVP boundary and confirm no MUST requirement is missing.
- [ ] Approve `01`, `02`, and `08` as the baseline for Phase 3.
- [ ] Confirm Phase 3 may start (architecture, solution structure, data model, API, security, testing, environment, release, license/clean-room, ADRs).

### 3.4 Files written

| File | Purpose |
|---|---|
| `docs/02-differentiation.md` | Market comparison, four bets, costs, validation plan, positioning, sources. |
| `docs/01-product-requirements.md` | Functional and non-functional requirements, MVP boundary, acceptance gates. |
| `docs/08-roadmap.md` | Milestones, epics/stories, dependencies, release plan, post-MVP direction. |
| `docs/00-progress.md` | This log. |

### 3.5 Git state

- Default branch: `main`.
- Remote `origin`: `https://github.com/ofuqq/marsa.git`.
- Phase 1 commit: `00e84b4` (`docs: project vision and initial setup`).
- Phase 2 commit: `docs: differentiation, requirements, and roadmap` (local only; not pushed).
- No branch protection or GitHub settings were changed.

---

## 4. Phase 3 — Technical documentation

### Work performed

- Re-read the prior architecture, solution-structure, data/API, risk, roadmap, and license analyses.
- Wrote the architecture baseline, including C4 context/container/component diagrams, invariants, topology, workflows, state machine, rollback, reconciliation, domains/TLS, reliability, and observability.
- Wrote the .NET solution structure, project references, folder layout, package policy, conventions, composition, error handling, and CI gates.
- Wrote the data model (tables, relationships, constraints, enums, snapshots, leases, retention) and the API contract (auth, endpoints, errors, idempotency, pagination, realtime, webhooks, `marsa.json`).
- Wrote the security model and threat boundaries, testing strategy, development environment, release/versioning policy, and license/clean-room policy.
- Wrote 20 ADRs covering the architecture decisions required by the phase.

### Key decisions

- Canonical deployment states are the Phase 2 names: `queued` → `preparing` → `building` → `deploying` → `health_checking` → `routing` → terminal outcome.
- Caddy applies the complete Marsa-managed route set, including the static control route, over a Unix socket.
- Runtime application logs are persisted separately from deployment logs (14-day default).
- Generic idempotency records cover deployments, rollbacks, domains, and secrets.
- The Docker socket is accepted as root-equivalent residual risk for 0.1; a socket proxy/host agent is a release-review trigger.
- First-party code and docs are Apache-2.0 **PROPOSED**; no GPL/unknown material in the default distribution.

Full decision log with rejected alternatives: [`07-risks-and-open-questions.md`](07-risks-and-open-questions.md).

### Files written

| File | Purpose |
|---|---|
| `docs/03-architecture.md` | C4 views, topology, modules, workflows, state machine, reliability |
| `docs/04-dotnet-solution-structure.md` | Solution/project layout, references, conventions, CI |
| `docs/05-data-model.md` | PostgreSQL schema, constraints, enums, retention, migrations |
| `docs/06-api-contracts.md` | `/api/v1` conventions, endpoints, errors, realtime, webhooks, `marsa.json` |
| `docs/07-security.md` | Threat model, auth, authorization, secrets, isolation, SSRF, supply chain |
| `docs/07-risks-and-open-questions.md` | Decisions, open questions, risks, assumptions, spikes |
| `docs/09-testing-strategy.md` | Test pyramid, suites, E2E, security, contract, CI |
| `docs/10-dev-environment.md` | Prerequisites, local stack, configuration, debugging |
| `docs/11-release-and-versioning.md` | SemVer, artifacts, install/upgrade, backup, release gates |
| `docs/12-license-and-clean-room.md` | Apache-2.0 policy, provenance, dependency rules, SBOM |
| `docs/adr/0001`–`0020` | Architecture decision records |

### Git state

- Phase 3 commit: `docs: phase 3 architecture and design` (local only; not pushed).

---

## 5. Phase 4 — GitHub setup and backlog

### Work performed

- Wrote 39 vertically sliced issue drafts in `docs/backlog/issues/`, grouped by milestone and epic, each with context, scope, acceptance criteria, likely files, test notes, requirement IDs, roadmap stories, and dependencies.
- Mapped all **102 MUST** functional requirements, all **30 NFRs**, all **11 SHOULD** where they fit, and all **104 roadmap stories**. The seven `OUT` requirements and the one `COULD` remain explicitly out of scope or post-MVP.
- Added `labels.yml` with 42 labels, issue forms, a pull-request template, CODEOWNERS, Dependabot, and a docs/backlog CI workflow.
- Added `scripts/sync-labels.sh` and `scripts/create-issues.sh`; both default to dry-run and require `--apply` before any GitHub mutation.
- Added `scripts/check-docs.py`, `scripts/validate-backlog.py`, `docs/backlog/README.md`, generated `coverage.md`, and `milestones.md`.
- Corrected four stale roadmap milestone labels without deleting content; recorded as D-035.

### Files written

| File | Purpose |
|---|---|
| `labels.yml` | Label taxonomy used by templates and scripts |
| `.github/ISSUE_TEMPLATE/*.yml` | Bug, feature, task, docs forms and config |
| `.github/PULL_REQUEST_TEMPLATE.md` | Requirement/ADR/test/security checklist |
| `.github/workflows/ci.yml` | Link, coverage, and dry-run validation |
| `.github/CODEOWNERS`, `.github/dependabot.yml` | Ownership and action updates |
| `scripts/sync-labels.sh` | Idempotent label sync, dry-run default |
| `scripts/create-issues.sh` | Idempotent issue creation, dependency linking, dry-run default |
| `scripts/check-docs.py` | Relative-link and required-file check |
| `scripts/validate-backlog.py` | Frontmatter, labels, dependencies, mandatory coverage |
| `docs/backlog/README.md` | Issue format, workflow, coverage, sizing |
| `docs/backlog/issues/*.md` | 39 issue drafts |
| `docs/backlog/coverage.md` | Requirement and story coverage |
| `docs/backlog/milestones.md` | Milestone index |

### Validation

- `python3 scripts/validate-backlog.py`: 39 issues, 143 requirements mapped, 132 mandatory requirements covered.
- `./scripts/sync-labels.sh --dry-run`: 42 labels, no GitHub changes.
- `./scripts/create-issues.sh --dry-run`: 39 issues, no GitHub changes.
- Issue forms, labels, Dependabot, and workflow YAML parse with PyYAML locally.

### Git state

- Phase 4 commit: `docs: phase 4 github backlog` (local only; not pushed).

---

## 6. Resume instructions

To resume after a context reset:

1. Read this file first.
2. Read `docs/00-vision.md` for intent and `docs/00-identity.md` for canonical naming.
3. Read the design and backlog before implementation work:
   - `03-architecture.md`, `04-dotnet-solution-structure.md`, `05-data-model.md`, `06-api-contracts.md`, `07-security.md`, `09-testing-strategy.md`.
   - `07-risks-and-open-questions.md` for decisions and open questions.
   - `backlog/README.md` and the first ready issue for the current milestone.
4. Continue at the first phase whose status is not `COMPLETE`/`CONFIRMED`.
5. Do not overwrite the prior analysis folder.

### Current next action

Phase 4 is complete and committed. Continue with Phase 5: `AGENTS.md`, `opencode.json`, `docs/ai/*`, and the four `.opencode/skills/` packages. Then Phase 6 and Phase 7 without stopping.

---

## 7. Decision log (cumulative)

| ID | Decision | Status | Date | Notes |
|---|---|---|---|---|
| D-001 | New repository at `/home/abdulrahman/projects/marsa`; analysis remains read-only | Confirmed by user | 2026-10-22 | Avoids mixing analysis and product docs. |
| D-002 | Product name Marsa; brand Ofuq | **DECIDED** | 2026-10-22 | Owner confirmed. Prior same-category use at `marsa.io` accepted as a risk; trademark clearance before public launch remains open. |
| D-003 | Apache-2.0 outbound license | Proposed | 2026-10-22 | Not final; see `docs/12-license-and-clean-room.md` later. |
| D-004 | Single-host Linux + Docker MVP | Proposed, inherited | 2026-10-22 | Prior analysis `03-architecture.md` §1.4. |
| D-005 | No GPL components in default distribution | Proposed, inherited | 2026-10-22 | Prior analysis `08-license-notes.md`. |
| D-006 | MCP/AI mutation deferred beyond MVP | Proposed, inherited | 2026-10-22 | Prior analysis `03-architecture.md` §14.2. |
| D-007 | GitHub handle `ofuqq`; repository `ofuqq/marsa`; default branch `main` | **DECIDED** | 2026-10-22 | Two `q`s in URLs/remotes/CODEOWNERS/badges/package identifiers; brand prose stays Ofuq. |
| D-008 | Canonical identity lives in `docs/00-identity.md` | **DECIDED** | 2026-10-22 | Single source for product name, brand, handle, repo URL, and identifier prefixes; other docs must not invent variants. |
| D-009 | MVP boundary and M0–M6 construction order | **CONFIRMED** | 2026-10-22 | Phase 2 approved; see `01-product-requirements.md` and `08-roadmap.md`. |
| D-010 | Four differentiation bets (D1–D4) | **CONFIRMED** | 2026-10-22 | Phase 2 approved; still hypotheses to validate with users. |
| D-035 | Backlog follows PRD milestones; four stale roadmap rows corrected | Proposed | 2026-10-22 | E2.1–E2.4 → M2, E0.9 → M6, E5.7 → M5, E9.9 → M5; see `07-risks-and-open-questions.md`. |
| D-036 | 39 vertically sliced MVP issues; cohesive XL issues allowed | Proposed | 2026-10-22 | Every MUST, NFR, and roadmap story is mapped; split XL before parallel work. |

---

## 8. Known risks carried into Phase 5

- **Name/domain:** name is decided, but all three obvious domains are taken; trademark clearance is unknown; a prior container-deployment company used “Marsa” at `marsa.io`. Clearance and a domain are release gates; Rasif remains the contingency.
- **Scope creep:** the product can easily become a broad Coolify competitor. The MVP must stay single-host, single-service, Docker-only.
- **Differentiation is unvalidated:** the four bets are hypotheses. Interviews and concierge tests must run before the roadmap is treated as committed.
- **Competitor response:** Coolify/Openship can add .NET or Arabic positioning; Marsa must compete on focus and legibility, not feature matching.
- **Arabic-first authenticity:** translation alone is not enough; RTL and native copy need explicit acceptance criteria.
- **.NET-first credibility:** the first supported path must be excellent for ASP.NET Core, not merely “also works.”
- **Docker socket:** root-equivalent host access is the central security risk.
- **License contamination:** no GPL or unknown-license code in the default distribution.
- **Clean-room evidence:** the same analyst read Openship; the process must be described honestly, not as a formal double-blind clean room.
