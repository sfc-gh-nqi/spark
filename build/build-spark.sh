#!/bin/bash
# Build Spark with Snowflake version
set -e

SPARK_VERSION="${1:-3.5.0}"
SNOWFLAKE_SUFFIX="${2:-SNOWFLAKE_0}"

echo "Building Spark version: ${SPARK_VERSION}-${SNOWFLAKE_SUFFIX}"

# Update version first
./build/update-version.sh $SPARK_VERSION $SNOWFLAKE_SUFFIX

# Set Maven options to avoid JVM issues
export MAVEN_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=1g"

# Skip the tests, and delete old build files from previous builds, eventually compile code and create JAR files
# Add flags to skip non-essential tasks
./build/mvn -DskipTests -Dmaven.javadoc.skip=true -Dspotless.check.skip=true clean package

echo "Build completed successfully"