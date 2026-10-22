---
title: "M3: Capture, redact, persist, filter, and page deployment and runtime logs"
labels: [type/feature, area/observability, area/secrets, priority/p0, status/ready, size/l]
milestone: "M3"
epic: "E7"
size: "l"
depends_on: [m3-01-runtime-container]
requirements: [FR-OBS-01, FR-OBS-02, FR-RUN-07, NFR-SEC-04]
stories: [E7.1, E7.2, E7.7]
---

## Context

Logs are the main diagnostic surface for a failed deployment. They must be chunked and sequenced for reliable replay, bounded so a noisy container cannot exhaust memory, and redacted before persistence.

## Scope

- Capture build logs and runtime `stdout`/`stderr` with stream identity and sequence numbers.
- Redact secrets, tokens, credentials, full env maps, and configured canaries before persistence.
- Chunk and bound the in-memory buffer; apply backpressure without dropping the final failure evidence.
- Persist logs so they survive refresh, restart, and worker failover.
- Provide read-after-sequence, stream filters, and a redacted text download.
- Enforce the 30-day deployment and 14-day application defaults.

## Acceptance criteria

- [ ] A log can be read after a sequence number and survives a restart.
- [ ] `stdout` and `stderr` are distinguishable.
- [ ] A noisy container cannot exhaust server memory.
- [ ] Secret canaries never appear in API, download, logs, or errors.
- [ ] Filters are stable in the API and the download is plain redacted text.
- [ ] Retention removes expired chunks without deleting the active deployment's evidence.

## Likely files

- `src/Marsa.Application/Logs/`
- `src/Marsa.Infrastructure/Logs/LogChunkStore.cs`
- `src/Marsa.Infrastructure/Logs/LogRedactor.cs`
- `src/Marsa.Server/Endpoints/LogsEndpoints.cs`

## Test notes

- Redaction canary suite across build and runtime paths.
- Sequence, refresh, restart, and retention tests.
- Bounded-buffer and slow-consumer tests.

## Requirement coverage

- `FR-OBS-01`
- `FR-OBS-02`
- `FR-RUN-07`
- `NFR-SEC-04`

## Roadmap stories

- `E7.1`
- `E7.2`
- `E7.7`

## Dependencies

<!-- dependency-links -->
- Depends on `m3-01-runtime-container`.

## Out of scope

- Full-text search, log export to third parties, and shell access to containers.
