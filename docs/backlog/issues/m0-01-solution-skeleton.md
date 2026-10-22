---
title: "M0: Create the solution skeleton and validated configuration"
labels: [type/feature, area/platform, area/api, priority/p0, status/ready, size/l]
milestone: "M0"
epic: "E0"
size: "l"
depends_on: []
requirements: [FR-SETUP-03, NFR-COMP-03, NFR-COMP-04]
stories: [E0.1, E0.2, E0.5]
---

## Context

Everything in M0 starts from a repository that builds reproducibly with the project boundaries in `docs/04-dotnet-solution-structure.md`. Startup must reject incomplete configuration before serving traffic, and the warning-free, locked build is the base for every later issue.

## Scope

- Create `Marsa.sln` and the Domain, Contracts, Application, Infrastructure, Server, CLI, Testing, and test projects.
- Add central package management, `global.json`, analyzers, nullable and warnings-as-errors settings.
- Implement typed options for database, master key, Caddy socket, public base URL, and trusted proxies.
- Validate options at startup and print actionable messages without values or secrets.
- Add architecture tests that reject forbidden project references.

## Acceptance criteria

- [ ] `dotnet build Marsa.sln -warnaserror` succeeds from a clean checkout.
- [ ] Central package versions and lock files make restore reproducible.
- [ ] Startup fails fast when the database, master key, Caddy socket, or base URL is missing or invalid.
- [ ] Failure messages name the setting and the fix, and never print the value.
- [ ] Domain, Contracts, Application, and Infrastructure reference only the projects allowed by the architecture document.
- [ ] `dotnet test` runs the architecture and options tests in CI.

## Likely files

- `Marsa.sln`
- `Directory.Build.props`
- `Directory.Packages.props`
- `global.json`
- `NuGet.config`
- `src/Marsa.Domain/`
- `src/Marsa.Contracts/`
- `src/Marsa.Application/`
- `src/Marsa.Infrastructure/`
- `src/Marsa.Server/Program.cs`
- `src/Marsa.Server/Configuration/`
- `tests/Marsa.Domain.Tests/`

## Test notes

- Options validation unit tests for each missing and malformed value.
- Architecture tests using NetArchTest or an equivalent dependency scan.
- A smoke start against a valid local configuration.

## Requirement coverage

- `FR-SETUP-03`
- `NFR-COMP-03`
- `NFR-COMP-04`

## Roadmap stories

- `E0.1`
- `E0.2`
- `E0.5`

## Dependencies

<!-- dependency-links -->
- None; this is the first issue in its dependency path.

## Out of scope

- Product endpoints, UI, Docker integration, and database migrations; those follow in M0-02 and M0-03.
