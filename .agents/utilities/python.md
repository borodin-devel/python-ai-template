# Python Utility

Use this file for Python, uv, pytest, Hypothesis, Ruff, coverage, audit, dependency, validation, and local failure guidance.

## Package

- Distribution name: `python-ai-template`.
- Import package: `python_ai_template`.
- Runtime source: `src/python_ai_template/`.
- Tests: `tests/`.
- Examples: `examples/`.
- Supported Python versions: 3.11 and 3.12 through `requires-python = ">=3.11,<3.13"`.

## uv

Create or refresh the local environment:

```sh
uv sync --all-groups
```

Run commands inside the uv environment:

```sh
uv run python --version
uv run pytest
uv run ruff check src tests examples
```

Use a specific supported Python version when needed:

```sh
uv sync --python 3.11 --all-groups
uv sync --python 3.12 --all-groups
```

## Tools

- `pytest`: unit and integration tests.
- `hypothesis`: property-based tests.
- `pytest-cov`: coverage reporting.
- `ruff`: formatting, import sorting, and linting.
- `pylance`: VS Code type analysis.
- `pip-audit`: dependency vulnerability audit.

## Commands

Bootstrap environment and run all checks:

```sh
.agents/scripts/bootstrap.sh
```

Run standard checks:

```sh
.agents/scripts/check.sh
```

Format and fix lint:

```sh
.agents/scripts/format.sh
```

Run tests with coverage:

```sh
.agents/scripts/validate.sh
```

Run dependency audit:

```sh
.agents/scripts/audit.sh
```

Inspect tool versions and environment:

```sh
.agents/scripts/deps.sh
```

## Validation Levels

- Syntax: Markdown, JSON, TOML, or static file structure checks.
- Format: `ruff format --check src tests examples`.
- Lint: `ruff check src tests examples`.
- Test: `pytest` with coverage.
- Audit: `pip-audit` against the local uv environment.
- Version matrix: repeat `uv sync --python 3.11 --all-groups && uv run pytest` and `uv sync --python 3.12 --all-groups && uv run pytest` when compatibility is changed.

Start with the smallest validation that proves the change. Broaden when changes touch package behavior, dependencies, tool config, tests, or Python-version compatibility.

## Failure Classification

- Missing `uv`, Python 3.11, Python 3.12, Ruff, pytest, Hypothesis, pytest-cov, or pip-audit: environment issue unless `pyproject.toml` omits it.
- `uv sync` download failure: network or package index issue.
- `UV_CACHE_DIR` defaults to `.cache/uv` in helper scripts so sandboxed agents do not need write access to a home-directory cache.
- `audit.sh` passes `--cache-dir .cache/pip-audit` for the same reason.
- `uv lock` resolution failure: dependency constraint issue.
- Ruff format or lint failure: project style issue.
- Pytest failure under `tests/`: project source or test issue.
- Coverage failure: test coverage or coverage config issue.
- pip-audit vulnerability: dependency security issue; update or justify the dependency.
- No tests discovered: check `tests/`, `pyproject.toml`, and pytest config.
