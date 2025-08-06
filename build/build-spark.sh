#!/bin/bash
set -e

SPARK_VERSION="${1:-3.5.0}"
SNOWFLAKE_SUFFIX="${2:-snowflake_0}"

echo "Building Spark version: ${SPARK_VERSION}-${SNOWFLAKE_SUFFIX}"

./build/update-version.sh $SPARK_VERSION $SNOWFLAKE_SUFFIX

# Set Maven options with required Java 11 flag
export MAVEN_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=1g -Dio.netty.tryReflectionSetAccessible=true"

# For Spark 3.5.0, remove the Java 17+ specific flag
if [[ "$SPARK_VERSION" == "3.5"* ]]; then
    sed -i.bak 's/--enable-native-access=ALL-UNNAMED//g' build/mvn 2>/dev/null || true
fi

./build/mvn -DskipTests -Dmaven.javadoc.skip=true -Dspotless.check.skip=true clean package

echo "Build completed successfully"
