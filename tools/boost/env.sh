#!/bin/bash -ex

#source $SCRAM_TOOLS_BIN_DIR/python_env.sh

PY_VER=`ls ${TOOL_ROOT}/lib | grep boost-python | tr -d '.' | tr '-' ' ' | awk '{print $2}'`

case $(uname) in Darwin ) so=dylib ;; * ) so=so ;; esac
getLibName()
{
  libname=`find ${TOOL_ROOT}/lib -name "libboost_$1.$so" -follow -exec basename {} \;`
  echo $libname | sed -e 's|[.][^-]*$||;s|^lib||'
}

export BOOST_THREAD_LIB=`getLibName thread`
export BOOST_CHRONO_LIB=`getLibName chrono`
export BOOST_FILESYSTEM_LIB=`getLibName filesystem`
export BOOST_DATE_TIME_LIB=`getLibName date_time`
export BOOST_SYSTEM_LIB=`getLibName system`
export BOOST_PROGRAM_OPTIONS_LIB=`getLibName program_options`
export BOOST_PYTHON_LIB=`getLibName ${PY_VER}`
export BOOST_REGEX_LIB=`getLibName regex`
export BOOST_SERIALIZATION_LIB=`getLibName serialization`
export BOOST_IOSTREAMS_LIB=`getLibName iostream`
export BOOST_MPI_LIB=`getLibName mpi`

