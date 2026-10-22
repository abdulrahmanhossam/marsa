# AGENTS.md — Marsa

This file is the operating contract for AI agents and human contributors. It is loaded by opencode and applies to the whole repository.

## 1. What this repository is

Marsa (مرسى) is a clean-room, self-hosted deployment platform for a single Linux host, built with .NET 10, PostgreSQL, Docker, and Caddy. The brand is **Ofuq**; the GitHub handle is **`ofuqq`**.

The current state is recorded in public specifications, the issue drafts, and the owner's private handoff. Do not assume product code exists. At the documentation stage, "implementation" means editing specifications, issue drafts, templates, scripts, and configuration.

The owner may provide a private handoff or progress file. Treat it as context, not as a public contract: never commit, quote, or link it from public docs.

## 2. Read before acting

1. [`docs/00-identity.md`](docs/00-identity.md) — canonical names and identifiers.
2. [`docs/01-product-requirements.md`](docs/01-product-requirements.md) — approved requirements and milestone IDs.
3. [`docs/03-architecture.md`](docs/03-architecture.md) and [`docs/04-dotnet-solution-structure.md`](docs/04-dotnet-solution-structure.md) — system and code boundaries.
4. [`docs/07-risks-and-open-questions.md`](docs/07-risks-and-open-questions.md) — proposed decisions, open questions, risks.
5. [`docs/backlog/README.md`](docs/backlog/README.md) — issue format and coverage.
6. [`docs/ai/definition-of-done.md`](docs/ai/definition-of-done.md) — the completion gate.
7. For any implementation task, the issue draft under `docs/backlog/issues/`.

## 3. Non-negotiables

- **No GitHub writes without explicit user instruction:** no push, issue creation, PR, release, branch protection, or `gh` mutation. Use the dry-run scripts only.
- **Before any push, stop and list any file that looks personal** — progress logs, Arabic explainer, handoff, notes, prompts, secrets, `.env`, or private data. Never push it.
- **`.local/` is private:** never force-add, commit, push, link from public docs, or include it in a release. Never add `/.local/` to `.gitignore`; the local exclusion belongs in `.git/info/exclude`.
- **No secrets in the repository, logs, prompts, tests, or screenshots.** Never print a token, password, master key, or private repository URL.
- **Clean-room:** do not copy code, comments, tests, schemas, migrations, assets, or prose from Openship or any other project. Behavior and design may be studied; expression must be original.
- **Public domain:** no `marsa.dev`, `marsa.io`, `marsa.app`, or invented public URL. Use `urn:marsa:*` identifiers and relative documentation links until the owner secures a domain.
- **One service per deployment; one Linux host; PostgreSQL is the only required stateful dependency.** Compose import, multi-service projects, multi-host, and a desktop app are out of scope for 0.1.
- **Docker socket access is root-equivalent.** Never expose it to workloads, never add privileged mode, host networking, host PID/IPC, or host path mounts.
- **Never auto-rollback.** A failed release leaves the previous release serving and requires an explicit rollback.
- **Never migrate automatically at web startup.** Migrations ship in an explicit bundle and use expand/contract.
- **Do not invent a decision silently.** If the docs conflict, stop, write down the conflict, and choose the smallest option consistent with the PRD. Record it as **PROPOSED** in `docs/07-risks-and-open-questions.md`.
- **Do not add comments that restate code.** Use XML docs on public contracts and comments only for a non-obvious "why".
- **Arabic is first-class.** New user-visible strings need English and Arabic, correct RTL, and LTR code/log blocks.

## 4. Canonical names

| Use | Value |
|---|---|
| Product | Marsa / مرسى |
| Brand | Ofuq |
| GitHub handle | `ofuqq` |
| Repository | `ofuqq/marsa` |
| CLI | `marsa` |
| Config | `marsa.json` |
| Environment prefix | `MARSA_` |
| Docker labels | `io.marsa.*` |
| Token prefix | `marsa_pat_` |
| .NET namespaces | `Marsa.*` |
| NuGet | `ofuqq.Marsa.*` |
| npm scope | `@ofuqq/*` |
| URN | `urn:marsa` |

Never use `ofuq/marsa`, `Ofuq.Marsa.*`, or `@marsa/*`. Use `ofuqq` only in URLs, remotes, CODEOWNERS, badges, and registry identifiers; prose uses Ofuq.

## 5. Architecture in brief

- Modular monolith with Domain, Contracts, Application, Infrastructure, Server, CLI, Testing, and test projects.
- `Marsa.Server` is the only deployable server: API, Razor Components, SignalR, and hosted worker.
- PostgreSQL stores all durable state: projects, deployments, steps, logs, leases, outbox, audit, idempotency.
- Docker builds and runs workloads through a narrow adapter. Caddy is the only public edge and is controlled over a Unix socket.
- Deployment states: `queued` → `preparing` → `building` → `deploying` → `health_checking` → `routing` → terminal.
- Terminal states: `succeeded`, `succeeded_with_warnings`, `action_required`, `failed`, `cancelled`.
- The deployment snapshot is immutable. One active deployment per environment is a database invariant.
- Secrets use AES-256-GCM envelope encryption with a master key outside the database and image.
- The API is versioned at `/api/v1`, generated from code, with ProblemDetails errors and idempotency keys.

