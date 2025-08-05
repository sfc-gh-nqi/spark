#!/bin/bash
# Update Apache Spark version to Snowflake version

SPARK_VERSION="${1:-4.0.0}"
SNOWFLAKE_SUFFIX="${2:-snowflake_0}"
FULL_VERSION="${SPARK_VERSION}-${SNOWFLAKE_SUFFIX}"

echo "Updating version to: $FULL_VERSION"

# Update Maven pom.xml files
find . -name "pom.xml" -exec sed -i \
  "s/<version>.*-SNAPSHOT<\/version>/<version>$FULL_VERSION<\/version>/g" {} \;

# Update SBT version
echo "version := \"$FULL_VERSION\"" > version.sbt

echo "Version updated successfully"
