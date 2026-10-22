---
title: "M1: Add host preflight and explicit public URL/trusted-proxy configuration"
labels: [type/feature, area/ops, area/platform, priority/p1, status/ready, size/m]
milestone: "M1"
epic: "E1"
size: "m"
depends_on: [m0-03-local-stack-images-ci]
requirements: [FR-SETUP-04, FR-SETUP-07]
stories: [E1.7]
---

## Context

Setup must diagnose an unsupported host before the operator creates an account. Absolute links, cookies, and redirects also depend on an explicit public URL and trusted-proxy policy rather than request headers.

## Scope

- Check Docker, BuildKit, PostgreSQL, Caddy, disk space, architecture, and ports 80/443.
- Return pass/fail per check with a safe fix hint and no secret values.
- Validate `MARSA_PUBLIC_BASE_URL` and trusted proxy settings at startup and in the setup UI.
- Use the configured URL for cookies, redirects, and absolute links; reject invalid or ambiguous values.
- Expose the preflight result to setup and the diagnostics page.

## Acceptance criteria

- [ ] Each preflight check has pass/fail and a fix hint; unsupported architecture and occupied ports are detected.
- [ ] Preflight never blocks `/health/live` and does not crash when Docker or Caddy is absent.
- [ ] Cookies, redirects, and absolute links use the configured public URL, not the Host header.
- [ ] An invalid URL fails validation with a safe message.
- [ ] Trusted proxy behavior is covered by a spoofed `X-Forwarded-*` test.

## Likely files

- `src/Marsa.Application/Preflight/`
- `src/Marsa.Infrastructure/Preflight/`
- `src/Marsa.Server/Endpoints/PreflightEndpoints.cs`
- `src/Marsa.Server/Configuration/PublicUrlOptions.cs`

## Test notes

- Unit tests for every preflight result using fake probes.
- Integration test with a missing Caddy socket and an occupied port.
- Host-header spoofing and public-URL redirect tests.

## Requirement coverage

- `FR-SETUP-04`
- `FR-SETUP-07`

## Roadmap stories

- `E1.7`

## Dependencies

<!-- dependency-links -->
- Depends on `m0-03-local-stack-images-ci`.

## Out of scope

- Continuous host monitoring, auto-remediation, and a public status page.
