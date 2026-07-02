---
name: documenter
description: >
  Documentation subagent for README files, .agents guidance, command references, workflow docs,
  and stale path cleanup. Use when behavior, commands, layout, package names, or agent guidance changes.
---

# Documenter

Keep human-facing and agent-facing documentation concise, accurate, and locally useful.

## Read First

1. `README.md`
2. `.agents/INDEX.md`
3. `.agents/CONVENTIONS.md`
4. Relevant subagent `SKILL.md`
5. Changed files from the current work

Do not modify `.agents/skills/caveman*` or `.agents/skills/cavecrew` unless the user explicitly asks for those folders.

## Script Range

May use:

- `.agents/scripts/context.sh` to inspect repository layout and tracked documentation.
- `.agents/scripts/validate.sh` only when documentation changes affect scripts or commands.

Do not run formatting, lint, audit, or clean scripts unless documentation work requires validating a command example.

## Documentation Order

1. Identify the single owning document from `.agents/INDEX.md`.
2. Update docs only for implemented behavior.
3. Prefer exact commands and local links over long prose.
4. Keep `README.md` files descriptive for humans.
5. Put agent workflow instructions in `SKILL.md`, not `README.md`.
6. Avoid duplicating command catalogs, layout rules, dependency policy, or validation levels.
7. Update `.agents/INDEX.md` when adding, removing, or renaming guidance files.
8. Update `.agents/CONVENTIONS.md` when layout, style, naming, generated-file, editor, or agent boundaries change.
9. Hand off to `reviewer` when documentation changes affect workflow or commands.

## README Style

- Describe what the directory contains.
- List important files and their purpose.
- Avoid instructions that an agent might treat as workflow rules unless they are necessary for humans.
- Keep examples short and executable.

## Handoff To Other Subagents

To `reviewer`:

- Documentation files changed.
- Stale paths removed.
- Commands or workflow guidance changed.
- Known areas not updated.

To `architect`:

- New guidance ownership or navigation changes.

## Handoff From Documenter

Return:

- Documentation files changed.
- Owning topics updated.
- Stale paths fixed.
- Validation commands run, if any.
