# Git Utility

Use this file for Git inspection, diff review, and safety rules.

## Inspect State

```sh
git status --short
git diff
git diff --staged
```

Use ignored-file inspection when generated files are relevant:

```sh
git status --ignored --short
```

## Safety Rules

- Keep changes scoped to the requested behavior.
- Respect existing uncommitted user changes.
- Do not restore deleted files unless the user explicitly asks.
- Do not rewrite unrelated local changes.
- Do not commit generated build outputs or local runtime state.
- Do not use destructive commands such as `git reset --hard` or `git checkout --` unless explicitly requested.
- Prefer focused commits that describe one logical change when the user asks to commit.

## Diff Review

Review diffs by behavior area:

- Source and tests: correctness, regression risk, test coverage.
- Python tooling and dependencies: uv lock state, Python version bounds, Ruff, pytest, coverage, pip-audit, generated files.
- Documentation and agents: stale paths, duplicated rules, instruction conflicts.

For code review output, use `.agents/subagents/reviewer/SKILL.md`.
