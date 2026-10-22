# Marsa — Project Documentation Progress

> Running log. Update after every phase so another session can resume without re-reading the whole conversation.
> Last updated: 2026-10-22 (Phase 2 complete; awaiting confirmation)
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
- Stop for user confirmation after **Phase 1**, **Phase 2**, and **Phase 5**.
- Ask at most one question at a time, only when blocked.
- Every phase ends with a five-line summary.
- License is **PROPOSED** Apache-2.0; do not treat it as final until the user confirms.

---

## 1. Phase status

| Phase | Status | Deliverables |
|---|---|---|
| 1. Name and positioning | **CONFIRMED** | `docs/00-vision.md`, `docs/00-identity.md`; name checks recorded below |
| 2. Differentiation and requirements | **AWAITING CONFIRMATION** | `docs/02-differentiation.md`, `docs/01-product-requirements.md`, `docs/08-roadmap.md` |
| 3. Technical documentation | Not started | `docs/03`–`07`, `09`–`12`, ADRs |
| 4. GitHub setup and backlog | Not started | `.github/`, `docs/backlog/`, `scripts/` |
| 5. AI-agent files | Not started | `AGENTS.md`, `docs/ai/`, `.opencode/skills/`, `opencode.json` |
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

## 4. Resume instructions

To resume after a context reset:

1. Read this file first.
2. Read `docs/00-vision.md` for intent and `docs/00-identity.md` for canonical naming.
3. Read the prior analysis files relevant to the next phase:
   - Phase 3: `03-architecture.md`, `04-dotnet-solution-structure.md`, `05-data-model-and-api.md`, `07-risks-and-open-questions.md`, `08-license-notes.md`.
   - Phase 4: `06-roadmap-and-mvp.md`, `01-product-requirements.md`, and this file.
4. Continue at the first phase whose status is not `COMPLETE`/`CONFIRMED`.
5. Do not overwrite the prior analysis folder.

### Current next action

Phase 2 is written, reviewed, and committed locally. Wait for the Phase 2 gate. On approval, start Phase 3 with `docs/03-architecture.md` first (one file at a time), then `04`–`07` and `09`–`12`, plus the ADRs. Stop again after Phase 5.

---

## 5. Decision log (cumulative)

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
| D-009 | MVP boundary and M0–M6 construction order | Proposed | 2026-10-22 | Awaiting Phase 2 confirmation; see `01-product-requirements.md` and `08-roadmap.md`. |
| D-010 | Four differentiation bets (D1–D4) | Proposed | 2026-10-22 | Awaiting Phase 2 confirmation; hypotheses to validate, not proven claims. |

---

## 6. Known risks carried into Phase 3

- **Name/domain:** name is decided, but all three obvious domains are taken; trademark clearance is unknown; a prior container-deployment company used “Marsa” at `marsa.io`. Clearance and a domain are release gates; Rasif remains the contingency.
- **Scope creep:** the product can easily become a broad Coolify competitor. The MVP must stay single-host, single-service, Docker-only.
- **Differentiation is unvalidated:** the four bets are hypotheses. Interviews and concierge tests must run before the roadmap is treated as committed.
- **Competitor response:** Coolify/Openship can add .NET or Arabic positioning; Marsa must compete on focus and legibility, not feature matching.
- **Arabic-first authenticity:** translation alone is not enough; RTL and native copy need explicit acceptance criteria.
- **.NET-first credibility:** the first supported path must be excellent for ASP.NET Core, not merely “also works.”
- **Docker socket:** root-equivalent host access is the central security risk.
- **License contamination:** no GPL or unknown-license code in the default distribution.
- **Clean-room evidence:** the same analyst read Openship; the process must be described honestly, not as a formal double-blind clean room.
