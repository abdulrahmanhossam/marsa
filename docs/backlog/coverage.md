# Requirement and story coverage

> Generated from the issue frontmatter. Do not hand-edit; update the issue drafts and regenerate.
> 39 issues; 102 MUST functional requirements; 30 NFRs.

## Mandatory coverage

Every MUST functional requirement and every NFR maps to at least one issue. The validator in
`scripts/validate-backlog.py` blocks a regression.

| Requirement | Priority | Milestone | Issue(s) |
|---|---|---|---|
| `FR-API-01` | MUST | M1 | [`m1-04-api-contract`](issues/m1-04-api-contract.md) |
| `FR-API-02` | MUST | M1 | [`m1-04-api-contract`](issues/m1-04-api-contract.md) |
| `FR-API-03` | MUST | M0 | [`m0-02-health-errors-docker`](issues/m0-02-health-errors-docker.md) |
| `FR-API-04` | MUST | M2 | [`m2-01-project-crud`](issues/m2-01-project-crud.md) |
| `FR-API-05` | MUST | M3 | [`m3-03-deployment-admission`](issues/m3-03-deployment-admission.md) |
| `FR-API-06` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-API-07` | MUST | M5 | [`m5-05-diagnostics-and-rate-limits`](issues/m5-05-diagnostics-and-rate-limits.md) |
| `FR-API-08` | MUST | M1 | [`m1-04-api-contract`](issues/m1-04-api-contract.md) |
| `FR-AUTH-01` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-AUTH-02` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-AUTH-03` | MUST | M1 | [`m1-02-rbac-pats-tenant-isolation`](issues/m1-02-rbac-pats-tenant-isolation.md) |
| `FR-AUTH-04` | MUST | M1 | [`m1-02-rbac-pats-tenant-isolation`](issues/m1-02-rbac-pats-tenant-isolation.md) |
| `FR-AUTH-05` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-AUTH-06` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-BUILD-01` | MUST | M0 | [`m0-02-health-errors-docker`](issues/m0-02-health-errors-docker.md) |
| `FR-BUILD-02` | MUST | M2 | [`m2-06-source-export`](issues/m2-06-source-export.md) |
| `FR-BUILD-03` | MUST | M2 | [`m2-07-build-pipeline`](issues/m2-07-build-pipeline.md) |
| `FR-BUILD-04` | MUST | M2 | [`m2-07-build-pipeline`](issues/m2-07-build-pipeline.md) |
| `FR-BUILD-05` | MUST | M2 | [`m2-07-build-pipeline`](issues/m2-07-build-pipeline.md) |
| `FR-BUILD-06` | MUST | M2 | [`m2-07-build-pipeline`](issues/m2-07-build-pipeline.md) |
| `FR-BUILD-07` | MUST | M2 | [`m2-07-build-pipeline`](issues/m2-07-build-pipeline.md) |
| `FR-BUILD-08` | MUST | M2 | [`m2-07-build-pipeline`](issues/m2-07-build-pipeline.md) |
| `FR-CLI-01` | MUST | M5 | [`m5-02-cli`](issues/m5-02-cli.md) |
| `FR-CLI-02` | MUST | M5 | [`m5-02-cli`](issues/m5-02-cli.md) |
| `FR-CLI-03` | MUST | M5 | [`m5-02-cli`](issues/m5-02-cli.md) |
| `FR-CLI-04` | MUST | M5 | [`m5-02-cli`](issues/m5-02-cli.md) |
| `FR-CLI-05` | MUST | M5 | [`m5-02-cli`](issues/m5-02-cli.md) |
| `FR-DEP-01` | MUST | M3 | [`m3-03-deployment-admission`](issues/m3-03-deployment-admission.md) |
| `FR-DEP-02` | MUST | M3 | [`m3-03-deployment-admission`](issues/m3-03-deployment-admission.md) |
| `FR-DEP-03` | MUST | M3 | [`m3-03-deployment-admission`](issues/m3-03-deployment-admission.md) |
| `FR-DEP-04` | MUST | M3 | [`m3-03-deployment-admission`](issues/m3-03-deployment-admission.md) |
| `FR-DEP-05` | MUST | M3 | [`m3-04-worker-lease-recovery`](issues/m3-04-worker-lease-recovery.md) |
| `FR-DEP-06` | MUST | M3 | [`m3-05-cancel-activate-reconcile`](issues/m3-05-cancel-activate-reconcile.md) |
| `FR-DEP-07` | MUST | M3 | [`m3-05-cancel-activate-reconcile`](issues/m3-05-cancel-activate-reconcile.md) |
| `FR-DEP-08` | MUST | M3 | [`m3-03-deployment-admission`](issues/m3-03-deployment-admission.md) |
| `FR-DEP-09` | MUST | M5 | [`m5-01-rollback-and-retention`](issues/m5-01-rollback-and-retention.md) |
| `FR-DEP-11` | MUST | M3 | [`m3-05-cancel-activate-reconcile`](issues/m3-05-cancel-activate-reconcile.md) |
| `FR-DET-01` | MUST | M2 | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `FR-DET-02` | MUST | M2 | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `FR-DET-03` | MUST | M2 | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `FR-DET-04` | MUST | M2 | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `FR-DET-05` | MUST | M2 | [`m2-05-marsa-json`](issues/m2-05-marsa-json.md) |
| `FR-DET-06` | MUST | M2 | [`m2-05-marsa-json`](issues/m2-05-marsa-json.md) |
| `FR-DET-07` | MUST | M2 | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `FR-DET-08` | MUST | M2 | [`m2-05-marsa-json`](issues/m2-05-marsa-json.md) |
| `FR-EDGE-01` | MUST | M4 | [`m4-01-caddy-route-adapter`](issues/m4-01-caddy-route-adapter.md) |
| `FR-EDGE-02` | MUST | M4 | [`m4-02-domains-and-tls`](issues/m4-02-domains-and-tls.md) |
| `FR-EDGE-03` | MUST | M4 | [`m4-02-domains-and-tls`](issues/m4-02-domains-and-tls.md) |
| `FR-EDGE-04` | MUST | M4 | [`m4-02-domains-and-tls`](issues/m4-02-domains-and-tls.md) |
| `FR-EDGE-05` | MUST | M4 | [`m4-01-caddy-route-adapter`](issues/m4-01-caddy-route-adapter.md) |
| `FR-EDGE-06` | MUST | M4 | [`m4-03-health-gated-cutover`](issues/m4-03-health-gated-cutover.md) |
| `FR-EDGE-07` | MUST | M4 | [`m4-01-caddy-route-adapter`](issues/m4-01-caddy-route-adapter.md) |
| `FR-OBS-01` | MUST | M3 | [`m3-06-logs`](issues/m3-06-logs.md) |
| `FR-OBS-02` | MUST | M3 | [`m3-06-logs`](issues/m3-06-logs.md) |
| `FR-OBS-03` | MUST | M3 | [`m3-07-realtime-deploy-ui`](issues/m3-07-realtime-deploy-ui.md) |
| `FR-OBS-04` | MUST | M0 | [`m0-02-health-errors-docker`](issues/m0-02-health-errors-docker.md) |
| `FR-OBS-05` | MUST | M0 | [`m0-02-health-errors-docker`](issues/m0-02-health-errors-docker.md) |
| `FR-OPS-01` | MUST | M6 | [`m6-01-install-and-upgrade`](issues/m6-01-install-and-upgrade.md) |
| `FR-OPS-02` | MUST | M6 | [`m6-01-install-and-upgrade`](issues/m6-01-install-and-upgrade.md) |
| `FR-OPS-03` | MUST | M6 | [`m6-02-backup-restore-runbooks`](issues/m6-02-backup-restore-runbooks.md) |
| `FR-OPS-04` | MUST | M5 | [`m5-05-diagnostics-and-rate-limits`](issues/m5-05-diagnostics-and-rate-limits.md) |
| `FR-OPS-05` | MUST | M6 | [`m6-02-backup-restore-runbooks`](issues/m6-02-backup-restore-runbooks.md) |
| `FR-OPS-07` | MUST | M6 | [`m6-03-supply-chain-and-release`](issues/m6-03-supply-chain-and-release.md) |
| `FR-RUN-01` | MUST | M3 | [`m3-01-runtime-container`](issues/m3-01-runtime-container.md) |
| `FR-RUN-02` | MUST | M3 | [`m3-01-runtime-container`](issues/m3-01-runtime-container.md) |
| `FR-RUN-03` | MUST | M3 | [`m3-01-runtime-container`](issues/m3-01-runtime-container.md) |
| `FR-RUN-04` | MUST | M3 | [`m3-01-runtime-container`](issues/m3-01-runtime-container.md) |
| `FR-RUN-05` | MUST | M3 | [`m3-02-health-and-release-retention`](issues/m3-02-health-and-release-retention.md) |
| `FR-RUN-06` | MUST | M3 | [`m3-01-runtime-container`](issues/m3-01-runtime-container.md) |
| `FR-RUN-07` | MUST | M3 | [`m3-06-logs`](issues/m3-06-logs.md) |
| `FR-RUN-08` | MUST | M3 | [`m3-02-health-and-release-retention`](issues/m3-02-health-and-release-retention.md) |
| `FR-SEC-01` | MUST | M4 | [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `FR-SEC-02` | MUST | M4 | [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `FR-SEC-04` | MUST | M4 | [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `FR-SEC-05` | MUST | M4 | [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `FR-SEC-06` | MUST | M4 | [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `FR-SEC-07` | MUST | M4 | [`m4-05-audit-trail`](issues/m4-05-audit-trail.md) |
| `FR-SEC-08` | MUST | M4 | [`m4-05-audit-trail`](issues/m4-05-audit-trail.md) |
| `FR-SETUP-01` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-SETUP-02` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-SETUP-03` | MUST | M0 | [`m0-01-solution-skeleton`](issues/m0-01-solution-skeleton.md) |
| `FR-SETUP-04` | MUST | M1 | [`m1-03-preflight-and-public-url`](issues/m1-03-preflight-and-public-url.md) |
| `FR-SETUP-05` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-SETUP-06` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-SETUP-07` | MUST | M1 | [`m1-03-preflight-and-public-url`](issues/m1-03-preflight-and-public-url.md) |
| `FR-SRC-01` | MUST | M2 | [`m2-01-project-crud`](issues/m2-01-project-crud.md) |
| `FR-SRC-02` | MUST | M2 | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `FR-SRC-03` | MUST | M2 | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `FR-SRC-04` | MUST | M2 | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `FR-SRC-05` | MUST | M2 | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `FR-SRC-06` | MUST | M2 | [`m2-03-repo-limits-webhooks`](issues/m2-03-repo-limits-webhooks.md) |
| `FR-SRC-07` | MUST | M2 | [`m2-03-repo-limits-webhooks`](issues/m2-03-repo-limits-webhooks.md) |
| `FR-SRC-09` | MUST | M2 | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `FR-SRC-10` | MUST | M2 | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `FR-UI-01` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-UI-02` | MUST | M5 | [`m5-03-dashboard-primary-flow`](issues/m5-03-dashboard-primary-flow.md) |
| `FR-UI-03` | MUST | M4 | [`m4-06-domains-members-settings-ui`](issues/m4-06-domains-members-settings-ui.md) |
| `FR-UI-04` | MUST | M4 | [`m4-06-domains-members-settings-ui`](issues/m4-06-domains-members-settings-ui.md) |
| `FR-UI-05` | MUST | M1 | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `FR-UI-06` | MUST | M5 | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `FR-UI-07` | MUST | M5 | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `FR-UI-09` | MUST | M2 | [`m2-08-project-source-ui`](issues/m2-08-project-source-ui.md) |

