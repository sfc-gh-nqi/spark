#!/bin/bash
set -e

SPARK_VERSION="${1:-3.5.0}"
SNOWFLAKE_SUFFIX="${2:-snowflake_0}"

echo "Building Spark version: ${SPARK_VERSION}-${SNOWFLAKE_SUFFIX}"

./build/update-version.sh $SPARK_VERSION $SNOWFLAKE_SUFFIX

export MAVEN_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=1g"

./build/mvn -DskipTests -Dmaven.javadoc.skip=true -Dspotless.check.skip=true clean package

echo "Build completed successfully"
