---
title: "M6: Produce SBOM, checksums, license inventory, and multi-arch release artifacts"
labels: [type/infra, area/release, area/security, priority/p0, status/ready, size/l]
milestone: "M6"
epic: "E10"
size: "l"
depends_on: [m6-01-install-and-upgrade]
requirements: [FR-OPS-07, NFR-SEC-09, NFR-SEC-10]
stories: [E10.9, E10.10, E0.9, E0.11]
---

## Context

The default distribution must be free of GPL and unknown-license components, with an SBOM and notices that match what ships. Release artifacts must be reproducible enough to verify and pinned by digest.

## Scope

- Generate an SBOM for the server image, CLI binaries, and bundled deploy assets.
- Publish checksums and a license inventory; fail CI on an unapproved license.
- Add `LICENSE`, `NOTICE`, and `THIRD-PARTY-NOTICES.md`.
- Build multi-arch server images and CLI binaries and pin the image by digest.
- Include the migration bundle, compose/Caddy/systemd templates, and release notes.
- Scan dependencies and images; block unapproved High/Critical findings.
- Complete the clean-room evidence ledger for non-trivial design and dependency decisions.

## Acceptance criteria

- [ ] No GPL or unknown-license component appears in the default distribution.
- [ ] The SBOM matches the shipped artifacts and is published with checksums.
- [ ] CI blocks a new unapproved license or unapproved High/Critical finding.
- [ ] The server image is available for amd64 and arm64 and referenced by digest.
- [ ] Release notes list breaking changes, migration steps, and known issues.
- [ ] Notices cover every bundled third-party component.
- [ ] The clean-room evidence ledger is complete and links provenance to the affected docs.

## Likely files

- `docs/release/sbom/`
- `docs/release/checksums.txt`
- `THIRD-PARTY-NOTICES.md`
- `LICENSE`
- `NOTICE`
- `.github/workflows/release.yml`
- `eng/publish.sh`

## Test notes

- License inventory gate on the default image.
- SBOM and checksum verification.
- Multi-arch image smoke test.

## Requirement coverage

- `FR-OPS-07`
- `NFR-SEC-09`
- `NFR-SEC-10`

## Roadmap stories

- `E10.9`
- `E10.10`
- `E0.9`
- `E0.11`

## Dependencies

<!-- dependency-links -->
- Depends on `m6-01-install-and-upgrade`.

## Out of scope

- Publishing to a paid marketplace, code signing certificates, and reproducible-build attestations beyond SLSA basics.
