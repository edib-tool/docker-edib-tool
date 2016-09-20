#!/bin/sh
set -e

TOOLS_DIR="/build/tools"
ESZ="ex_strip_zip"
ESZ_HOME="https://github.com/ntrepid8/$ESZ"

echo "Fetching ExStripZip ($ESZ_HOME) ..."
ESZ_BUILD_DIR=$(mktemp -d)
cd $ESZ_BUILD_DIR
  git clone $ESZ_HOME
  cd $ESZ
    MIX_ENV=prod mix escript.build
    cp $ESZ $TOOLS_DIR/$ESZ
    chmod +x $TOOLS_DIR/$ESZ
cd ~
rm -rf $ESZ_BUILD_DIR
