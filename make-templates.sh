#!/bin/bash

# Get list of templates
MLIST=$(ls methods)

# Modify build script to fill blanks
for METHOD in ${MLIST[@]}; do
    BLDFILE=build-$METHOD
    cp base-script $BLDFILE

    sed -i -e "/%METHOD%/r ${PWD}/methods/$METHOD" -e "/%METHOD%/d" $BLDFILE
done
