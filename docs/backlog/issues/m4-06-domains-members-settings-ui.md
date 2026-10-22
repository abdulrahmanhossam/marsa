---
title: "M4: Build domain verification, member/token, secret metadata, and audit screens"
labels: [type/feature, area/ui, area/edge, area/audit, priority/p1, status/ready, size/l]
milestone: "M4"
epic: "E9"
size: "l"
depends_on: [m4-02-domains-and-tls, m4-04-secrets-envelope, m4-05-audit-trail]
requirements: [FR-UI-03, FR-UI-04]
stories: [E9.7]
---

## Context

Operators should complete domain, membership, token, secret metadata, and audit work without the CLI. Every screen must respect role limits and never render a secret value.

## Scope

- Add domain add, DNS instruction copy, verify, and certificate status screens.
- Add member role management, PAT management, and secret metadata/version screens.
- Add an audit list with filters allowed by the viewer's role.
- Render no plaintext secret; reveal is an explicit audited admin action when enabled.
- Explain the next step for pending and failed DNS/certificate states.
- Keep all actions server-rendered and server-authorized.

## Acceptance criteria

- [ ] A user can add, verify, and inspect a domain from the browser.
- [ ] DNS values are copyable and pending/failed states explain the next action.
- [ ] Members and tokens respect the role matrix; the last owner cannot be removed.
- [ ] Secret metadata is visible but no plaintext is rendered.
- [ ] Audit visibility matches the role and contains no secret values.
- [ ] All screens are keyboard-usable and localized.

## Likely files

- `src/Marsa.Server/Components/Pages/Domains/`
- `src/Marsa.Server/Components/Pages/Settings/Members.razor`
- `src/Marsa.Server/Components/Pages/Settings/Tokens.razor`
- `src/Marsa.Server/Components/Pages/Settings/Secrets.razor`
- `src/Marsa.Server/Components/Pages/Audit/Index.razor`

## Test notes

- End-to-end domain verification UI test.
- Role-limit and last-owner UI tests.
- Secret plaintext absence and audit filter tests.

## Requirement coverage

- `FR-UI-03`
- `FR-UI-04`

## Roadmap stories

- `E9.7`

## Dependencies

<!-- dependency-links -->
- Depends on `m4-02-domains-and-tls`.
- Depends on `m4-04-secrets-envelope`.
- Depends on `m4-05-audit-trail`.

## Out of scope

- A marketing site, theme editor, and scheduled report emails.
