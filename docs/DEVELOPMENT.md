# Development

## Setup

```bash
git clone https://github.com/sanchez314c/code-buddy.git
cd code-buddy
chmod +x code-buddy portfolio-pulse.sh install.sh tests/test-cli.sh
```

## Testing

```bash
# Lint
shellcheck code-buddy portfolio-pulse.sh install.sh

# Run tests
./tests/test-cli.sh
```

## Adding a Command

1. Add a new function `cmd_mycommand()` in `code-buddy`
2. Add the case entry in the main `case` block at the bottom
3. Add help text in the `help|*` case
4. Add shellcheck compliance
5. Update README.md with the new command

## Code Style

- 2-space indent
- Local variables: lowercase
- Constants: UPPER_CASE
- Functions: cmd_name() for commands, helper_name() for internal
- Always quote variables: "$var" not $var
- Separate declare and assign: `local x; x=$(cmd)` not `local x=$(cmd)`