Full details: [`docs/03-architecture.md`](docs/03-architecture.md).

## 6. Repository map

```text
AGENTS.md                  this contract
opencode.json              agent configuration
docs/00-*                  identity and vision
docs/01-*                  requirements
docs/02-*                  differentiation
docs/03-12*                architecture, data, API, security, testing, ops
docs/adr/                  architecture decisions
docs/backlog/              issue drafts, coverage, milestones
docs/ai/                   agent guides, pitfalls, completion gate
.github/                   issue forms, PR template, CI
scripts/                   docs, labels, and issue automation
deploy/                    future install and container assets
src/, tests/               future product code
.local/                    private owner workspace; untracked, never commit
```

## 7. Workflow for an issue

1. Read the issue and every `depends_on` issue. Do not start a blocked issue.
2. Read the requirements and ADRs named in the issue. Confirm there is no conflict.
3. Write a short plan: files, tests, risks, and what is out of scope.
4. Implement the smallest vertical slice that satisfies all acceptance criteria.
5. Add tests that fail without the change. Include the failure path, not only the happy path.
6. Run the relevant suites plus the docs/backlog checks.
7. Update the issue's docs, ADR, decision log, and coverage in the same change.
8. Write the beginner Arabic explanation in `.local/learn/NNN-<issue-or-topic>.ar.md`; never commit or link it.
9. Report evidence: commands, results, explanation file, and any remaining gap. Do not claim a test passed unless it ran.

Branch names: `feat/<issue-slug>`, `fix/<issue-slug>`, `docs/<topic>`. Commits use `type(scope): summary` and reference requirement IDs in the body when useful.

## 8. Commands

Documentation and backlog checks:

```bash
python3 scripts/check-docs.py
python3 scripts/validate-backlog.py
./scripts/sync-labels.sh --dry-run
./scripts/create-issues.sh --dry-run
```

Future .NET commands, once code exists:

```bash
dotnet restore --locked-mode
dotnet build Marsa.sln -warnaserror
dotnet test Marsa.sln
./eng/verify.sh
```

Do not run `--apply` scripts or any `gh` mutation unless the user explicitly asks.

### Before any push

1. Run `git status --short` and `git diff --cached --name-only`.
2. List any file that looks personal: progress, Arabic learning, handoff, notes, prompts, costs, secrets, `.env`, private URLs, or customer data.
3. If the list is not empty, stop. Do not push. Do not touch GitHub.
4. Confirm `.local/` is ignored with `git check-ignore -v .local/progress.md`.
5. Only then ask the owner for explicit push approval.

## 9. Security rules

- Treat every repository, Dockerfile, image, webhook, and hostname as hostile input.
- Validate URL schemes, redirects, DNS targets, hostnames, paths, env keys, and image references against explicit rules.
- Never log request bodies, cookies, Authorization headers, env maps, or secret values.
- Builds and workloads never receive the Docker socket.
- Deny privileged containers, host mounts, host networking, and host PID/IPC.
- Use constant-time comparison for HMACs and hashes.
- Keep the master key outside PostgreSQL and the image; a missing key fails closed.
- Audit sensitive actions with actor, source, action, resource, and result, but no secret values.

## 10. Definition of done

The full gate is [`docs/ai/definition-of-done.md`](docs/ai/definition-of-done.md). At minimum:

- Acceptance criteria pass.
- Tests cover the failure paths that matter.
- No secret canary appears in logs, events, audit, API, or telemetry.
- Roles and tenant boundaries are tested.
- Docs, ADRs, decision log, and indexes are current.
- The change preserves the one-host, one-service, PostgreSQL, Caddy, and Docker invariants.
- No new dependency has an unapproved license or an unnecessary native requirement.
- **Every code change has a beginner Arabic explanation** in `.local/learn/NNN-<issue-or-topic>.ar.md`, written before the task is called done. It explains what changed and why, each new concept with an analogy, every changed file, the exact run and test commands, failure modes, three quiz questions with answers, and what to read next. It is local only: never commit it, push it, link it from public docs, or include it in a release.
- The private handoff in `.local/handoff/claude-handoff.md` is updated at the end of every phase and every merged issue. It stays under 300 lines and is never committed.

## 11. Decisions to challenge, not assume

These are **PROPOSED** and may change before 1.0:

- Apache-2.0 for code and docs.
- Caddy over another edge proxy.
- Docker socket access for 0.1 instead of a host agent.
- No auto-rollback.
- One hostname per service.
- Local images without registry push.
- UUIDv7 and PostgreSQL-only state.
- 39 grouped backlog issues and the MVP cut line.

Use [`docs/07-risks-and-open-questions.md`](docs/07-risks-and-open-questions.md) to record a challenge. Do not silently rewrite an approved requirement.
