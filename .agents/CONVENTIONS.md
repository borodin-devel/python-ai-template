# Agent Conventions

This file owns shared repository conventions. Link here instead of repeating these rules elsewhere.

## Project Layout

- Python package code lives in `src/python_ai_template/`.
- Example programs live in `examples/`.
- Pytest tests live in `tests/` and use the `test_*.py` suffix.
- Python packaging and tool configuration lives in `pyproject.toml`.
- Local multiagent guidance lives in `.agents/`.
- Codex-specific configuration lives in `.codex/`.
- Portable VS Code workspace defaults live in `.vscode/`.

## Names

- Distribution name: `python-ai-template`.
- Import package: `python_ai_template`.
- Python modules: `src/python_ai_template/*.py`.
- Tests: `tests/test_*.py`.
- Examples: `examples/*.py`.

## Python Style

Use `pyproject.toml` as source of truth for Ruff, pytest, coverage, and dependency groups.

To inspect current style and test config:

```sh
sed -n '1,260p' pyproject.toml
```

Current Python style:

- Python 3.11 and 3.12.
- Ruff formatting and linting.
- 4-space Python indentation.
- 100-column line length.
- Import sorting through Ruff.
- `snake_case` modules, functions, variables, and test names.
- `PascalCase` classes and exceptions.
- `UP`, `B`, `C4`, `E`, `F`, `I`, `PT`, `RUF`, and `SIM` Ruff rule families enabled.

Format changed Python files through:

```sh
.agents/scripts/format.sh
```

Run static analysis through:

```sh
.agents/scripts/lint.sh
```

## Comments

- Prefer clear code and names over explanatory comments.
- Add comments for non-obvious rationale, invariants, ownership, lifetimes, platform constraints, or dependency behavior.
- Do not write comments that restate the next line of code.
- Keep public API comments concise and behavior-focused.
- Keep Markdown comments out of generated examples unless they are part of the example.

## Python Tooling

- Use `uv` for dependency resolution, virtualenv management, locking, and command execution.
- Keep runtime dependencies in `[project.dependencies]`.
- Keep dev tools in `[dependency-groups].dev`.
- Use `pytest` for tests and `Hypothesis` for property-based tests.
- Use `pytest-cov` for coverage.
- Use `ruff` for formatting, import sorting, and linting.
- Use `pip-audit` for dependency vulnerability checks.

Detailed command and failure guidance lives in `.agents/utilities/python.md`.

## Dependencies

- Dependency policy lives in `pyproject.toml` and `uv.lock`.
- Do not change Python version bounds or dependency constraints unless the task explicitly requires a dependency-policy change.
- Use `.agents/scripts/deps.sh` to inspect uv, Python, and installed tool versions.

## Generated And Local Files

- Do not commit generated files or local runtime state.
- Ignored generated paths include `.venv/`, `.cache/`, `.pytest_cache/`, `.ruff_cache/`, `.coverage`, `coverage.xml`, `htmlcov/`, `dist/`, `build/`, `.serena/`, and `.cocoindex_code/`.
- Use `.agents/scripts/clean.sh` to remove common generated local files only when cleanup is requested or needed.

## Documentation

- Keep documentation concise and operational.
- Prefer exact commands and local file links over long prose.
- Document implemented behavior only.
- Do not duplicate command catalogs, layout rules, dependency policy, or validation levels.
- `README.md` files describe directory contents for humans. Put agent workflow instructions in `SKILL.md`.

## Agent And Editor Boundaries

- Tool-neutral AI-agent behavior belongs in `AGENTS.md` and `.agents/`.
- Subagent behavior belongs under `.agents/subagents/<name>/SKILL.md`.
- Helper-script behavior belongs in `.agents/scripts/README.md` and the scripts themselves.
- Codex-specific Markdown belongs in `.codex/README.md`; Codex MCP configuration remains in `.codex/config.toml`.
- `.vscode/` is limited to portable editor defaults and recommendations.
- Do not modify repository files based only on extensions or settings installed on one local machine.
- Do not modify `.agents/skills/caveman*` or `.agents/skills/cavecrew` unless the user explicitly asks for those folders.
