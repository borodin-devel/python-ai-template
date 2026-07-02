#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)

cd "$repo_root"

rm -rf .cache .coverage .mypy_cache .pytest_cache .ruff_cache .venv build dist htmlcov
rm -f coverage.xml
