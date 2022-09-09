#!/bin/bash

# to be invoked from patch-for-mingw-build.bat
ESC=

RED=$ESC[91m
GREEN=$ESC[92m
YELLOW=$ESC[93m
BLUE=$ESC[94m
MAGENTA=$ESC[95m
CYAN=$ESC[96m
WHITE=$ESC[97m
DEFAULT=$ESC[0m

SCRIPT=`basename "$0" .sh`
LOCALGIT=/d/git/zlaski

"$(dirname $COMSPEC)/net" session 1>/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "${RED}${SCRIPT}: Must be run with Administrator privileges${DEFAULT}"
    exit 1
fi

if [[ "$MSYSTEM" != "MINGW64" ]]; then
    echo "${RED}${SCRIPT}: Must use Mingw64 build environment${DEFAULT}"
	exit 1
fi

GITSDK=https://github.com/git-for-windows/git-sdk-64
REPO=$(basename $GITSDK)

pushd $LOCALGIT

if [ ! -d $REPO ]; then
  git clone $GITSDK
fi

cd $REPO
git pull

GITSDKDIR=$PWD
popd

