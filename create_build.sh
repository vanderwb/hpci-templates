#!/bin/bash

usage () {
	echo "Usage: ./create_build.sh -s SYSTEM -m METHOD -n NAME -v VERSION"
	exit 0
}

SCRIPTROOT=/glade/p/work/vanderwb

# Make sure there are eight arguments
if [[ $# -ne 8 ]]; then
	usage
fi

# Pull settings
while [[ $# -gt 0 ]]; do
	case $1 in
		-h|--help)
			usage
			;;
		-s|--system)
            shift
            SYSTEM=$1
			;;
		-m|--method)
            shift
			METHOD=$1
			;;
		-n|--name)
            shift
			SWNAME=$1
			;;
		-v|--version)
            shift
			SWVERS=$1
			;;
		*)
            echo "ERROR: invalid argument"
            usage
            ;;
	esac
    
    shift
done

# Make directory for build script
SWPATH=${SCRIPTROOT}/${SYSTEM}/BUILD/$SWNAME
mkdir -p $SWPATH

# Create build script
SWSCRIPT=${SWPATH}/build-${SWNAME##*/}-$SWVERS

if [[ -f $SWSCRIPT ]]; then
    echo "ERROR: script already exists at path. Exiting..."
    echo "PATH:  $SWSCRIPT"
    exit 1
fi

cp build-template $SWSCRIPT

# Modify build script to fill blanks
sed -i "s|%NAME%|$SWNAME|" $SWSCRIPT
sed -i "s|%VERSION%|$SWVERS|" $SWSCRIPT
sed -i -e "/%METHOD%/r ${PWD}/methods/$METHOD" -e "/%METHOD%/d" $SWSCRIPT
