#!/bin/bash

# Script for update package version in package.json

echo "Updating version in package.json"

# Extracting the new version from pubspec.yaml
pubspecFile="apps/spark_board_backend/pubspec.yaml"
newVersion=$(grep '^version: [0-9]\+.[0-9]\+.[0-9]\+.*$' $pubspecFile | awk '{print $2}')

packageJson="apps/spark_board_backend/package.json"
packageLock="apps/spark_board_backend/package-lock.json"

# Updating the version in package.json
sed -i "/\"version\":/c\  \"version\": \"$newVersion\"," $packageJson
# npm install for updating package-lock.json
npm --prefix "./apps/spark_board_backend" install

# Adding to git
git add $packageJson
git add $packageLock

echo "package.json updated"
