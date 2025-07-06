# Contributing to Code Buddy

Thanks for your interest in contributing. Code Buddy is a simple bash tool and contributions should stay that way.

## Development Setup

```bash
git clone https://github.com/sanchez314c/code-buddy.git
cd code-buddy
chmod +x code-buddy portfolio-pulse.sh install.sh
```

No build step. No dependencies to install. It's bash.

## How to Contribute

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/my-thing`)
3. Make your changes
4. Run shellcheck: `shellcheck code-buddy portfolio-pulse.sh install.sh`
5. Test manually: `./code-buddy status`, `./code-buddy pulse`, etc.
6. Commit with a clear message
7. Open a PR

## Guidelines

- Keep it bash. No rewriting in Python/Node/Go.
- No external dependencies beyond bash 4+, git, python3, jq
- Every new command needs a help entry in the main case statement
- Test on both Linux and macOS if possible
- Follow existing code style (2-space indent, lowercase variables for locals, UPPER for constants)

## Reporting Issues

Use GitHub Issues. Include your OS, bash version (`bash --version`), and the exact command that failed.
