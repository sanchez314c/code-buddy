#!/bin/bash
# Basic CLI tests for Code Buddy
PASS=0
FAIL=0
CB="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/code-buddy"

assert_exit() {
  local desc="$1" expected="$2"
  shift 2
  "$@" > /dev/null 2>&1
  local got=$?
  if [ "$got" -eq "$expected" ]; then
    echo "PASS: $desc"
    PASS=$((PASS+1))
  else
    echo "FAIL: $desc (expected exit $expected, got $got)"
    FAIL=$((FAIL+1))
  fi
}

assert_output() {
  local desc="$1" pattern="$2"
  shift 2
  local out
  out=$("$@" 2>&1)
  if echo "$out" | grep -q "$pattern"; then
    echo "PASS: $desc"
    PASS=$((PASS+1))
  else
    echo "FAIL: $desc (expected '$pattern' in output)"
    FAIL=$((FAIL+1))
  fi
}

echo "=== Code Buddy CLI Tests ==="
echo ""

# Version
assert_output "version command" "code-buddy" "$CB" version

# Help
assert_output "help command" "Commands" "$CB" help

# Status without config (should warn but not crash)
assert_output "status without config handles gracefully" "Portfolio\|not set" "$CB" status

# Config show
assert_exit "config show runs" 0 "$CB" config show

# Unknown command
assert_output "unknown command shows help" "Commands" "$CB" nonexistent

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
[ "$FAIL" -eq 0 ] && exit 0 || exit 1
