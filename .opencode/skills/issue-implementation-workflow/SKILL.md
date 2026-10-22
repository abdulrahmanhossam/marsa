---
name: issue-implementation-workflow
description: Use when starting, implementing, or closing a Marsa backlog issue from docs/backlog/issues, including dependencies, acceptance criteria, tests, commits, and evidence.
---

# Issue implementation workflow

## 1. Load the issue

- Read the owner-provided private handoff if available, `AGENTS.md`, and the issue.
- Read every `depends_on` issue.
- Read the requirement IDs and roadmap stories in the frontmatter.
- Read the ADRs and design sections the issue names.
- Do not start a blocked issue or one whose milestone is not current.

## 2. Plan

Write:

- Goal in one sentence.
- Acceptance evidence.
- Files likely to change.
- Invariant most at risk.
- Tests to add.
- Explicit out-of-scope items.

If the issue is `size/xl`, confirm the slice is testable. Split only by vertical behavior, never by layer.

## 3. Implement

- Branch: `feat/<issue-slug>` or `fix/<issue-slug>`.
- Keep the change limited to the issue.
- Make state changes atomic and steps idempotent.
- Add a test for the failure path.
- Do not change canonical names, approved requirements, or public contracts silently.
- Do not push, create issues, or open a PR.

## 4. Verify

Run the narrowest relevant checks first, then the full relevant suite:

```bash
dotnet build Marsa.sln -warnaserror
dotnet test <relevant test project>
python3 scripts/check-docs.py
python3 scripts/validate-backlog.py
./scripts/create-issues.sh --dry-run
```

Record exact commands and results. A skipped test is not a pass.

## 5. Close the loop

- Update the issue draft if behavior changed.
- Update `docs/07-risks-and-open-questions.md` for a new decision.
- Update coverage if the requirement map changed.
- Write the beginner Arabic explanation at `.local/learn/NNN-<issue-or-topic>.ar.md` before calling the work done.
- Update the owner's private progress log and handoff at a phase boundary; never commit them.
- Commit with `type(scope): summary`; reference the issue slug and requirement IDs.
- Report: changed, verified, risks, next, and the explanation file.
- Print a two-line status for phase work, then continue unless blocked.

## 6. Refuse to fake

Never:

- Claim a command ran when it did not.
- Hide a flaky or skipped test.
- Add a temporary insecure default.
- Weaken the Docker/Caddy/secret/tenant boundary to make a test pass.
- Mark an acceptance criterion done without evidence.
