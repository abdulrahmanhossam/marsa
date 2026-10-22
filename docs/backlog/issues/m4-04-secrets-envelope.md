---
title: "M4: Add envelope-encrypted secret versions and deployment-time injection"
labels: [type/security, area/secrets, priority/p0, status/ready, size/xl]
milestone: "M4"
epic: "E8"
size: "xl"
depends_on: [m3-03-deployment-admission]
requirements: [FR-SEC-01, FR-SEC-02, FR-SEC-03, FR-SEC-04, FR-SEC-05, FR-SEC-06, NFR-SEC-04]
stories: [E8.1, E8.2, E8.3, E8.4]
---

## Context

Environment values and credentials need encryption at rest without a cloud KMS. The product also needs immutable versions, deployment snapshots that carry references, and a missing-key failure that cannot silently fall back to plaintext.

## Scope

- Implement AES-256-GCM envelope encryption with key version, nonce, ciphertext, and tag.
- Load the master key from a root-owned file or environment; fail closed when missing.
- Store immutable secret versions and return metadata only from list APIs.
- Carry encrypted references and key versions in the deployment snapshot; decrypt only at container creation.
- Validate environment keys and fail missing references at prepare with a stable code.
- Rotate by adding a version for the next deployment without changing active releases.
- Implement admin-only reveal behind a default-off feature flag with audit.

## Acceptance criteria

- [ ] Database inspection shows ciphertext and metadata, never plaintext.
- [ ] A missing master key fails secret-dependent operations closed.
- [ ] A new secret version does not mutate prior deployments or snapshots.
- [ ] Logs, events, audit, telemetry, and API projections never contain plaintext.
- [ ] A missing secret reference fails at prepare before a container starts.
- [ ] Rotation affects only the next deployment and writes a redacted audit event.
- [ ] Reveal is admin-only, default off, and audited when enabled.

## Likely files

- `src/Marsa.Infrastructure/Security/SecretProtector.cs`
- `src/Marsa.Application/Secrets/`
- `src/Marsa.Domain/Secrets/SecretVersion.cs`
- `src/Marsa.Server/Endpoints/SecretsEndpoints.cs`

## Test notes

- Encryption round-trip, tamper detection, and key-version tests.
- Secret canary suite across logs, audit, events, and API.
- Missing-key fail-closed and rotation snapshot tests.

## Requirement coverage

- `FR-SEC-01`
- `FR-SEC-02`
- `FR-SEC-03`
- `FR-SEC-04`
- `FR-SEC-05`
- `FR-SEC-06`
- `NFR-SEC-04`

## Roadmap stories

- `E8.1`
- `E8.2`
- `E8.3`
- `E8.4`

## Dependencies

<!-- dependency-links -->
- Depends on `m3-03-deployment-admission`.

## Out of scope

- A general-purpose secret manager, secret export, KMS/HSM, and per-secret keys.
