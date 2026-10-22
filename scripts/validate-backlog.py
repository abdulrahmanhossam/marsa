#!/usr/bin/env python3
"""Validate issue frontmatter, labels, dependencies, and requirement coverage."""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ISSUES = ROOT / "docs" / "backlog" / "issues"
PRD = ROOT / "docs" / "01-product-requirements.md"
COVERAGE = ROOT / "docs" / "backlog" / "coverage.md"

FR = re.compile(
    r"^\| ((?:FR)-[A-Z]+-\d+) \| .*? \| (MUST|SHOULD|COULD|OUT) \|",
    re.MULTILINE,
)
NFR = re.compile(r"^\| (NFR-[A-Z]+-\d+) \|", re.MULTILINE)
REQUIRED_FIELDS = {
    "title", "labels", "milestone", "epic", "size", "depends_on", "requirements", "stories",
}


def parse_list(value: str) -> list[str]:
    value = value.strip()
    if not (value.startswith("[") and value.endswith("]")):
        return []
    inner = value[1:-1].strip()
    return [] if not inner else [part.strip().strip('"').strip("'") for part in inner.split(",")]


def parse_issue(path: Path) -> dict:
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        raise ValueError("missing frontmatter")
    try:
        _, frontmatter, _ = text.split("---", 2)
    except ValueError as exc:
        raise ValueError("unterminated frontmatter") from exc
    data: dict = {"path": path}
    for line in frontmatter.strip().splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        if ":" not in line:
            raise ValueError(f"bad line {line!r}")
        key, value = line.split(":", 1)
        value = value.strip()
        data[key.strip()] = parse_list(value) if value.startswith("[") else value.strip('"').strip("'")
    missing = REQUIRED_FIELDS - data.keys()
    if missing:
        raise ValueError(f"missing fields: {sorted(missing)}")
    return data


def main() -> int:
    failures: list[str] = []
    if not PRD.exists():
        print(f"missing {PRD}", file=sys.stderr)
        return 1
    text = PRD.read_text(encoding="utf-8")
    fr = dict(FR.findall(text))
    nfr = NFR.findall(text)
    required = {rid for rid, priority in fr.items() if priority == "MUST"} | set(nfr)
    known = set(fr) | set(nfr)

    labels = set()
    for line in (ROOT / "labels.yml").read_text(encoding="utf-8").splitlines():
        match = re.match(r'\s*- name:\s*"?([^"]+)"?', line)
        if match:
            labels.add(match.group(1).strip())
    if not labels:
        failures.append("labels.yml has no labels")

    issues: dict[str, dict] = {}
    covered: set[str] = set()
    for path in sorted(ISSUES.glob("*.md")):
        try:
            issue = parse_issue(path)
        except ValueError as exc:
            failures.append(f"{path.name}: {exc}")
            continue
        slug = path.stem
        if slug in issues:
            failures.append(f"duplicate issue id: {slug}")
        issues[slug] = issue
        if issue["milestone"] not in {"M0", "M1", "M2", "M3", "M4", "M5", "M6"}:
            failures.append(f"{slug}: invalid milestone {issue['milestone']}")
        for label in issue["labels"]:
            if label not in labels:
                failures.append(f"{slug}: unknown label {label}")
        for requirement in issue["requirements"]:
            if requirement not in known:
                failures.append(f"{slug}: unknown requirement {requirement}")
            covered.add(requirement)

    for slug, issue in issues.items():
        for dependency in issue["depends_on"]:
            if dependency not in issues:
                failures.append(f"{slug}: unknown dependency {dependency}")

    missing = sorted(required - covered)
    if missing:
        failures.append(f"{len(missing)} mandatory requirements have no issue: {', '.join(missing)}")

    if COVERAGE.exists():
        coverage = COVERAGE.read_text(encoding="utf-8")
        for requirement in sorted(required):
            if f"`{requirement}`" not in coverage:
                failures.append(f"coverage.md omits {requirement}")

    if failures:
        print("Backlog validation failed:", file=sys.stderr)
        for failure in failures:
            print(f"  - {failure}", file=sys.stderr)
        return 1

    print(
        f"Backlog valid: {len(issues)} issues, {len(covered)} requirements mapped, "
        f"{len(required)} mandatory requirements covered."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
