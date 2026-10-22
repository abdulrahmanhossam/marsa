#!/usr/bin/env bash
# Create or update labels from labels.yml. Dry-run is the default.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODE="${1:---dry-run}"

case "$MODE" in
  --dry-run|--apply) ;;
  *)
    echo "usage: $0 [--dry-run|--apply]" >&2
    exit 2
    ;;
esac

if [[ "$MODE" == "--apply" ]]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "gh is required for --apply" >&2
    exit 1
  fi
  if ! gh auth status >/dev/null 2>&1; then
    echo "gh is not authenticated; run 'gh auth login' first" >&2
    exit 1
  fi
fi

python3 - "$ROOT" "$MODE" <<'PY'
import subprocess
import sys
from pathlib import Path

root = Path(sys.argv[1])
mode = sys.argv[2]
labels: list[dict[str, str]] = []
current: dict[str, str] | None = None

for raw in (root / "labels.yml").read_text(encoding="utf-8").splitlines():
    line = raw.strip()
    if not line or line.startswith("#"):
        continue
    if line.startswith("- "):
        if current:
            labels.append(current)
        current = {}
        line = line[2:].strip()
    if current is None or ":" not in line:
        raise SystemExit(f"invalid labels.yml line: {raw!r}")
    key, value = line.split(":", 1)
    current[key.strip()] = value.strip().strip('"').strip("'")
if current:
    labels.append(current)

for label in labels:
    if not {"name", "color", "description"} <= label.keys():
        raise SystemExit(f"incomplete label: {label!r}")

if mode == "--dry-run":
    for label in labels:
        print(
            f'gh label create "{label["name"]}" --color "{label["color"]}" '
            f'--description "{label["description"]}" --force'
        )
    print(f"DRY RUN: {len(labels)} labels; no GitHub changes made.")
    raise SystemExit(0)

existing = subprocess.run(
    ["gh", "label", "list", "--limit", "200", "--json", "name"],
    check=True,
    capture_output=True,
    text=True,
).stdout
names = {entry["name"] for entry in __import__("json").loads(existing)}
created = updated = 0
for label in labels:
    if label["name"] in names:
        subprocess.run(
            [
                "gh", "label", "edit", label["name"],
                "--color", label["color"],
                "--description", label["description"],
            ],
            check=True,
        )
        updated += 1
    else:
        subprocess.run(
            [
                "gh", "label", "create", label["name"],
                "--color", label["color"],
                "--description", label["description"],
            ],
            check=True,
        )
        created += 1
print(f"APPLIED: {created} created, {updated} updated.")
PY