## Non-functional requirements

| Requirement | Issue(s) |
|---|---|
| `NFR-COMP-01` | [`m0-03-local-stack-images-ci`](issues/m0-03-local-stack-images-ci.md) |
| `NFR-COMP-02` | [`m6-04-e2e-release-gates`](issues/m6-04-e2e-release-gates.md) |
| `NFR-COMP-03` | [`m0-01-solution-skeleton`](issues/m0-01-solution-skeleton.md) |
| `NFR-COMP-04` | [`m0-01-solution-skeleton`](issues/m0-01-solution-skeleton.md) |
| `NFR-REL-01` | [`m3-03-deployment-admission`](issues/m3-03-deployment-admission.md) |
| `NFR-REL-02` | [`m3-04-worker-lease-recovery`](issues/m3-04-worker-lease-recovery.md) |
| `NFR-REL-03` | [`m3-02-health-and-release-retention`](issues/m3-02-health-and-release-retention.md), [`m4-03-health-gated-cutover`](issues/m4-03-health-gated-cutover.md) |
| `NFR-REL-04` | [`m3-05-cancel-activate-reconcile`](issues/m3-05-cancel-activate-reconcile.md), [`m4-01-caddy-route-adapter`](issues/m4-01-caddy-route-adapter.md) |
| `NFR-REL-05` | [`m3-04-worker-lease-recovery`](issues/m3-04-worker-lease-recovery.md) |
| `NFR-REL-06` | [`m3-04-worker-lease-recovery`](issues/m3-04-worker-lease-recovery.md) |
| `NFR-REL-07` | [`m5-07-hardening-matrix`](issues/m5-07-hardening-matrix.md) |
| `NFR-REL-08` | [`m6-02-backup-restore-runbooks`](issues/m6-02-backup-restore-runbooks.md) |
| `NFR-REL-09` | [`m5-01-rollback-and-retention`](issues/m5-01-rollback-and-retention.md) |
| `NFR-SEC-01` | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `NFR-SEC-02` | [`m1-02-rbac-pats-tenant-isolation`](issues/m1-02-rbac-pats-tenant-isolation.md), [`m2-01-project-crud`](issues/m2-01-project-crud.md) |
| `NFR-SEC-03` | [`m3-01-runtime-container`](issues/m3-01-runtime-container.md) |
| `NFR-SEC-04` | [`m3-06-logs`](issues/m3-06-logs.md), [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `NFR-SEC-05` | [`m2-03-repo-limits-webhooks`](issues/m2-03-repo-limits-webhooks.md) |
| `NFR-SEC-06` | [`m2-02-source-connections`](issues/m2-02-source-connections.md), [`m4-02-domains-and-tls`](issues/m4-02-domains-and-tls.md) |
| `NFR-SEC-07` | [`m2-06-source-export`](issues/m2-06-source-export.md) |
| `NFR-SEC-08` | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `NFR-SEC-09` | [`m6-03-supply-chain-and-release`](issues/m6-03-supply-chain-and-release.md) |
| `NFR-SEC-10` | [`m6-03-supply-chain-and-release`](issues/m6-03-supply-chain-and-release.md) |
| `NFR-SEC-11` | [`m4-05-audit-trail`](issues/m4-05-audit-trail.md) |
| `NFR-SEC-12` | [`m5-05-diagnostics-and-rate-limits`](issues/m5-05-diagnostics-and-rate-limits.md) |
| `NFR-UX-01` | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `NFR-UX-02` | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `NFR-UX-03` | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `NFR-UX-04` | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `NFR-UX-05` | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |

## Non-blocking requirements

SHOULD and COULD items may ship after the MVP; every one is mapped here or listed as a backlog candidate.

| Requirement | Priority | Milestone | Issue(s) |
|---|---|---|---|
| `FR-API-09` | OUT | — | Out of scope for 0.1 |
| `FR-AUTH-07` | OUT | — | Out of scope for 0.1 |
| `FR-AUTH-08` | SHOULD | M1 | [`m1-02-rbac-pats-tenant-isolation`](issues/m1-02-rbac-pats-tenant-isolation.md) |
| `FR-CLI-06` | COULD | Post-MVP | Backlog candidate (not required for 0.1) |
| `FR-DEP-10` | OUT | — | Out of scope for 0.1 |
| `FR-DEP-12` | SHOULD | M5 | [`m5-01-rollback-and-retention`](issues/m5-01-rollback-and-retention.md) |
| `FR-DET-09` | SHOULD | M2 | [`m2-05-marsa-json`](issues/m2-05-marsa-json.md) |
| `FR-EDGE-08` | SHOULD | M4 | [`m4-02-domains-and-tls`](issues/m4-02-domains-and-tls.md) |
| `FR-EDGE-09` | OUT | — | Out of scope for 0.1 |
| `FR-OBS-06` | SHOULD | M5 | [`m5-06-metrics-retention-disk`](issues/m5-06-metrics-retention-disk.md) |
| `FR-OBS-07` | SHOULD | M5 | [`m5-06-metrics-retention-disk`](issues/m5-06-metrics-retention-disk.md) |
| `FR-OBS-08` | SHOULD | M5 | [`m5-06-metrics-retention-disk`](issues/m5-06-metrics-retention-disk.md) |
| `FR-OPS-06` | SHOULD | M5 | [`m5-06-metrics-retention-disk`](issues/m5-06-metrics-retention-disk.md) |
| `FR-OPS-08` | OUT | — | Out of scope for 0.1 |
| `FR-SEC-03` | SHOULD | M4 | [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `FR-SEC-09` | OUT | — | Out of scope for 0.1 |
| `FR-SRC-08` | SHOULD | M2 | [`m2-03-repo-limits-webhooks`](issues/m2-03-repo-limits-webhooks.md) |
| `FR-UI-08` | SHOULD | M5 | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `FR-UI-10` | OUT | — | Out of scope for 0.1 |

## Roadmap story coverage

| Story | Issue(s) |
|---|---|
| `E0.1` | [`m0-01-solution-skeleton`](issues/m0-01-solution-skeleton.md) |
| `E0.2` | [`m0-01-solution-skeleton`](issues/m0-01-solution-skeleton.md) |
| `E0.3` | [`m0-03-local-stack-images-ci`](issues/m0-03-local-stack-images-ci.md) |
| `E0.4` | [`m0-03-local-stack-images-ci`](issues/m0-03-local-stack-images-ci.md) |
| `E0.5` | [`m0-01-solution-skeleton`](issues/m0-01-solution-skeleton.md) |
| `E0.6` | [`m0-02-health-errors-docker`](issues/m0-02-health-errors-docker.md) |
| `E0.7` | [`m0-03-local-stack-images-ci`](issues/m0-03-local-stack-images-ci.md) |
| `E0.8` | [`m0-03-local-stack-images-ci`](issues/m0-03-local-stack-images-ci.md) |
| `E0.9` | [`m6-03-supply-chain-and-release`](issues/m6-03-supply-chain-and-release.md) |
| `E0.10` | [`m1-04-api-contract`](issues/m1-04-api-contract.md) |
| `E0.11` | [`m6-03-supply-chain-and-release`](issues/m6-03-supply-chain-and-release.md) |
| `E1.1` | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `E1.2` | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `E1.3` | [`m1-02-rbac-pats-tenant-isolation`](issues/m1-02-rbac-pats-tenant-isolation.md) |
| `E1.4` | [`m1-02-rbac-pats-tenant-isolation`](issues/m1-02-rbac-pats-tenant-isolation.md) |
| `E1.5` | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `E1.6` | [`m1-02-rbac-pats-tenant-isolation`](issues/m1-02-rbac-pats-tenant-isolation.md) |
| `E1.7` | [`m1-03-preflight-and-public-url`](issues/m1-03-preflight-and-public-url.md) |
| `E1.8` | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `E2.1` | [`m2-01-project-crud`](issues/m2-01-project-crud.md) |
| `E2.2` | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `E2.3` | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `E2.4` | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `E2.5` | [`m2-03-repo-limits-webhooks`](issues/m2-03-repo-limits-webhooks.md) |
| `E2.6` | [`m2-03-repo-limits-webhooks`](issues/m2-03-repo-limits-webhooks.md) |
| `E2.7` | [`m2-03-repo-limits-webhooks`](issues/m2-03-repo-limits-webhooks.md) |
| `E2.8` | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `E2.9` | [`m2-02-source-connections`](issues/m2-02-source-connections.md) |
| `E3.1` | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `E3.2` | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `E3.3` | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `E3.4` | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `E3.5` | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `E3.6` | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `E3.7` | [`m2-05-marsa-json`](issues/m2-05-marsa-json.md) |
| `E3.8` | [`m2-05-marsa-json`](issues/m2-05-marsa-json.md) |
| `E3.9` | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `E3.10` | [`m2-04-detection-engine`](issues/m2-04-detection-engine.md) |
| `E4.1` | [`m0-02-health-errors-docker`](issues/m0-02-health-errors-docker.md) |
| `E4.2` | [`m2-06-source-export`](issues/m2-06-source-export.md) |
| `E4.3` | [`m2-07-build-pipeline`](issues/m2-07-build-pipeline.md) |
| `E4.4` | [`m2-07-build-pipeline`](issues/m2-07-build-pipeline.md) |
| `E4.5` | [`m3-01-runtime-container`](issues/m3-01-runtime-container.md) |
| `E4.6` | [`m3-01-runtime-container`](issues/m3-01-runtime-container.md) |
| `E4.7` | [`m2-07-build-pipeline`](issues/m2-07-build-pipeline.md) |
| `E4.8` | [`m3-02-health-and-release-retention`](issues/m3-02-health-and-release-retention.md) |
| `E4.9` | [`m2-07-build-pipeline`](issues/m2-07-build-pipeline.md) |
| `E5.1` | [`m3-03-deployment-admission`](issues/m3-03-deployment-admission.md) |
| `E5.2` | [`m3-03-deployment-admission`](issues/m3-03-deployment-admission.md) |
| `E5.3` | [`m3-04-worker-lease-recovery`](issues/m3-04-worker-lease-recovery.md) |
| `E5.4` | [`m3-05-cancel-activate-reconcile`](issues/m3-05-cancel-activate-reconcile.md) |
| `E5.5` | [`m3-02-health-and-release-retention`](issues/m3-02-health-and-release-retention.md), [`m3-05-cancel-activate-reconcile`](issues/m3-05-cancel-activate-reconcile.md) |
| `E5.6` | [`m3-04-worker-lease-recovery`](issues/m3-04-worker-lease-recovery.md) |
| `E5.7` | [`m5-01-rollback-and-retention`](issues/m5-01-rollback-and-retention.md) |
| `E5.8` | [`m3-05-cancel-activate-reconcile`](issues/m3-05-cancel-activate-reconcile.md) |
| `E5.9` | [`m5-01-rollback-and-retention`](issues/m5-01-rollback-and-retention.md) |
| `E5.10` | [`m3-05-cancel-activate-reconcile`](issues/m3-05-cancel-activate-reconcile.md) |
| `E6.1` | [`m4-01-caddy-route-adapter`](issues/m4-01-caddy-route-adapter.md) |
| `E6.2` | [`m4-01-caddy-route-adapter`](issues/m4-01-caddy-route-adapter.md) |
| `E6.3` | [`m4-02-domains-and-tls`](issues/m4-02-domains-and-tls.md) |
| `E6.4` | [`m4-02-domains-and-tls`](issues/m4-02-domains-and-tls.md) |
| `E6.5` | [`m4-03-health-gated-cutover`](issues/m4-03-health-gated-cutover.md) |
| `E6.6` | [`m4-03-health-gated-cutover`](issues/m4-03-health-gated-cutover.md), [`m5-01-rollback-and-retention`](issues/m5-01-rollback-and-retention.md) |
| `E6.7` | [`m4-01-caddy-route-adapter`](issues/m4-01-caddy-route-adapter.md) |
| `E6.8` | [`m4-02-domains-and-tls`](issues/m4-02-domains-and-tls.md) |
| `E7.1` | [`m3-06-logs`](issues/m3-06-logs.md) |
| `E7.2` | [`m3-06-logs`](issues/m3-06-logs.md) |
| `E7.3` | [`m3-07-realtime-deploy-ui`](issues/m3-07-realtime-deploy-ui.md) |
| `E7.4` | [`m0-02-health-errors-docker`](issues/m0-02-health-errors-docker.md) |
| `E7.5` | [`m5-06-metrics-retention-disk`](issues/m5-06-metrics-retention-disk.md) |
| `E7.6` | [`m5-06-metrics-retention-disk`](issues/m5-06-metrics-retention-disk.md) |
| `E7.7` | [`m3-06-logs`](issues/m3-06-logs.md), [`m5-06-metrics-retention-disk`](issues/m5-06-metrics-retention-disk.md) |
| `E7.8` | [`m5-06-metrics-retention-disk`](issues/m5-06-metrics-retention-disk.md) |
| `E8.1` | [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `E8.2` | [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `E8.3` | [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `E8.4` | [`m4-04-secrets-envelope`](issues/m4-04-secrets-envelope.md) |
| `E8.5` | [`m4-05-audit-trail`](issues/m4-05-audit-trail.md) |
| `E8.6` | [`m4-05-audit-trail`](issues/m4-05-audit-trail.md) |
| `E8.7` | [`m6-02-backup-restore-runbooks`](issues/m6-02-backup-restore-runbooks.md) |
| `E9.1` | [`m5-02-cli`](issues/m5-02-cli.md) |
| `E9.2` | [`m5-02-cli`](issues/m5-02-cli.md) |
| `E9.3` | [`m5-02-cli`](issues/m5-02-cli.md) |
| `E9.4` | [`m5-02-cli`](issues/m5-02-cli.md) |
| `E9.5` | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `E9.6` | [`m3-07-realtime-deploy-ui`](issues/m3-07-realtime-deploy-ui.md) |
| `E9.7` | [`m4-06-domains-members-settings-ui`](issues/m4-06-domains-members-settings-ui.md) |
| `E9.8` | [`m1-01-setup-and-login`](issues/m1-01-setup-and-login.md) |
| `E9.9` | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `E9.10` | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `E9.11` | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `E9.12` | [`m5-04-i18n-rtl-accessibility`](issues/m5-04-i18n-rtl-accessibility.md) |
| `E9.13` | [`m2-08-project-source-ui`](issues/m2-08-project-source-ui.md) |
| `E9.14` | [`m5-03-dashboard-primary-flow`](issues/m5-03-dashboard-primary-flow.md) |
| `E10.1` | [`m5-05-diagnostics-and-rate-limits`](issues/m5-05-diagnostics-and-rate-limits.md), [`m5-07-hardening-matrix`](issues/m5-07-hardening-matrix.md) |
| `E10.2` | [`m5-05-diagnostics-and-rate-limits`](issues/m5-05-diagnostics-and-rate-limits.md), [`m5-07-hardening-matrix`](issues/m5-07-hardening-matrix.md) |
| `E10.3` | [`m5-07-hardening-matrix`](issues/m5-07-hardening-matrix.md) |
| `E10.4` | [`m5-07-hardening-matrix`](issues/m5-07-hardening-matrix.md) |
| `E10.5` | [`m6-02-backup-restore-runbooks`](issues/m6-02-backup-restore-runbooks.md) |
| `E10.6` | [`m6-01-install-and-upgrade`](issues/m6-01-install-and-upgrade.md) |
| `E10.7` | [`m6-04-e2e-release-gates`](issues/m6-04-e2e-release-gates.md) |
| `E10.8` | [`m6-02-backup-restore-runbooks`](issues/m6-02-backup-restore-runbooks.md) |
| `E10.9` | [`m6-03-supply-chain-and-release`](issues/m6-03-supply-chain-and-release.md) |
| `E10.10` | [`m6-03-supply-chain-and-release`](issues/m6-03-supply-chain-and-release.md) |

## Unmapped stories

None. The 39 issues group the 104 roadmap stories; every story has an owner.
