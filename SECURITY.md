# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.0.x   | Yes       |

## Reporting a Vulnerability

Code Buddy runs locally and doesn't make network calls, but if you find a security issue (command injection, path traversal, etc.):

1. Do NOT open a public GitHub issue
2. Email: jason@jasonpaulmichaels.co
3. Include: description, reproduction steps, and potential impact
4. You'll get a response within 48 hours

## Scope

Code Buddy executes shell commands based on user configuration. The main risk surface is:
- Config file parsing (`config.json`)
- Repo path handling (user-supplied paths)
- Git command execution within scanned repos
