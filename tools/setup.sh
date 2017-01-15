#!/bin/sh
set -ex

TOOLS_DIR="/build/tools"
ESZ="ex_strip_zip"
ESZ_ZIP_BRANCH="master"
ESZ_HOME_ZIP="https://github.com/ntrepid8/$ESZ/archive/$ESZ_ZIP_BRANCH.zip"

echo "Fetching ExStripZip ($ESZ_HOME) ..."
ESZ_BUILD_DIR=$(mktemp -d)
cd $ESZ_BUILD_DIR
  curl -sSL $ESZ_HOME_ZIP -o $ESZ.zip
  unzip $ESZ.zip
  cd $ESZ-$ESZ_ZIP_BRANCH
    MIX_ENV=prod mix escript.build
    cp $ESZ $TOOLS_DIR/$ESZ
    chmod +x $TOOLS_DIR/$ESZ
cd ~
rm -rf $ESZ_BUILD_DIR
