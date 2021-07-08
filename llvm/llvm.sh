#!/bin/bash -x

GCC_PATH=`which gcc` || exit 1
GCC_ROOT=`echo $GCC_PATH | sed -e 's|/bin/gcc||'`
G77_ROOT=$GCC_ROOT
export GCC_ROOT
export G77_ROOT

