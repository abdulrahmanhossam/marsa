# Marsa — Project Documentation Progress

> Running log. Update after every phase so another session can resume without re-reading the whole conversation.
> Last updated: 2026-10-22 (Phase 7 complete)
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
- Phases 2–7 are approved/complete. The repository is ready for a final report and owner review; do not push or mutate GitHub without the owner.
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
| 5. AI-agent files | **COMPLETE** | `AGENTS.md`, `opencode.json`, `docs/ai/`, four `.opencode/skills/` packages |
| 6. Arabic explainer | **COMPLETE** | `docs/ar/project-explained.ar.md`, `docs/ar/glossary.ar.md`; 10-question quiz; honest competitor table |
| 7. Final review | **COMPLETE** | Root project files, `docs/README.md`, link/naming/contradiction audit, MVP cut line, validation |

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

## 6. Phase 5 — AI-agent files

### Work performed

- Wrote root `AGENTS.md` as the repository-wide operating contract: reading order, non-negotiables, canonical names, architecture in brief, issue workflow, commands, security rules, definition of done, and decisions to challenge.
- Wrote root `opencode.json`: schema, instruction files, project skill path, hidden read-only reference to `../ofuq-openship-analysis`, and permissions that deny `git push`, `gh issue`, `gh pr`, `gh release`, `gh api`, `gh repo edit`, and ask before recursive deletion.
- Wrote nine agent guides under `docs/ai/`: index, operating loop, architecture context, coding standards, testing, workflows, pitfalls, prompt library, and review checklist.
- Added four project skills under `.opencode/skills/`: `dotnet-conventions`, `deployment-engine-guidelines`, `issue-implementation-workflow`, and `doc-writing`.
- Checked all `AGENTS.md`, `docs/ai/`, and skill links; fixed the prior-analysis path in `docs/ai/README.md`.
- Documented that a running opencode session must be restarted after configuration or skill changes.

### Key decisions

- Agents get a short mandatory contract (`AGENTS.md`) plus on-demand depth (`docs/ai/` and four skills), rather than one oversized instruction file.
- GitHub writes stay owner-controlled; `opencode.json` denies them at the permission layer as well as documenting them.
- The prior analysis is available as a hidden read-only reference, not as copyable source.
- Skill names match their directories and use lowercase hyphenated identifiers.
- Agent guidance is **PROPOSED** operating policy until the owner reviews it; it does not override approved product requirements.

### Files written

| File | Purpose |
|---|---|
| `AGENTS.md` | Repository-wide agent and contributor contract |
| `opencode.json` | Instructions, project skills, reference, and write permissions |
| `docs/ai/README.md` | Index, reading order, allowed and forbidden actions, restart note |
| `docs/ai/agent-guide.md` | Task classification, planning, uncertainty, evidence, reporting |
| `docs/ai/architecture-context.md` | Boundaries, invariants, states, workers, health, routing |
| `docs/ai/coding-standards.md` | .NET, API, EF Core, Docker/Caddy, UI, and error rules |
| `docs/ai/testing-guide.md` | Test layers, commands, fixtures, required coverage |
| `docs/ai/workflows.md` | Issue, bug, docs, ADR, migration, API, and release procedures |
| `docs/ai/known-pitfalls.md` | Docker, Caddy, health, auth, persistence, secrets, Git, logs |
| `docs/ai/prompt-library.md` | Reusable prompts for implementation, review, bugs, docs, ADRs |
| `docs/ai/review-checklist.md` | Evidence-based self-review checklist |
| `.opencode/skills/*/SKILL.md` | Four project-specific skills |

### Validation

- `opencode debug config`: config resolved successfully with the project instructions, skill path, reference, and permissions.
- `opencode debug skill`: loaded nine skills, including all four project skills.
- `opencode.json` parses as JSON; skill frontmatter parses as YAML and names match directories.
- At Phase 5 close, `python3 scripts/check-docs.py` reported only the expected Phase 6/7 files missing (`README.md`, `LICENSE`, `docs/README.md`, both Arabic files), plus the planned Arabic explainer link. Those are resolved except the Phase 7 files.
- No GitHub write, issue creation, label sync, or push was performed.

