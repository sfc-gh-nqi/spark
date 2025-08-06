#!/bin/bash
# Build Spark with Snowflake version
set -e

SPARK_VERSION="${1:-3.5.0}"
SNOWFLAKE_SUFFIX="${2:-SNOWFLAKE_0}"

# Update version with parameters
./build/update-version.sh $SPARK_VERSION $SNOWFLAKE_SUFFIX

# Skip the tests, and delete old build files from previous builds, eventually compile code and create JAR files
# Use non-incremental compilation to avoid Scala compiler issues with mixed Java/Scala code
./build/mvn -DskipTests -Dscala.recompileMode=all clean package

echo "Build completed successfully"