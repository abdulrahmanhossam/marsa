---
title: "M5: Complete the dashboard create-to-rollback workflow"
labels: [type/feature, area/ui, area/deploy, priority/p0, status/ready, size/xl]
milestone: "M5"
epic: "E9"
size: "xl"
depends_on: [m5-01-rollback-and-retention, m4-06-domains-members-settings-ui, m3-07-realtime-deploy-ui]
requirements: [FR-UI-02]
stories: [E9.14]
---

## Context

The dashboard must complete the same core journey as the CLI without dead ends: create a project, connect a source, review detection, deploy, watch phases and logs, diagnose a failure, and roll back.

## Scope

- Wire project creation, source connection, detection review, deploy, status, logs, and rollback.
- Enforce role limits and show a safe unavailable state for forbidden actions.
- Show the failing step, stable code, preserved resources, and next action.
- Keep destructive actions behind the shared confirmation dialog.
- Make every page reachable by keyboard and resilient to refresh/reconnect.
- Call application services/API equivalents, never a DbContext.

## Acceptance criteria

- [ ] A new user completes the primary flow without the CLI.
- [ ] A failed deploy shows the failing step and a concrete next action.
- [ ] Rollback is available from the failed deployment and shows its result.
- [ ] Forbidden actions are hidden or disabled with an honest explanation.
- [ ] Refresh and reconnect do not lose deployment state.
- [ ] The flow passes in English and Arabic layouts.

## Likely files

- `src/Marsa.Server/Components/Pages/Deployments/`
- `src/Marsa.Server/Components/Pages/Projects/Detail.razor`
- `src/Marsa.Server/Components/Shared/ErrorSummary.razor`

## Test notes

- End-to-end dashboard journey with a sample app.
- Failed-deploy and rollback UI tests.
- Refresh/reconnect and role-limit tests.

## Requirement coverage

- `FR-UI-02`

## Roadmap stories

- `E9.14`

## Dependencies

<!-- dependency-links -->
- Depends on `m5-01-rollback-and-retention`.
- Depends on `m4-06-domains-members-settings-ui`.
- Depends on `m3-07-realtime-deploy-ui`.

## Out of scope

- A visual page builder, custom dashboards, and a separate SPA.
