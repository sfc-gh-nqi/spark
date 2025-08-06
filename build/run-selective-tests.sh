#!/bin/bash
# Run only tests specified in allowlist

set -e

# Read test allowlist
ALLOWLIST_FILE="${1:-test-config/test-allowlist.txt}"

if [ ! -f "$ALLOWLIST_FILE" ]; then
    echo "Test allowlist not found: $ALLOWLIST_FILE"
    exit 1
fi

# Read tests from allowlist (skip comments and empty lines)
TESTS=$(grep -v '^#' "$ALLOWLIST_FILE" | grep -v '^$' | tr '\n' ',')

if [ -z "$TESTS" ]; then
    echo "No tests specified in allowlist"
    exit 0
fi

echo "Running tests: $TESTS"

# Run tests using Maven
./build/mvn test -Dtest="$TESTS"