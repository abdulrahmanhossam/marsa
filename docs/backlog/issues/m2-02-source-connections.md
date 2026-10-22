---
title: "M2: Connect GitHub, GitLab, and generic HTTPS sources safely"
labels: [type/feature, area/source, area/secrets, priority/p0, status/ready, size/l]
milestone: "M2"
epic: "E2"
size: "l"
depends_on: [m2-01-project-crud]
requirements: [FR-SRC-02, FR-SRC-03, FR-SRC-04, FR-SRC-05, FR-SRC-09, FR-SRC-10, NFR-SEC-06]
stories: [E2.2, E2.3, E2.4, E2.8, E2.9]
---

## Context

Source connections are both a credential store and an outbound HTTP client, so they need encryption, strict URL validation, SSRF defenses, and a test operation that proves the credential without persisting partial state.

## Scope

- Support public GitHub, GitHub PAT, GitLab PAT, and generic HTTPS repositories.
- Reject SSH, `file://`, local paths, non-HTTPS URLs, embedded credentials, and unsafe redirects before any request.
- Resolve DNS and block private, loopback, link-local, metadata, and non-public targets; re-check after redirects.
- Encrypt credentials with the master-key secret protector and return metadata only.
- Test the source and list the default branch plus up to 100 branches.
- Store credential metadata without a plaintext copy; failure must not persist a partial credential.

## Acceptance criteria

- [ ] A public repository tests successfully without a credential.
- [ ] A private repository works with a valid PAT and returns `source.auth_failed` for an invalid one.
- [ ] SSH, local paths, `file://`, non-HTTPS, private targets, and unsafe redirects are rejected before outbound I/O.
- [ ] API projections expose credential metadata only; database rows are ciphertext.
- [ ] Source test returns the default branch and at most 100 branches.
- [ ] A failed test leaves no credential or partial connection behind.

## Likely files

- `src/Marsa.Application/Sources/`
- `src/Marsa.Infrastructure/Sources/GitSourceProvider.cs`
- `src/Marsa.Infrastructure/Sources/SafeHttpHandler.cs`
- `src/Marsa.Server/Endpoints/SourcesEndpoints.cs`

## Test notes

- URL validator table tests including IPv6, decimal IPs, redirects, and embedded credentials.
- SSRF test server that proves blocked targets receive no request.
- Credential redaction and encryption-at-rest tests.

## Requirement coverage

- `FR-SRC-02`
- `FR-SRC-03`
- `FR-SRC-04`
- `FR-SRC-05`
- `FR-SRC-09`
- `FR-SRC-10`
- `NFR-SEC-06`

## Roadmap stories

- `E2.2`
- `E2.3`
- `E2.4`
- `E2.8`
- `E2.9`

## Dependencies

<!-- dependency-links -->
- Depends on `m2-01-project-crud`.

## Out of scope

- SSH keys, GitHub App installation tokens, OAuth device flow, and self-hosted certificate pinning.
