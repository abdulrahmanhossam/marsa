---
title: "M2: Enforce repository limits and add signed, deduplicated push webhooks"
labels: [type/feature, area/source, area/security, priority/p0, status/ready, size/l]
milestone: "M2"
epic: "E2"
size: "l"
depends_on: [m2-02-source-connections]
requirements: [FR-SRC-06, FR-SRC-07, FR-SRC-08, NFR-SEC-05]
stories: [E2.5, E2.6, E2.7]
---

## Context

A push webhook can start a build on every delivery. It must verify authenticity, tolerate delivery retries, ignore unwatched branches, and never allow one delivery to create two deployments. Repository size and submodule checks happen before fetching a full tree.

## Scope

- Enforce configurable repository size, file count, and submodule limits before build admission.
- Implement GitHub, GitLab, and generic HMAC verification with constant-time comparison and timestamp tolerance.
- Deduplicate deliveries by provider delivery ID with a durable record.
- Filter branches against the project's watched branch and enqueue at most one deployment.
- Allow webhook secret rotation: show the new secret once, invalidate the old immediately, and audit it.
- Use stable errors: `source.repo_too_large`, `source.submodule_unsupported`, `webhook.invalid_signature`, `webhook.replayed`.

## Acceptance criteria

- [ ] Oversized repositories fail before a full checkout with `source.repo_too_large`.
- [ ] Submodules fail with a clear unsupported message unless the limits explicitly allow them.
- [ ] A forged or stale signature is rejected; a duplicate delivery ID is ignored.
- [ ] A push to an unwatched branch performs no work.
- [ ] At most one deployment is enqueued for one delivery, even under concurrent retries.
- [ ] Rotating the secret immediately invalidates the old one and writes a redacted audit event.

## Likely files

- `src/Marsa.Application/Webhooks/`
- `src/Marsa.Infrastructure/Sources/WebhookVerifier.cs`
- `src/Marsa.Server/Endpoints/WebhooksEndpoints.cs`
- `src/Marsa.Domain/Sources/WebhookDelivery.cs`

## Test notes

- Provider signature fixtures for valid, invalid, stale, and replayed deliveries.
- Concurrency test for duplicate delivery IDs.
- Repository limit and submodule guard tests.

## Requirement coverage

- `FR-SRC-06`
- `FR-SRC-07`
- `FR-SRC-08`
- `NFR-SEC-05`

## Roadmap stories

- `E2.5`
- `E2.6`
- `E2.7`

## Dependencies

<!-- dependency-links -->
- Depends on `m2-02-source-connections`.

## Out of scope

- Pull-request previews, manual approval gates, and webhook fan-out to third parties.
