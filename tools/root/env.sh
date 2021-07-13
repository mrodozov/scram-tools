#!/bin/bash -e

GCC_PATH=`which gcc` || exit 1
export ROOT_GCC_ROOT=`echo $GCC_PATH | sed -e 's|/bin/gcc||'`

