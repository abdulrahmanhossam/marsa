---
title: "M1: Implement first-run setup, local login, sessions, and the auth shell"
labels: [type/feature, area/auth, area/ui, area/api, priority/p0, status/ready, size/xl]
milestone: "M1"
epic: "E1"
size: "xl"
depends_on: [m0-03-local-stack-images-ci]
requirements: [FR-SETUP-01, FR-SETUP-02, FR-SETUP-05, FR-SETUP-06, FR-AUTH-01, FR-AUTH-02, FR-AUTH-05, FR-AUTH-06, FR-UI-01, FR-UI-05, FR-API-06, NFR-SEC-01, NFR-SEC-08]
stories: [E1.1, E1.2, E1.5, E1.8, E9.5, E9.8]
---

## Context

The first-run path is the product's trust anchor. It must create exactly one organization and owner with a one-time token, then support cookie sessions for the dashboard and bearer-ready authentication for future clients, without default credentials or a client-only business layer.

## Scope

- Generate a one-time setup token at install time; show it only on the host console or a root-readable file.
- Create the organization and first owner atomically; reject replay with `setup.already_complete`.
- Use ASP.NET Core Identity with a modern password hasher and no default users.
- Issue `HttpOnly`, `Secure` in production, `SameSite=Lax` cookies; invalidate server-side on logout.
- Add antiforgery for cookie mutations and exempt bearer requests; set CSP, HSTS, frame, content-type, and referrer headers.
- Build the server-rendered setup, login, logout, and current-user pages without a Node build.
- Rate-limit setup and login, and audit success and failure without secrets.

## Acceptance criteria

- [ ] A request without the setup token is rejected; a token works once and cannot be replayed.
- [ ] Refreshing or repeating setup cannot create a second organization or owner.
- [ ] Valid credentials create a session; invalid credentials return a safe error; passwords never appear in logs.
- [ ] A logged-out cookie cannot access a protected page or API.
- [ ] Cookie mutations without an antiforgery token fail; bearer requests do not need one.
- [ ] Security headers pass integration tests and the dashboard works under the CSP.
- [ ] The setup and login pages are keyboard-usable and use the shared server-side layout.

## Likely files

- `src/Marsa.Application/Setup/`
- `src/Marsa.Application/Identity/`
- `src/Marsa.Infrastructure/Identity/`
- `src/Marsa.Server/Endpoints/SetupEndpoints.cs`
- `src/Marsa.Server/Endpoints/AuthEndpoints.cs`
- `src/Marsa.Server/Components/Pages/Setup.razor`
- `src/Marsa.Server/Components/Pages/Login.razor`

## Test notes

- Integration tests for setup token replay and second-owner prevention.
- Auth matrix for cookie, bearer, anonymous, and logged-out access.
- Cookie flag, CSRF, security-header, and rate-limit tests.

## Requirement coverage

- `FR-SETUP-01`
- `FR-SETUP-02`
- `FR-SETUP-05`
- `FR-SETUP-06`
- `FR-AUTH-01`
- `FR-AUTH-02`
- `FR-AUTH-05`
- `FR-AUTH-06`
- `FR-UI-01`
- `FR-UI-05`
- `FR-API-06`
- `NFR-SEC-01`
- `NFR-SEC-08`

## Roadmap stories

- `E1.1`
- `E1.2`
- `E1.5`
- `E1.8`
- `E9.5`
- `E9.8`

## Dependencies

<!-- dependency-links -->
- Depends on `m0-03-local-stack-images-ci`.

## Out of scope

- Roles beyond owner, PATs, OIDC, password reset by email, and branding; roles and PATs are M1-02, OIDC is out of scope.
