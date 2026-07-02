# VS Code Workspace Files

This directory contains editor defaults for the Python template. The files are intended to be portable across machines and focused on uv, Python, Pylance, Ruff, pytest, coverage, audit, and pure Git workflows.

## Files

- `extensions.json`: recommended VS Code extensions for this workspace.
- `settings.json`: workspace settings for Python, Pylance, Ruff, pytest, formatting, and Git.
- `tasks.json`: uv, pytest, Ruff, audit, and script-backed maintenance tasks.
- `launch.json`: debugger launch configurations for the package CLI and current Python file.

## Convention

Do not change these files based only on the extensions installed on one local machine. Treat them as template defaults. If a setting depends on a recommended extension, keep that dependency explicit in `extensions.json`.
