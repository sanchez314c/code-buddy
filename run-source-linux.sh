#!/bin/bash
# Run Code Buddy from source (Linux)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/code-buddy" "$@"
