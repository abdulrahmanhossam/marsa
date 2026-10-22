---
title: "M5: Ship the Marsa CLI for authentication, deploy, status, logs, env, domains, and secrets"
labels: [type/feature, area/cli, area/api, priority/p0, status/ready, size/xl]
milestone: "M5"
epic: "E9"
size: "xl"
depends_on: [m5-01-rollback-and-retention, m4-06-domains-members-settings-ui, m4-01-caddy-route-adapter]
requirements: [FR-CLI-01, FR-CLI-02, FR-CLI-03, FR-CLI-04, FR-CLI-05]
stories: [E9.1, E9.2, E9.3, E9.4]
---

## Context

The CLI is a first-class operator interface, not a thin wrapper around internal endpoints. It must use the generated contract, store tokens safely, support machine-readable output and stable exit codes, and never accept a token in argv.

## Scope

- Implement `marsa login`, `logout`, `whoami`, `projects list`, `deploy`, `status`, `logs --follow`, `env`, `domains`, and `secrets`.
- Store tokens with `0600` permissions and support environment/config input.
- Add `--json` to read commands and documented exit codes for auth, validation, and deployment failure.
- Use a client generated from `docs/api/openapi.v1.json`; no hand-written wire models.
- Reject token values in positional arguments and redact them from errors.
- Require `--yes` for destructive actions in non-interactive mode.
- Resume `logs --follow` after reconnect.

## Acceptance criteria

- [ ] Login, logout, and whoami work against the API with `0600` token storage.
- [ ] Deploy returns non-zero on failure and status is machine-readable with `--json`.
- [ ] Logs follow and resume after reconnect.
- [ ] Env, domains, and secrets respect role limits and never print values except an explicit write confirmation.
- [ ] A token passed in argv is rejected before any request.
- [ ] The client is generated from OpenAPI and a contract change fails generation.

## Likely files

- `src/Marsa.Cli/Program.cs`
- `src/Marsa.Cli/Commands/`
- `src/Marsa.Cli/Generated/`
- `tests/Marsa.Cli.Tests/`

## Test notes

- Command parsing, exit-code, and token-redaction tests.
- Generated-client compile and contract drift test.
- End-to-end deploy/status/logs test against a disposable server.

## Requirement coverage

- `FR-CLI-01`
- `FR-CLI-02`
- `FR-CLI-03`
- `FR-CLI-04`
- `FR-CLI-05`

## Roadmap stories

- `E9.1`
- `E9.2`
- `E9.3`
- `E9.4`

## Dependencies

<!-- dependency-links -->
- Depends on `m5-01-rollback-and-retention`.
- Depends on `m4-06-domains-members-settings-ui`.
- Depends on `m4-01-caddy-route-adapter`.

## Out of scope

- Shell completion, a TUI, plugin commands, and binary auto-update.
