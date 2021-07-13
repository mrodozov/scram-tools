#!/bin/bash -e

GCC_PATH=`which gcc` || exit 1
export G77_ROOT=`echo $GCC_PATH | sed -e 's|/bin/gcc||'`

