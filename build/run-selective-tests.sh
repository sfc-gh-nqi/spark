#!/bin/bash
# Run selective tests based on allowlist file
set -e

ALLOWLIST_FILE="${1:-test-config/test-allowlist.txt}"

if [ ! -f "$ALLOWLIST_FILE" ]; then
    echo "Warning: Test allowlist not found: $ALLOWLIST_FILE"
    echo "No tests to run."
    exit 0
fi

echo "Reading tests from: $ALLOWLIST_FILE"

# Read test classes from file
TESTS=""
while IFS= read -r line; do
    if [[ ! "$line" =~ ^[[:space:]]*# ]] && [[ -n "${line// }" ]]; then
        if [ -z "$TESTS" ]; then
            TESTS="$line"
        else
            TESTS="$TESTS,$line"
        fi
    fi
done < "$ALLOWLIST_FILE"

if [ -z "$TESTS" ]; then
    echo "No tests specified in allowlist."
    exit 0
fi

echo "Running tests: $TESTS"

./build/mvn test \
    -Dtest="$TESTS" \
    -DwildcardSuites="$TESTS" \
    -DfailIfNoTests=false
