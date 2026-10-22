---
title: "M2: Build the project/source screens and destructive-action confirmations"
labels: [type/feature, area/ui, area/projects, priority/p1, status/ready, size/m]
milestone: "M2"
epic: "E9"
size: "m"
depends_on: [m2-01-project-crud, m2-04-detection-engine]
requirements: [FR-UI-09]
stories: [E9.13]
---

## Context

The browser is the primary interface for creating a project and connecting a repository. It also needs a consistent confirmation pattern before archive, delete, cancel, rollback, and secret operations exist.

## Scope

- Add project list, create, detail, archive, and restore screens.
- Add the source connection form and show the detection plan with evidence and confidence.
- Add a reusable confirmation dialog that states what changes and what is retained.
- Show safe errors with the next action and link to the relevant field.
- Keep the UI server-rendered and free of direct database access.

## Acceptance criteria

- [ ] A user can create a project and connect a source from the browser.
- [ ] Detection evidence and confidence are visible before the first deploy.
- [ ] Archive, restore, and delete-like actions require a confirmation that explains impact.
- [ ] The UI calls application services/API equivalents and never a DbContext.
- [ ] Errors are readable in both English and Arabic layouts and do not leak secrets.

## Likely files

- `src/Marsa.Server/Components/Pages/Projects/`
- `src/Marsa.Server/Components/Shared/ConfirmDialog.razor`
- `src/Marsa.Server/Components/Pages/Sources/`
- `tests/Marsa.Server.Tests/Ui/`

## Test notes

- Razor component tests for validation and confirmation state.
- End-to-end create-project and connect-source smoke test.
- Locale and RTL snapshot checks for the new screens.

## Requirement coverage

- `FR-UI-09`

## Roadmap stories

- `E9.13`

## Dependencies

<!-- dependency-links -->
- Depends on `m2-01-project-crud`.
- Depends on `m2-04-detection-engine`.

## Out of scope

- Deploy controls and live logs; M3-07 and M5-03 add those.
