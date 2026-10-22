---
title: "M4: Verify custom hostnames and surface Caddy certificate status"
labels: [type/feature, area/edge, area/api, priority/p0, status/ready, size/l]
milestone: "M4"
epic: "E6"
size: "l"
depends_on: [m4-01-caddy-route-adapter]
requirements: [FR-EDGE-02, FR-EDGE-03, FR-EDGE-04, FR-EDGE-08, NFR-SEC-06]
stories: [E6.3, E6.4, E6.8]
---

## Context

A hostname may be attached only after proof of control. Verification, certificate issuance, and HTTP redirect must be idempotent and isolated so one bad domain cannot break the control plane or other routes.

## Scope

- Show exact TXT/CNAME records and verify control idempotently.
- Normalize lowercase hostnames and reject wildcards, IP literals, ports, paths, trailing dots, and unsafe IDN.
- Allow one verified custom hostname per service in 0.1.
- Let Caddy obtain and renew certificates using HTTP-01; surface pending, active, and failed status.
- Redirect HTTP to HTTPS for verified hostnames without breaking ACME challenges.
- Isolate a certificate failure to the affected route.

## Acceptance criteria

- [ ] An unverified hostname cannot be attached or routed.
- [ ] Verification can be retried without duplicate records.
- [ ] Negative tests cover wildcards, IPs, ports, paths, uppercase, trailing dots, and IDN.
- [ ] Certificate status is visible in the API and UI.
- [ ] One failing certificate does not break other routes or the control route.
- [ ] Plain HTTP redirects to HTTPS and ACME challenges remain reachable.

## Likely files

- `src/Marsa.Application/Domains/`
- `src/Marsa.Infrastructure/Edge/DnsVerifier.cs`
- `src/Marsa.Infrastructure/Edge/CertificateStatusReader.cs`
- `src/Marsa.Server/Endpoints/DomainsEndpoints.cs`

## Test notes

- Hostname normalization table tests.
- DNS verification idempotency and wrong-record tests.
- Caddy staging CA integration and redirect tests.

## Requirement coverage

- `FR-EDGE-02`
- `FR-EDGE-03`
- `FR-EDGE-04`
- `FR-EDGE-08`
- `NFR-SEC-06`

## Roadmap stories

- `E6.3`
- `E6.4`
- `E6.8`

## Dependencies

<!-- dependency-links -->
- Depends on `m4-01-caddy-route-adapter`.

## Out of scope

- Wildcard certificates, external DNS automation, custom CAs, and multiple hostnames per service.
