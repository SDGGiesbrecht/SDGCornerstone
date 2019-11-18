#!/bin/bash

# Refresh (macOS).command
#
# This source file is part of the SDGCornerstone open source project.
# https://sdggiesbrecht.github.io/SDGCornerstone
#
# Copyright ©2019 Jeremy David Giesbrecht and the SDGCornerstone project contributors.
#
# Soli Deo gloria.
#
# Licensed under the Apache Licence, Version 2.0.
# See http://www.apache.org/licenses/LICENSE-2.0 for licence information.

set -e
REPOSITORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${REPOSITORY}"
if workspace version > /dev/null 2>&1 ; then
    echo "Using system install of Workspace..."
    workspace refresh $1 $2 •use‐version 0.26.0
elif ~/Library/Caches/ca.solideogloria.Workspace/Versions/0.26.0/workspace version > /dev/null 2>&1 ; then
    echo "Using cached build of Workspace..."
    ~/Library/Caches/ca.solideogloria.Workspace/Versions/0.26.0/workspace refresh $1 $2 •use‐version 0.26.0
elif ~/.cache/ca.solideogloria.Workspace/Versions/0.26.0/workspace version > /dev/null 2>&1 ; then
    echo "Using cached build of Workspace..."
    ~/.cache/ca.solideogloria.Workspace/Versions/0.26.0/workspace refresh $1 $2 •use‐version 0.26.0
else
    echo "No cached build detected, fetching Workspace..."
    rm -rf /tmp/Workspace
    git clone https://github.com/SDGGiesbrecht/Workspace /tmp/Workspace
    cd /tmp/Workspace
    swift build --configuration release
    cd "${REPOSITORY}"
    /tmp/Workspace/.build/release/workspace refresh $1 $2 •use‐version 0.26.0
    rm -rf /tmp/Workspace
fi
