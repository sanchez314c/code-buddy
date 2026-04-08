# Build & Compile

Code Buddy has no build step. It's interpreted bash.

## Running from Source

```bash
./code-buddy status
```

Or via the run-source scripts:
```bash
./run-source-linux.sh status
./run-source-mac.sh status
```

## Testing

```bash
shellcheck code-buddy portfolio-pulse.sh install.sh
./tests/test-cli.sh
```

## CI

GitHub Actions runs shellcheck and basic tests on every push to main. See `.github/workflows/ci.yml`.
