#!/usr/bin/env bash
# Create backlog issues from docs/backlog/issues/*.md. Dry-run is the default.
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
import json
import re
import subprocess
import sys
from pathlib import Path

root = Path(sys.argv[1])
mode = sys.argv[2]
issues_dir = root / "docs" / "backlog" / "issues"
MILESTONES = {
    "M0": ("M0 — Foundation", "Buildable skeleton, local stack, health, images."),
    "M1": ("M1 — Setup and identity", "Setup, login, roles, PATs, preflight, API contract."),
    "M2": ("M2 — Projects, detect, and build", "Projects, sources, detection, build, images."),
    "M3": ("M3 — Deploy and observe", "Runtime, orchestration, logs, realtime."),
    "M4": ("M4 — Route and secure", "Caddy, domains, TLS, secrets, audit."),
    "M5": ("M5 — Operate and recover", "Rollback, CLI, dashboard, Arabic, diagnostics."),
    "M6": ("M6 — Release candidate", "Install, upgrade, backup, E2E, supply chain."),
}
KNOWN_LABELS = set()
for line in (root / "labels.yml").read_text(encoding="utf-8").splitlines():
    match = re.match(r'\s*- name:\s*"?([^"]+)"?', line)
    if match:
        KNOWN_LABELS.add(match.group(1).strip())


def parse_value(value: str):
    value = value.strip()
    if value.startswith("[") and value.endswith("]"):
        inner = value[1:-1].strip()
        if not inner:
            return []
        return [part.strip().strip('"').strip("'") for part in inner.split(",")]
    return value.strip('"').strip("'")


def parse_issue(path: Path) -> dict:
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        raise SystemExit(f"{path}: missing frontmatter")
    try:
        _, frontmatter, body = text.split("---", 2)
    except ValueError as exc:
        raise SystemExit(f"{path}: malformed frontmatter") from exc
    data: dict = {"body": body.lstrip("\n"), "path": path}
    for line in frontmatter.strip().splitlines():
        if not line.strip() or line.lstrip().startswith("#"):
            continue
        if ":" not in line:
            raise SystemExit(f"{path}: bad frontmatter line {line!r}")
        key, value = line.split(":", 1)
        data[key.strip()] = parse_value(value)
    for required in ("title", "labels", "milestone", "epic", "size", "depends_on", "requirements", "stories"):
        if required not in data:
            raise SystemExit(f"{path}: missing {required}")
    if data["milestone"] not in MILESTONES:
        raise SystemExit(f"{path}: unknown milestone {data['milestone']}")
    unknown = [label for label in data["labels"] if label not in KNOWN_LABELS]
    if unknown:
        raise SystemExit(f"{path}: unknown labels {unknown}")
    return data


issues = [parse_issue(path) for path in sorted(issues_dir.glob("*.md"))]
issues.sort(key=lambda issue: int(issue.get("order", "0")))

if mode == "--dry-run":
    for issue in issues:
        label_args = " ".join(f'--label "{label}"' for label in issue["labels"])
        milestone = MILESTONES[issue["milestone"]][0]
        print(
            f'gh issue create --title "{issue["title"]}" '
            f'{label_args} --milestone "{milestone}"'
        )
        print(f'  # body: {issue["path"].relative_to(root)} (frontmatter stripped)')
        if issue["depends_on"]:
            print(f'  # depends_on: {", ".join(issue["depends_on"])}')
    print(f"DRY RUN: {len(issues)} issues; no GitHub changes made.")
    raise SystemExit(0)

repo = subprocess.run(
    ["gh", "repo", "view", "--json", "nameWithOwner", "-q", ".nameWithOwner"],
    check=True, capture_output=True, text=True,
).stdout.strip()

def gh_json(*args: str):
    return json.loads(subprocess.run(["gh", *args], check=True, capture_output=True, text=True).stdout)

milestones = {m["title"]: m["number"] for m in gh_json("api", f"repos/{repo}/milestones?state=all&per_page=100")}
for key, (title, description) in MILESTONES.items():
    if title not in milestones:
        created = gh_json(
            "api", "-X", "POST", f"repos/{repo}/milestones",
            "-f", f"title={title}", "-f", f"description={description}", "-f", "state=open",
        )
        milestones[title] = created["number"]
        print(f"created milestone: {title}")

existing = gh_json("issue", "list", "--state", "all", "--limit", "1000", "--json", "number,title")
by_title = {item["title"]: item["number"] for item in existing}
numbers: dict[str, int] = {}

for issue in issues:
    if issue["title"] in by_title:
        numbers[issue["path"].stem] = by_title[issue["title"]]
        print(f"exists: {issue['title']} (#{by_title[issue['title']]})")
        continue
    args = [
        "issue", "create",
        "--title", issue["title"],
        "--body-file", "-",
        "--milestone", MILESTONES[issue["milestone"]][0],
    ]
    for label in issue["labels"]:
        args += ["--label", label]
    output = subprocess.run(
        ["gh", *args], check=True, capture_output=True, text=True, input=issue["body"]
    ).stdout.strip()
    number = int(output.rsplit("/", 1)[-1])
    numbers[issue["path"].stem] = number
    print(f"created: {issue['title']} (#{number})")

for issue in issues:
    if not issue["depends_on"]:
        continue
    number = numbers.get(issue["path"].stem)
    if number is None:
        continue
    links = []
    for dependency in issue["depends_on"]:
        dep_number = numbers.get(dependency)
        if dep_number is None:
            print(f"warning: {issue['path'].stem} depends on unknown issue {dependency}", file=sys.stderr)
            continue
        links.append(f"- Blocked by #{dep_number} (`{dependency}`)")
    if not links:
        continue
    body = issue["body"]
    block = "\n".join(links) + "\n"
    if "<!-- dependency-links -->" in body:
        body = re.sub(
            r"<!-- dependency-links -->.*?(?=\n## Out of scope)",
            block,
            body,
            flags=re.DOTALL,
        )
    else:
        body = body.rstrip() + "\n\n## Dependencies\n\n" + block
    subprocess.run(
        ["gh", "issue", "edit", str(number), "--body-file", "-"],
        check=True, capture_output=True, text=True, input=body,
    )

print(f"APPLIED: {len(numbers)} issues available; dependency links updated.")
PY
