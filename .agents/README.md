# Agent Workspace

This directory contains local multiagent guidance, subagent definitions, utility references, and helper scripts.

## Topic Ownership

- Repository-wide rules: `AGENTS.md`.
- Guidance navigation and search: `.agents/INDEX.md`.
- Shared layout, Python, dependency, generated-file, editor, agent, and documentation conventions: `.agents/CONVENTIONS.md`.
- Git guidance: `.agents/utilities/git.md`.
- Python, uv, pytest, Ruff, coverage, audit, dependency, and validation guidance: `.agents/utilities/python.md`.
- Helper scripts: `.agents/scripts/`.
- Subagents: `.agents/subagents/`.

## Subagents

- `architect`: planning, workflow control, sequencing, boundaries, and handoffs.
- `developer`: focused source, test, tool config, or documentation changes.
- `maintainer`: uv, dependency policy, Ruff, pytest, coverage, audit, and tooling.
- `tester`: local validation, regression checks, and failure reproduction.
- `reviewer`: correctness, maintainability, risks, and missing tests.
- `documenter`: concise human-facing and agent-facing documentation.

Each subagent directory contains:

- `README.md`: human-readable directory description.
- `SKILL.md`: agent-facing workflow, script range, and handoff contract.

## Protected Skill Folders

The caveman skill folders under `.agents/skills/` are not part of the subagent migration. They are local skills and should stay unchanged unless directly requested.

## Vendored Skill Compatibility

Some vendored Caveman skill README files keep upstream-relative links. This directory provides local compatibility targets so those links resolve without editing the protected skill folders.

- `.agents/README.md`: local landing page for `.agents/skills/*` links back to the repository skill area.
- `.agents/agents/`: compatibility notes for Cavecrew role links from the vendored README.
- `.agents/docs/assets/`: compatibility assets referenced by vendored Caveman examples.
