# Architecture

Code Buddy is intentionally simple. Three bash scripts, one config file, markdown output.

## Component Map

```
code-buddy (CLI)
  |
  ├── load_config()     → reads ~/.code-buddy/config.json
  ├── cmd_scan()        → calls portfolio-pulse.sh
  ├── cmd_pulse()       → calls portfolio-pulse.sh --quick
  ├── cmd_status()      → counts repos per folder
  ├── cmd_move()        → mv with cap enforcement + validation
  ├── cmd_ready()       → scores QUEUE repos on 5-point checklist
  ├── cmd_triage()      → lists ACTIVE repos
  ├── cmd_config()      → reads/writes config.json via python3
  └── cmd_hook()        → installs Claude Code session hook

portfolio-pulse.sh (Scanner)
  |
  ├── scan_repo()       → git log + changelog + file mtime per repo
  ├── scan_all()        → walks all portfolio folders
  ├── generate_report() → writes RECENT-ACTIVITY.md
  └── quick_report()    → stdout summary

install.sh (Setup)
  |
  ├── symlinks to ~/bin/
  ├── creates ~/.code-buddy/config.json
  ├── creates folder structure
  └── runs initial scan
```

## Data Flow

```
Portfolio Directory (user's repos)
  → scan_repo() reads git + changelogs
  → generates MANIFEST.md (inventory)
  → generates RECENT-ACTIVITY.md (pulse)
  → Claude Code reads both on session start
```

## Config

Single JSON file at `~/.code-buddy/config.json`:
- `portfolio_dir`: path to repo collection
- `active_cap`: max repos in ACTIVE (default 7)
- `pulse_days`: activity window in days (default 7)
- `folders`: mapping of stage names to directory names

## Dependencies

- bash 4+ (arrays, `[[ ]]` syntax)
- git (commit history scanning)
- python3 (JSON parsing only, inline)
- jq (optional, for JSON output mode)
