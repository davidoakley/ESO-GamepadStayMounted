#!/bin/bash

set -e

export VERSION=`git tag -l --contains HEAD | egrep '^v[0-9]+\.[0-9]+\.[0-9]+' | cut -c 2-`
export ADDON='GamepadStayMounted'

if [ -z "$VERSION" ]; then
   echo "No version tag found"
   exit 1
fi

echo "Version: $VERSION"

rm -rf _build/$ADDON
mkdir -p _build/$ADDON

cp *.lua *.txt _build/$ADDON
#cp -r media _build/$ADDON/media
#cp -r lang _build/$ADDON/lang

cd _build

sed -i "s/## Version: .*/## Version: $VERSION/g" $ADDON/$ADDON.txt
sed -i "s/  appVersion = ".*",/  appVersion = \"$VERSION\",/g" $ADDON/$ADDON.lua

zip -r "$ADDON-v$VERSION.zip" $ADDON
