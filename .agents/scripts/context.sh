#!/bin/sh

set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)

cd "$repo_root"

print_tracked() {
  title=$1
  shift

  printf '\n## %s\n\n' "$title"
  git ls-files --cached --others --exclude-standard "$@" |
    while IFS= read -r path; do
      if [ -e "$path" ]; then
        printf -- '- %s\n' "$path"
      fi
    done
}

printf '# Repository Context\n'
printf '\nRoot: `%s`\n' "$repo_root"

printf '\n## Python Toolchain\n\n'
uv --version | sed 's/^/    /'
python3 --version | sed 's/^/    /'

print_tracked "Project Entry Points" \
  README.md \
  AGENTS.md \
  pyproject.toml

print_tracked "Python Package" 'src/*.py' 'src/**/*.py'
print_tracked "Examples" 'examples/*.py' 'examples/**/*.py'
print_tracked "Tests" 'tests/*.py' 'tests/**/*.py'
print_tracked "Agent Guidance" \
  .agents/README.md \
  .agents/INDEX.md \
  .agents/CONVENTIONS.md \
  .agents/utilities/git.md \
  .agents/utilities/python.md
print_tracked "Subagents" '.agents/subagents/*/README.md' '.agents/subagents/*/SKILL.md'
print_tracked "Local Skills" '.agents/skills/*/README.md' '.agents/skills/*/SKILL.md'
print_tracked "Agent Scripts" '.agents/scripts/*.sh' '.agents/scripts/README.md'
print_tracked "Codex Guidance" '.codex/*.md'
print_tracked "VS Code Workspace" '.vscode/*'

printf '\n## Ignored Generated Paths\n\n'
printf -- '- `.venv/`\n'
printf -- '- `.cache/`\n'
printf -- '- `.pytest_cache/`\n'
printf -- '- `.ruff_cache/`\n'
printf -- '- `.coverage`\n'
printf -- '- `coverage.xml`\n'
printf -- '- `htmlcov/`\n'
printf -- '- `dist/`\n'
printf -- '- `build/`\n'
