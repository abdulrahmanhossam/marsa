# Marsa

> **Where your code docks.** · **حيث ترسو تطبيقاتك**

Marsa is a proposed self-hosted deployment control plane for **one Linux Docker host**. It is designed to take a Git repository or OCI image, build an immutable release, route a hostname over HTTPS, show what happened, and roll back explicitly when a release is bad.

**Current state: documentation only.** The repository contains the product specification, architecture, security model, 20 ADRs, and a 39-issue backlog. Marsa 0.1 has **not been implemented or released**; there is no server image, CLI binary, or installer yet. The owner's Arabic learning notes and progress log are kept privately and are not part of this repository.

Marsa is an [Ofuq](https://github.com/ofuqq) project.

## The promise

> On one Linux host, I can install Marsa, connect a repository, deploy it behind HTTPS, see exactly what happened, and roll back to a known-good release — without SSH-ing into the box or hand-editing a reverse proxy.

The design is deliberately narrow:

- one Linux host, one Docker daemon, one organization per install;
- one service per deployment;
- Git sources and prebuilt OCI images;
- ASP.NET Core first, plus Node/Next.js, static sites, Dockerfile, and prebuilt images;
- PostgreSQL 17 as the only required stateful dependency;
- Caddy as the only public edge;
- server-rendered Razor dashboard, CLI, and `/api/v1`;
- Arabic and English as first-class interface languages;
- health-gated cutover, explicit rollback, no auto-rollback;
- no Kubernetes, Compose, multi-host, app catalog, or managed databases in 0.1.

See the full boundary in [the roadmap](docs/08-roadmap.md) and [requirements](docs/01-product-requirements.md).

## What is in this repository

| Path | Contents |
|---|---|
| [`docs/`](docs/README.md) | Index of every document |
| [`docs/00-vision.md`](docs/00-vision.md) | Why Marsa exists, users, principles, non-goals |
| [`docs/01-product-requirements.md`](docs/01-product-requirements.md) | 151 requirement IDs and acceptance criteria |
| [`docs/03-architecture.md`](docs/03-architecture.md) | Modular monolith, state machine, trust boundaries |
| [`docs/07-security.md`](docs/07-security.md) | Security model and Docker-socket risk |
| [`docs/08-roadmap.md`](docs/08-roadmap.md) | M0–M6 construction order and MVP cut line |
| [`docs/adr/`](docs/adr/README.md) | 20 architecture decision records |
| [`docs/backlog/`](docs/backlog/README.md) | 39 issue drafts, coverage, and dependency order |
| [`docs/ai/`](docs/ai/README.md) | Guidance for AI-assisted implementation |
| [`AGENTS.md`](AGENTS.md) | Repository-wide agent and contributor contract |

## Documentation checks

This repository is not a runnable product yet, so the current checks are documentation checks. Python 3 is required. No third-party Python packages are used.

```bash
python3 scripts/check-docs.py
python3 scripts/validate-backlog.py
./scripts/sync-labels.sh --dry-run
./scripts/create-issues.sh --dry-run
```

`sync-labels.sh` and `create-issues.sh` default to dry-run and require `--apply` to change GitHub. Do not run `--apply` unless you are the repository owner and intend to create labels or issues. See [CONTRIBUTING.md](CONTRIBUTING.md).

The future .NET development workflow is documented in [docs/10-dev-environment.md](docs/10-dev-environment.md). Once code exists, the expected commands will be:

```bash
dotnet restore --locked-mode
dotnet build Marsa.sln -c Release
dotnet test Marsa.sln -c Release
dotnet format --verify-no-changes
```

These commands do not work in the current documentation-only repository.

## Reading order

1. [Vision](docs/00-vision.md) — intent and non-goals.
2. [Identity](docs/00-identity.md) — canonical names, handles, and prefixes.
3. [Requirements](docs/01-product-requirements.md) — what 0.1 must do.
4. [Architecture](docs/03-architecture.md) — how the parts fit.
5. [Security](docs/07-security.md) — trust boundaries and residual risk.
6. [Roadmap](docs/08-roadmap.md) — construction order and MVP cut line.
7. [Backlog](docs/backlog/README.md) — issue format and dependency order.

For AI-assisted work, start with [AGENTS.md](AGENTS.md), then [docs/ai/README.md](docs/ai/README.md).

## Supported environment (planned for 0.1)

| Item | Target |
|---|---|
| Host OS | Linux x86_64 or arm64 |
| Container runtime | Docker Engine 27+ with BuildKit |
| Minimum host | 2 vCPU, 4 GB RAM, 20 GB free disk |
| Recommended host | 4 vCPU, 8 GB RAM |
| Database | PostgreSQL 17 (containerized or external) |
| Edge | Caddy 2.x managed over a Unix socket |
| Browsers | Current and previous major versions of Chrome, Firefox, Safari, Edge |
| Windows/macOS hosts | Not supported in 0.1 |

Nothing in this table is a promise that Marsa 0.1 is available today.

## Safety and security

Marsa is designed as a **privileged control plane**. The server needs access to the Docker API to build and run workloads, and that access is effectively root-equivalent on the host.

The design therefore:

- never gives the Docker socket to application containers or builds;
- rejects privileged containers, host networking, host PID/IPC, and host mounts;
- manages Caddy only through a permissioned Unix socket, never a public admin port;
- encrypts secrets at rest with envelope encryption and keeps the master key outside the database;
- gates routing on health checks and keeps the old release serving until cutover succeeds;
- documents residual risk instead of claiming absolute isolation.

No software release exists yet. If you are reviewing the design, read [docs/07-security.md](docs/07-security.md) first. Do not deploy the design documents as if they were a hardened product.

## Status and roadmap

| Milestone | Theme | State |
|---|---|---|
| M0 | Walking skeleton | Planned |
| M1 | Setup, identity, and projects | Planned |
| M2 | Detect and build | Planned |
| M3 | Deploy and observe | Planned |
| M4 | Route and secure | Planned |
| M5 | Operate and recover | Planned |
| M6 | Release candidate | Planned |

Milestones are vertical slices, not calendar promises. The project has no release date and no SLA. See [docs/08-roadmap.md](docs/08-roadmap.md) for exit criteria and the MVP cut line.

## Contributing

Contributions are welcome once the owner opens the repository for them. Read [CONTRIBUTING.md](CONTRIBUTING.md) and [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) first.

- Use DCO sign-off (`git commit -s`).
- Do not translate or copy code from another project.
- Keep the single-host, one-service, PostgreSQL-only boundaries unless an ADR changes them.
- Never commit secrets, tokens, private repository URLs, or production data.
- Never commit the owner's private progress, Arabic learning, handoff, prompt, or notes files. Public docs must not link to them.
- Every code change needs a beginner Arabic explanation before it is considered done; see [the Definition of Done](docs/ai/definition-of-done.md).
- Security reports follow [SECURITY.md](SECURITY.md).

## License

First-party code and documentation are intended to be licensed under the **Apache License 2.0**. The license is **PROPOSED** pending owner confirmation and legal review; see [docs/12-license-and-clean-room.md](docs/12-license-and-clean-room.md).

The name **Marsa** is not trademark-cleared. The obvious public domains (`marsa.dev`, `marsa.io`, `marsa.app`) are registered by others, and a prior container-deployment company used the name at `marsa.io`. A public domain and trademark clearance are release gates, not current assets. Do not present an invented public URL as official.

Copyright 2026 Ofuq. See [NOTICE](NOTICE) and [THIRD-PARTY-NOTICES.md](THIRD-PARTY-NOTICES.md).
