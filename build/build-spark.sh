#!/bin/bash
# Build Spark with Snowflake version
set -e

SPARK_VERSION="${1:-3.5.0}"
SNOWFLAKE_SUFFIX="${2:-SNOWFLAKE_0}"

echo "Building Spark version: ${SPARK_VERSION}-${SNOWFLAKE_SUFFIX}"

# Update version first
./build/update-version.sh $SPARK_VERSION $SNOWFLAKE_SUFFIX

# Set Maven options
export MAVEN_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=1g"

# For CI environment, install Maven if not present
if ! command -v mvn &> /dev/null; then
    echo "Installing Maven..."
    sudo apt-get update && sudo apt-get install -y maven
fi

# Use system Maven instead of Spark's wrapper to avoid Java compatibility issues
mvn -DskipTests -Dmaven.javadoc.skip=true -Dspotless.check.skip=true clean package

echo "Build completed successfully"