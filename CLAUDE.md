# CLAUDE.md - Code Buddy

## Project Overview
Code Buddy is a pure bash CLI tool for portfolio management. 540 LOC across 3 scripts. No build system, no dependencies beyond bash 4+, git, and python3.

## Tech Stack
- **Language:** Bash (primary), Python 3 (inline for JSON parsing)
- **Config:** JSON via python3 -c
- **Output:** Markdown files
- **Testing:** shellcheck for linting, manual testing for functionality

## File Map
- `code-buddy` - Main CLI entry point (309 LOC). All commands in a case statement.
- `portfolio-pulse.sh` - Activity scanner (162 LOC). Scans git and changelogs.
- `install.sh` - Setup script (69 LOC). Symlinks, config creation, initial scan.

## Development Rules
- Keep everything in bash. No rewrites to other languages.
- Python only for JSON parsing (inline heredocs, not separate files)
- Test with: `shellcheck code-buddy portfolio-pulse.sh install.sh`
- No node_modules, no package.json, no build step
- All paths must work on both Linux and macOS
- Use `date -d` with `date -v` fallback for macOS compatibility

## Common Tasks
- Add a command: new case in the main `case` statement in `code-buddy`
- Add a config option: update `load_config()` and the default JSON in `config set`
- Change scan behavior: edit `scan_repo()` in `portfolio-pulse.sh`
