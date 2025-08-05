#!/bin/bash
# Build Spark with Snowflake version
set -e

# Update version first
./build/update-version.sh

# Build using Spark's existing Maven wrapper
./build/mvn -DskipTests clean package

echo "Build completed successfully"
