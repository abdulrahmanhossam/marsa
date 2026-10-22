---
title: "M5: Complete Arabic/English localization, RTL, and accessibility"
labels: [type/feature, area/ui, area/docs, priority/p0, status/ready, size/xl]
milestone: "M5"
epic: "E9"
size: "xl"
depends_on: [m5-03-dashboard-primary-flow]
requirements: [FR-UI-06, FR-UI-07, FR-UI-08, NFR-UX-01, NFR-UX-02, NFR-UX-03, NFR-UX-04, NFR-UX-05]
stories: [E9.9, E9.10, E9.11, E9.12]
---

## Context

Arabic is a first-class product language, not a translated shell. The layout must flip, code and logs must stay LTR, errors must explain what was preserved, and primary flows must work with a keyboard at 360 px and 1280 px.

## Scope

- Add a per-user English/Arabic preference with browser-default and explicit override.
- Localize navigation, setup, login, projects, deployments, domains, secrets, audit, and errors.
- Flip layout direction, align forms and tables, and keep code/log blocks LTR.
- Add visible focus, labels, keyboard operation, and an error summary.
- Ensure state is not communicated by color alone.
- Localize dates, numbers, and durations without changing API values.

## Acceptance criteria

- [ ] Language choice persists across sessions and does not lose form state.
- [ ] Arabic pages use correct RTL at 360 px and 1280 px with no clipped controls.
- [ ] Code and log blocks remain LTR and readable.
- [ ] Primary flows pass keyboard-only navigation and accessible-name checks.
- [ ] Error pages state what failed, what was preserved, and the next action.
- [ ] Deployment state remains understandable without color.

## Likely files

- `src/Marsa.Server/Resources/`
- `src/Marsa.Server/Components/Layout/`
- `src/Marsa.Server/wwwroot/css/rtl.css`
- `tests/Marsa.Server.Tests/Accessibility/`

## Test notes

- Playwright RTL screenshots at 360 px and 1280 px.
- Keyboard and accessible-name tests for primary flows.
- Locale persistence and date/number formatting tests.

## Requirement coverage

- `FR-UI-06`
- `FR-UI-07`
- `FR-UI-08`
- `NFR-UX-01`
- `NFR-UX-02`
- `NFR-UX-03`
- `NFR-UX-04`
- `NFR-UX-05`

## Roadmap stories

- `E9.9`
- `E9.10`
- `E9.11`
- `E9.12`

## Dependencies

<!-- dependency-links -->
- Depends on `m5-03-dashboard-primary-flow`.

## Out of scope

- Additional languages, automatic translation, and a marketing-site localization.
