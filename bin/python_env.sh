#!/bin/bash -ex

export PYTHON3V=$(python3 -V 2>&1 | awk '{print $2}' | cut -f1,2 -d.)
export PYTHONV=$(python -V 2>&1 | awk '{print $2}' | cut -f1,2 -d.)
