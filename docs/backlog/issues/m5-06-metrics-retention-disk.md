---
title: "M5: Add opt-in metrics/tracing, retention controls, and disk-pressure behavior"
labels: [type/feature, area/observability, area/ops, priority/p1, status/ready, size/m]
milestone: "M5"
epic: "E7"
size: "m"
depends_on: [m3-06-logs]
requirements: [FR-OBS-06, FR-OBS-07, FR-OBS-08, FR-OPS-06]
stories: [E7.5, E7.6, E7.8, E7.7]
---

## Context

Observability beyond logs must remain optional. A healthy install cannot require an OpenTelemetry collector, and disk pressure must warn before a build fails and clean only managed artifacts.

## Scope

- Expose deployment metrics for phase duration, queue age, success/failure, lease expiry, and route failure.
- Make OpenTelemetry export opt-in and verify an install without a collector remains healthy.
- Make deployment/app/audit retention configurable with the documented defaults.
- Add disk warning, degraded state, and safe cleanup of workspaces and unreferenced images.
- Never remove active or last-known-good artifacts under pressure.

## Acceptance criteria

- [ ] Metrics are available in a documented format.
- [ ] An install with no collector passes health and deployments.
- [ ] Enabling export requires explicit configuration and does not break startup when unavailable.
- [ ] Retention changes take effect without deleting protected evidence.
- [ ] A nearly full disk warns before builds fail; cleanup touches only managed artifacts.
- [ ] No secret appears in metrics or traces.

## Likely files

- `src/Marsa.Server/Telemetry/`
- `src/Marsa.Application/Maintenance/RetentionService.cs`
- `src/Marsa.Infrastructure/Maintenance/DiskPressureMonitor.cs`

## Test notes

- Metrics contract and redaction tests.
- No-collector health test.
- Disk-pressure and retention protection tests.

## Requirement coverage

- `FR-OBS-06`
- `FR-OBS-07`
- `FR-OBS-08`
- `FR-OPS-06`

## Roadmap stories

- `E7.5`
- `E7.6`
- `E7.8`
- `E7.7`

## Dependencies

<!-- dependency-links -->
- Depends on `m3-06-logs`.

## Out of scope

- A hosted observability service, alert routing, and automatic disk expansion.
