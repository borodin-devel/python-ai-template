#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)

cd "$repo_root"

export UV_CACHE_DIR="${UV_CACHE_DIR:-$repo_root/.cache/uv}"

uv run ruff format src tests examples
uv run ruff check --fix src tests examples
