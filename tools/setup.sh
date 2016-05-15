#!/bin/sh
set -e

TOOLS_DIR="/build/tools"
ESZ="ex_strip_zip"
ESZ_VER="0.0.2"
ESZ_HOME="https://github.com/ntrepid8/$ESZ"
ESZ_DL_URL="$ESZ_HOME/releases/download/v$ESZ_VER/$ESZ"

echo "Fetching ExStripZip ($ESZ_HOME) ..."
curl -sSL $ESZ_DL_URL -o $TOOLS_DIR/$ESZ
chmod +x $TOOLS_DIR/$ESZ
