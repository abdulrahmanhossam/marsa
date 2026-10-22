---
title: "M3: Stream deployment events over SignalR and build the live deployment detail page"
labels: [type/feature, area/observability, area/ui, priority/p1, status/ready, size/m]
milestone: "M3"
epic: "E7"
size: "m"
depends_on: [m3-05-cancel-activate-reconcile, m3-06-logs, m2-08-project-source-ui]
requirements: [FR-OBS-03]
stories: [E7.3, E9.6]
---

## Context

A deployment page must be useful while work is happening and after a refresh. SignalR events are an optimization over durable state, not a second source of truth, so reconnect and replay must be explicit.

## Scope

- Add project/deployment groups and ordered deployment events with sequence numbers.
- Replay missed events after reconnect from the last sequence.
- Render phases, step timeline, logs, and failure evidence from durable state.
- Show the failing step, stable code, and next action.
- Ensure a slow client cannot block the worker or drop persisted logs.

## Acceptance criteria

- [ ] A live deployment updates phases and logs without polling.
- [ ] A refresh reconstructs the same timeline from the database.
- [ ] A reconnect after the last sequence receives missed events without duplicates.
- [ ] A slow client does not block the worker.
- [ ] A failure shows the failing step and an actionable next step.

## Likely files

- `src/Marsa.Server/Hubs/DeploymentsHub.cs`
- `src/Marsa.Application/Deployments/DeploymentEvents.cs`
- `src/Marsa.Server/Components/Pages/Deployments/Detail.razor`

## Test notes

- SignalR reconnect/replay integration test.
- Slow-client and ordering tests.
- Rendered timeline and failure-evidence tests.

## Requirement coverage

- `FR-OBS-03`

## Roadmap stories

- `E7.3`
- `E9.6`

## Dependencies

<!-- dependency-links -->
- Depends on `m3-05-cancel-activate-reconcile`.
- Depends on `m3-06-logs`.
- Depends on `m2-08-project-source-ui`.

## Out of scope

- A general event bus, webhooks for deployment events, and collaborative presence.
