#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)

cd "$repo_root"

export UV_CACHE_DIR="${UV_CACHE_DIR:-$repo_root/.cache/uv}"

printf '%s\n' "Toolchain:"
uv --version
python3 --version

printf '\n%s\n' "Configured Python:"
uv run python --version

printf '\n%s\n' "Dev tools:"
uv run pytest --version
uv run ruff --version
uv run pip-audit --version

printf '\n%s\n' "Installed packages:"
uv pip list