### Git state

- Phase 5 commit: `docs: phase 5 ai agent files` (local only; not pushed).

---

## 7. Phase 6 — Arabic explainer

### Work performed

- Wrote `docs/ar/project-explained.ar.md` for a beginner who knows basic programming but not deployment. It uses Modern Standard Arabic, short sections, the harbor analogy, and progressive disclosure.
- Structured the narrative around **نورا**, an ASP.NET Core developer deploying `app.example.com`: setup, source connection, first deploy, failure handling, and rollback.
- Added Mermaid diagrams for the push-to-live sequence, the rollback decision, the system architecture, and the deployment state machine.
- Added a failure table that names the resulting state and whether the previous release keeps serving.
- Explained the core concepts: Git, image/container, project/environment/service, deployment/release, immutable snapshot, health gate, Caddy routing, envelope encryption, audit, worker lease, idempotency, and reconciliation.
- Added security sections on the Docker socket, the Caddy admin socket, secrets, authentication/authorization, and the limits of what Marsa can protect.
- Added a time-stamped, honest comparison with Openship, Coolify, and Dokku, including where Marsa does not win.
- Added a section on building with AI agents and the limits of agent autonomy.
- Added the M0–M6 roadmap, a beginner learning path, a first-deploy walkthrough, a 10-question quiz with hidden answers, an FAQ, and links to deeper docs.
- Wrote `docs/ar/glossary.ar.md` with 200+ grouped entries and stable anchors covering deployment, Git, Docker, networking, data, security, interfaces, .NET, project management, operations, states, and licensing.
- Clarified the difference between a **Marsa PAT** (`marsa_pat_`, API/CLI) and a **Git provider token** (GitHub/GitLab credential for private repositories). The explainer previously used “PAT” ambiguously; both files now distinguish them.
- Fixed glossary polish issues found during review: renamed “previous release” correctly, removed a duplicate firewall entry, and added missing terms such as host, control plane, build plan, cutover, Docker socket, Caddy admin socket, Docker Compose, Kubernetes, and MCP.

### Key decisions

- The Arabic explainer is a **companion entry point**, not a full translation of the English specification. It teaches the mental model and links to the canonical documents for exact contracts.
- The explainer uses Modern Standard Arabic and avoids dialect so it remains readable across regions.
- The glossary is the canonical Arabic terminology reference; future Arabic docs should reuse its terms and anchors.
- Competitor claims are explicitly time-stamped and framed as public-information observations, not benchmarks or superiority claims.
- Mermaid is used as text-based diagrams so the documents remain reviewable in Git; rendering is not part of CI.

### Files written

| File | Purpose |
|---|---|
| `docs/ar/project-explained.ar.md` | Beginner narrative from `git push` to a live HTTPS release, with diagrams, failure paths, quiz, and links |
| `docs/ar/glossary.ar.md` | Grouped Arabic glossary with stable anchors and Marsa-specific context |

### Validation

- Both Arabic files parse cleanly: no broken relative links, no broken in-page fragment links, and no duplicate `<a id>` anchors.
- All 10 quiz answer blocks have matching `<details>`/`</details>` tags.
- `python3 scripts/check-docs.py`: only the expected Phase 7 files remain missing (`README.md`, `LICENSE`, `docs/README.md`).
- `python3 scripts/validate-backlog.py`: 39 issues, 143 requirements mapped, 132 mandatory requirements covered.
- Mermaid blocks were reviewed manually; no Mermaid renderer is installed, so rendering was not executed.
- No GitHub write, issue creation, label sync, or push was performed.

### Git state

- Phase 6 commit: `docs: phase 6 arabic explainer` (local only; not pushed).

---

## 8. Phase 7 — Final review and repository entry points

### Work performed

