#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)

cd "$repo_root"

.agents/scripts/lint.sh
.agents/scripts/validate.sh
.agents/scripts/audit.sh
