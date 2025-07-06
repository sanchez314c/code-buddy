# Changelog

All notable changes to Code Buddy will be documented in this file.

## [1.0.0] - 2026-04-07

### Added
- Initial release
- CLI commands: scan, pulse, status, move, ready, triage, config, hook
- Portfolio folder workflow: ICEBOX, WORKBENCH, ACTIVE (capped), QUEUE, SHIPPED
- Activity scanning via git log and changelog.md parsing
- ACTIVE folder hard cap with enforcement on `move` command
- Claude Code session hook integration
- Configurable portfolio directory, active cap, and pulse window
- MANIFEST.md and RECENT-ACTIVITY.md generation
- Pipeline readiness scoring for QUEUE repos (5-point checklist)