- Reviewed the repository root, `docs/`, roadmap, requirements, identity, license/clean-room policy, security model, development environment, testing strategy, solution structure, backlog, and issue templates.
- Wrote the missing root `README.md` as a truthful documentation-only entry point: current status, product promise, scope, reading order, checks, supported-environment target, security warning, roadmap state, contribution rules, and license/name caveats.
- Added `LICENSE` with the full official Apache License 2.0 text, plus `NOTICE` and `THIRD-PARTY-NOTICES.md`. The license remains **PROPOSED** pending owner confirmation and legal review.
- Wrote `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, and `SECURITY.md`. No email address, public domain, security SLA, bounty, or released version was invented. Vulnerability reporting points to GitHub private reporting or the repository owner’s GitHub profile.
- Wrote `docs/README.md` as an index of every Markdown file under `docs/`: core documents, 20 ADRs, nine AI guides, two Arabic documents, the backlog, and all 39 issue drafts.
- Audited naming: no unintended `ofuq/marsa`, `Ofuq.Marsa.*`, `@marsa/*`, or invented public-domain variants were found. Intentional examples remain in `AGENTS.md`, `docs/00-identity.md`, and review prose.
- Fixed the stale `PROPOSED for Phase 2 review` status lines in `docs/01-product-requirements.md`, `docs/02-differentiation.md`, and `docs/08-roadmap.md`; Phase 2 is approved.
- Removed stale Phase 2 wording that implied the differentiation interviews had already happened. The bets remain approved working hypotheses, not externally validated market proof.
- Added the **MVP cut line** to `docs/08-roadmap.md`: 151 rows are 121 functional requirements + 30 NFRs; 132 are mandatory; 11 SHOULD, 1 COULD, and 7 OUT are outside the mandatory gate; the committed backlog is 39 vertical issues. A smaller external release is a **private preview**, not Marsa 0.1.
- Added **D-039** to record the cut line without demoting any MUST requirement.
- Updated this progress log and the documentation index statuses.

### Key decisions

- The repository remains documentation-only; no code, binary, image, release, or hosted product is claimed.
- `LICENSE` is present but **PROPOSED**; presence of the file does not complete legal or owner approval.
- The 0.1 gate remains all 132 mandatory requirements and all 39 issues. The cut line adds a fallback private-preview boundary instead of silently dropping MUST items.
- Root files use only channels that actually exist: GitHub repository metadata and private vulnerability reporting. No fake security email or domain.
- `docs/README.md` is the canonical index; every new Markdown file under `docs/` must be added there.

### Files written

| File | Purpose |
|---|---|
| `README.md` | Documentation-only project overview, status, scope, checks, and reading order |
| `LICENSE` | Full Apache License 2.0 text |
| `NOTICE` | Copyright and project notice |
| `THIRD-PARTY-NOTICES.md` | Current third-party status and release inventory requirements |
| `CONTRIBUTING.md` | Workflow, DCO, provenance, naming, security, review expectations |
| `CODE_OF_CONDUCT.md` | Community behavior, reporting, confidentiality, enforcement |
| `SECURITY.md` | Supported versions, private reporting, scope, safe harbor, hardening |
| `docs/README.md` | Complete documentation index and validation commands |
| `docs/01-product-requirements.md` | Approved status and Phase 2 confirmation wording |
| `docs/02-differentiation.md` | Approved status and validation wording |
| `docs/08-roadmap.md` | Approved status, MVP cut line, and 151/132/39 distinction |
| `docs/00-progress.md` | Phase 7 record, decision D-039, and updated next action |

### Validation

- `python3 scripts/check-docs.py`: **Documentation checks passed (102 Markdown files)** — required files present, relative links and anchors valid.
- `python3 scripts/validate-backlog.py`: **39 issues, 143 requirements mapped, 132 mandatory requirements covered**.
- `docs/README.md` indexes all 91 Markdown files under `docs/`, including all 39 issue drafts and 20 ADRs.
- Naming audit found no unintended variants; domain and trademark risks remain documented.
- No GitHub write, issue creation, label sync, push, or release was performed.
- Mermaid rendering and independent native Arabic editorial review remain known gaps, not Phase 7 blockers.

### Git state

- Phase 7 commit: `docs: phase 7 final review` (local only; not pushed).
- The commit hash is recorded in the final handoff.

---

## 9. Resume instructions

To resume after a context reset:

1. Read this file first.
2. Read `docs/00-vision.md` for intent and `docs/00-identity.md` for canonical naming.
3. Read `AGENTS.md` and `docs/ai/agent-guide.md` for the operating contract.
4. Read the design and backlog before implementation work:
   - `03-architecture.md`, `04-dotnet-solution-structure.md`, `05-data-model.md`, `06-api-contracts.md`, `07-security.md`, `09-testing-strategy.md`.
   - `07-risks-and-open-questions.md` for decisions and open questions.
   - `backlog/README.md` and the first ready issue for the current milestone.
5. All documentation phases are complete. Implementation starts at M0 only after owner approval; use `backlog/issues/m0-01-solution-skeleton.md`.
6. Do not overwrite the prior analysis folder.

### Current next action

Phase 7 is complete and committed locally. Deliver the final report; do not push, create issues, or mutate GitHub without the owner. The first implementation task is M0.1.

---

## 10. Decision log (cumulative)

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
| D-037 | Agent guidance uses a short contract plus on-demand guides and skills | Proposed | 2026-10-22 | `AGENTS.md` is mandatory; `docs/ai/` and four project skills add depth; `opencode.json` denies GitHub writes. |
| D-038 | Arabic explainer is a companion narrative, with the glossary as canonical Arabic terminology | Proposed | 2026-10-22 | The explainer teaches the mental model and links to canonical English specs; it is not a full translation or a second source of truth for contracts. |
| D-039 | 0.1 cut line is all 132 mandatory requirements via 39 issues; a smaller external release is a private preview | **PROPOSED** | 2026-10-22 | 151 rows = 121 functional + 30 NFRs; 11 SHOULD may be deferred by decision, but no MUST is silently dropped. M0–M5 (97 functional MUST) is the largest coherent preview, not 0.1. See `08-roadmap.md` §2.2. |

---

## 11. Known risks after Phase 7

- **Name/domain:** name is decided, but all three obvious domains are taken; trademark clearance is unknown; a prior container-deployment company used “Marsa” at `marsa.io`. Clearance and a domain are release gates; Rasif remains the contingency.
- **Scope creep:** the product can easily become a broad Coolify competitor. The MVP must stay single-host, single-service, Docker-only.
- **Differentiation is unvalidated:** the four bets are hypotheses. Interviews and concierge tests must run before the roadmap is treated as committed.
- **Competitor response:** Coolify/Openship can add .NET or Arabic positioning; Marsa must compete on focus and legibility, not feature matching.
- **Arabic-first authenticity:** translation alone is not enough; RTL and native copy need explicit acceptance criteria.
- **.NET-first credibility:** the first supported path must be excellent for ASP.NET Core, not merely “also works.”
- **Docker socket:** root-equivalent host access is the central security risk.
- **License contamination:** no GPL or unknown-license code in the default distribution.
- **Clean-room evidence:** the same analyst read Openship; the process must be described honestly, not as a formal double-blind clean room.
- **Backlog regeneration:** `coverage.md` and `milestones.md` were produced by a temporary generator outside the repository. Future issue edits need the generator restored or the indexes updated manually; `validate-backlog.py` checks mandatory coverage but does not regenerate them.
- **Agent configuration drift:** `opencode.json` and the four skills load only after restarting a running session. A stale session may show old permissions or miss project skills.
- **Arabic editorial review:** the explainer and glossary are written but not reviewed by an independent native editor. Terminology and tone should be reviewed before publication; the glossary anchors reduce drift.
- **Diagram rendering:** Mermaid syntax was reviewed manually but not rendered in CI. A broken diagram would not fail the current checks; add a render check if diagrams become a release artifact.
- **Arabic docs as a second surface:** the explainer can drift from the English specs. Treat the specifications as canonical for contracts and update the explainer when those contracts change.
- **Scope count:** the Phase 7 cut line resolves the ambiguity: 132 mandatory requirements across 39 issues define 0.1; the remaining 19 rows are SHOULD/COULD/OUT. The residual risk is delivery breadth and integration quality, not the count itself.
