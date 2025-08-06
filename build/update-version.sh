#!/bin/bash
# Update Apache Spark version to Snowflake version

SPARK_VERSION="${1:-3.5.0}"
SNOWFLAKE_SUFFIX="${2:-SNOWFLAKE_0}"
FULL_VERSION="${SPARK_VERSION}-${SNOWFLAKE_SUFFIX}"

echo "Updating version to: $FULL_VERSION"

# Detect OS for sed compatibility
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    find . -name "pom.xml" -exec sed -i '' \
        "s/<version>.*-SNAPSHOT<\/version>/<version>$FULL_VERSION<\/version>/g" {} \;
else
    # Linux
    find . -name "pom.xml" -exec sed -i \
        "s/<version>.*-SNAPSHOT<\/version>/<version>$FULL_VERSION<\/version>/g" {} \;
fi

# Update SBT version
echo "version := \"$FULL_VERSION\"" > version.sbt

# Update Python version if it exists
if [ -f "python/setup.py" ]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/VERSION = '.*'/VERSION = '$FULL_VERSION'/g" python/setup.py
    else
        sed -i "s/VERSION = '.*'/VERSION = '$FULL_VERSION'/g" python/setup.py
    fi
fi

echo "Version updated successfully"