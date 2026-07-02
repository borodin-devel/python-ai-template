# python-ai-template

Python 3.11/3.12 project template for local, token-efficient AI-assisted development.

The template keeps environment, tests, formatting, linting, coverage, audit, and editor behavior in repository files so humans and agents can inspect local sources instead of relying on repeated prompt context.

## Requirements

- Python 3.11 or 3.12
- uv
- VS Code with recommended extensions from `.vscode/extensions.json`

## Quick Start

Create the local uv environment and install dev tools:

```sh
uv sync --all-groups
```

Run the example module:

```sh
uv run python examples/print_version.py
```

Run tests with coverage:

```sh
uv run pytest
```

Run formatting, linting, tests, coverage, and dependency audit:

```sh
.agents/scripts/check.sh
```

Format and auto-fix Python files:

```sh
.agents/scripts/format.sh
```

Check Python 3.11 or 3.12 explicitly when both are installed:

```sh
uv sync --python 3.11 --all-groups
uv run pytest
uv sync --python 3.12 --all-groups
uv run pytest
```

## Layout

See `.agents/INDEX.md` for repository guidance navigation and `.agents/CONVENTIONS.md` for repository structure, names, Python conventions, and style.

## Tooling

- `uv`: environment, dependency groups, locking, command execution.
- `pytest`: test runner.
- `hypothesis`: property-based tests.
- `pytest-cov`: coverage reporting.
- `ruff`: formatting, import sorting, and linting.
- `pylance`: VS Code type analysis.
- `pip-audit`: dependency vulnerability audit.

Configuration lives in `pyproject.toml`.

## AI-Assisted Workflow

AI-agent and editor boundaries are defined in `.agents/CONVENTIONS.md`. Subagent definitions live in `.agents/subagents/`.

### AI Tool Setup

This repo is set up to use three optional AI helpers:

- Serena: semantic code navigation and symbolic editing tools.
- CocoIndex: codebase indexing and natural-language code search.
- Caveman: token-efficient skills for terse answers, reviews, commits, compression, and subagent delegation.

#### Install Serena And CocoIndex

Install the MCP servers with UV:

```sh
uv tool install serena-agent
uv tool install cocoindex-code
```

Verify the installed entrypoints:

```sh
serena --version
cocoindex-code --help
```

The checked-in Codex config uses the `serena`, `serena-hooks`, and `cocoindex-code` entrypoints from `PATH` plus repository-relative runtime paths. If Codex cannot find those commands, fix your shell `PATH` or add a local user config override instead of committing machine-specific absolute paths. Inspect the UV tool locations with:

```sh
uv tool dir
```

#### Install Caveman Skills

This repository expects Caveman skills under `.agents/skills/`. The checked-in `skills-lock.json` records the expected source as `JuliusBrussee/caveman`.

For Codex, install repo-scoped skills by copying the Caveman skill folders into `.agents/skills/`:

```sh
mkdir -p .agents/skills
caveman_tmp=$(mktemp -d)
git clone --depth 1 https://github.com/JuliusBrussee/caveman.git "$caveman_tmp"
cp -R "$caveman_tmp"/skills/cavecrew .agents/skills/
cp -R "$caveman_tmp"/skills/caveman* .agents/skills/
```

Restart Codex if new or updated skills do not appear. For a Codex-agnostic agent, point the agent at the same `SKILL.md` files or use that agent's own skill/plugin install mechanism.

#### Codex-Specific Startup

The project wiring lives in `.codex/config.toml` and is intentionally portable across clone locations.

- Serena starts as `serena start-mcp-server --context codex --project-from-cwd`.
- CocoIndex starts as `cocoindex-code serve`.
- `COCOINDEX_CODE_DIR` points at `.cocoindex_code/`.
- Serena hooks remind Codex to activate the project and use symbolic tools before broad file reads.

From the repository root, check MCP status:

```sh
codex mcp list
```

