# Tech Stack

| Component | Technology | Purpose |
|-----------|-----------|---------|
| CLI | Bash 4+ | All commands and logic |
| JSON Parsing | Python 3 (inline) | Config read/write |
| Activity Scanning | git log | Commit history |
| Activity Scanning | grep/awk | Changelog parsing |
| File Detection | find | Source file modification times |
| Output | Markdown | MANIFEST.md, RECENT-ACTIVITY.md |
| CI | GitHub Actions | shellcheck + basic tests |
| Linting | shellcheck | Bash static analysis |

## Why Bash?

- Zero dependencies to install
- Works on every Linux and macOS system out of the box
- The tool manages repos, which already require git and a shell
- Python is only used inline for JSON parsing (no separate files)
- Keeps the project trivially simple to contribute to
