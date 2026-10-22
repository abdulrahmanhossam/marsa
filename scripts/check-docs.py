#!/usr/bin/env python3
"""Check relative Markdown links and required documentation files."""

from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parent.parent
LINK = re.compile(r"\[[^\]]*\]\(([^)]+)\)")
REQUIRED = [
    "README.md",
    "AGENTS.md",
    "opencode.json",
    "LICENSE",
    "docs/README.md",
    "docs/00-identity.md",
    "docs/00-progress.md",
    "docs/01-product-requirements.md",
    "docs/03-architecture.md",
    "docs/07-security.md",
    "docs/07-risks-and-open-questions.md",
    "docs/08-roadmap.md",
    "docs/ar/project-explained.ar.md",
    "docs/ar/glossary.ar.md",
]


def relative_links(path: Path):
    text = path.read_text(encoding="utf-8")
    for match in LINK.finditer(text):
        target = match.group(1).strip()
        if target.startswith(("http://", "https://", "mailto:", "urn:", "#")):
            continue
        if " " in target and not target.startswith("<"):
            target = target.split(" ", 1)[0]
        target = unquote(target.split("#", 1)[0])
        if target:
            yield match.group(0), target


def main() -> int:
    failures: list[str] = []
    for required in REQUIRED:
        if not (ROOT / required).exists():
            failures.append(f"missing required file: {required}")

    for path in sorted(ROOT.rglob("*.md")):
        if any(part in {".git", "node_modules", "bin", "obj"} for part in path.parts):
            continue
        for source, target in relative_links(path):
            resolved = (path.parent / target).resolve()
            if not resolved.exists():
                rel = path.relative_to(ROOT)
                failures.append(f"{rel}: broken link {source} -> {target}")

    if failures:
        print("Documentation checks failed:", file=sys.stderr)
        for failure in failures:
            print(f"  - {failure}", file=sys.stderr)
        return 1

    print(f"Documentation checks passed ({len(list(ROOT.rglob('*.md')))} Markdown files).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