Expected: `serena` and `cocoindex` are listed as enabled for this trusted project. Restart the Codex session after changing MCP config.

At the start of a Codex session, use a prompt like:

```text
Activate this project with Serena, read Serena initial instructions, use CocoIndex for broad code search when useful, and use Caveman skills for token-efficient output when I ask for caveman mode or cavecrew.
```

To explicitly trigger all three helpers in one task:

```text
Use Serena to navigate Python symbols, use CocoIndex to search for relevant implementation areas, and use $caveman lite for a concise answer. Start by checking .agents/INDEX.md.
```

Codex can also activate skills explicitly through `/skills` or by mentioning a skill with `$`, such as `$caveman`, `$cavecrew`, `$caveman-review`, or `$caveman-commit`.

Useful Codex checks:

```text
/mcp
/skills
/status
/statusline
```

- `/mcp`: inspect connected MCP servers.
- `/skills`: browse available skills.
- `/status`: show thread ID, model/configuration details, token usage, and remaining context capacity.
- `/statusline`: configure footer fields such as context remaining.

#### Codex-Agnostic Startup

For any MCP-capable agent, configure equivalent MCP servers:

```sh
SERENA_HOME="$PWD/.serena" serena start-mcp-server --context codex --project-from-cwd
COCOINDEX_CODE_DIR="$PWD/.cocoindex_code" cocoindex-code serve
```

If the client has its own Serena context name, replace `--context codex` with that client context.

Then ask the agent to:

```text
Use the Serena MCP server for semantic Python navigation and symbolic edits. Activate this repository path and read Serena's initial instructions before broad exploration. Use the CocoIndex MCP server for natural-language codebase search. Load repo skills from .agents/skills when a task matches their SKILL.md descriptions.
```

If the client cannot use MCP, use the command-line fallbacks below and paste relevant output into the agent:

```sh
.agents/scripts/context.sh
rg "search term" README.md AGENTS.md .agents .codex pyproject.toml src tests examples
cocoindex-code index
```

#### Indexing And Reactivation

CocoIndex keeps local runtime and index files in `.cocoindex_code/`, which is ignored by Git. To prebuild or refresh the local index outside Codex:

```sh
cocoindex-code index
```

Serena keeps local hook/session state in `.serena/`, also ignored by Git.

Reactivation rules:

- New Codex session: check `/mcp`; Serena and CocoIndex should start from `.codex/config.toml`.
- New or resumed thread: ask Codex to activate the Serena project and read Serena initial instructions before broad exploration.
- Changed `.codex/config.toml`, installed tools, or skill folders: restart Codex.
- Changed source files only: no Serena reinstallation is needed; use Serena normally and refresh CocoIndex with `cocoindex-code index` when search results feel stale.
- Changed Caveman skills: restart Codex if `/skills` does not show the change.

#### Prompt Patterns

Good activation prompt:

```text
Before editing, read README.md, .agents/INDEX.md, and .agents/CONVENTIONS.md. Activate Serena for this project, read its initial instructions, use Serena for Python symbol navigation, use CocoIndex for broad code search, and keep the answer concise.
```

Good code search prompt:

```text
Use CocoIndex to find where version information is defined and tested. Then use Serena to inspect the relevant symbols before suggesting changes.
```

Good Caveman prompt:

```text
Use $caveman lite. Summarize the diff and validation results in concise technical prose.
```

Good cavecrew prompt:

```text
Use $cavecrew. Spawn an investigator for call sites, then a reviewer for the final diff if delegation is useful.
```

Good context-window check:

```text
/status
```

In Codex CLI, `/status` is the quickest way to inspect remaining context capacity. Configure `/statusline` if you want context remaining visible in the footer during long sessions.

For non-Codex clients, use the client's token, context, or session-status command. If no such command exists, keep prompts scoped and use `.agents/scripts/context.sh` plus targeted file mentions instead of pasting large logs or whole files.
