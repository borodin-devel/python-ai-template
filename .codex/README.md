# Codex Rules

This file is the only Codex-specific Markdown file. Keep tool-neutral project rules in `AGENTS.md` or `.agents/`, and keep callable-program rules in `.agents/utilities/`.

## MCP Configuration

- Codex MCP configuration lives in `.codex/config.toml`.
- Serena is configured for semantic code navigation and symbolic editing.
- CocoIndex is configured for codebase indexing and natural-language code search.

## Codex Workflow

- Follow `AGENTS.md` for repository-wide agent rules and reading order.
- Prefer focused local files and targeted `rg` searches before broad context requests.
- Use Serena and CocoIndex when available; fall back to local files and `rg` when they are unavailable.
- Mention MCP limitations in final responses only when they affect confidence.
