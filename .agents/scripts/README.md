# Agent Scripts

Run scripts from anywhere inside the repository; each script resolves the repository root before executing.

Command, dependency, validation, and failure notes live in `.agents/utilities/python.md` and `.agents/utilities/git.md`.

## Script Groups

- Standard checks: `check.sh`, `validate.sh`, `audit.sh`, `bootstrap.sh`.
- Inspection and setup: `context.sh`, `deps.sh`, `lint.sh`.
- Source modification: `format.sh`.
- Generated-file cleanup: `clean.sh`.

Inspection and setup scripts can create or update generated local state. `deps.sh`, `lint.sh`, `validate.sh`, `audit.sh`, and `check.sh` run through `uv` and may create or refresh `.venv/`, `.cache/uv/`, and `uv.lock`.

`uv sync` and `uv run` may download Python packages from the configured package index; classify network failures separately from project source failures.
