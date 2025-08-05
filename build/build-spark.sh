#!/bin/bash
# Build Spark with Snowflake version
set -e

SPARK_VERSION="${1:-4.1.0}"
SNOWFLAKE_SUFFIX="${2:-snowflake_0}"

# Update version with parameters
./build/update-version.sh $SPARK_VERSION $SNOWFLAKE_SUFFIX

# Skip the tests, and delete old build files from previous builds, eventually compile code and create JAR files
./build/mvn -DskipTests clean package

echo "Build completed successfully"
