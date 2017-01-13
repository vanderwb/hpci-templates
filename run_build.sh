#!/bin/bash

usage () {
	echo "Usage: ./run_build.sh SCRIPT [-c COMPILERS] [-m MPIS]"
	exit 0
}

build () {
	hpcinstall -f $HPCIOPT $SCRIPT
}

# Make sure there is at least one argument
if [[ $# -lt 1 ]]; then
	usage
fi

# Use this script to run the build across compilers (and MPIs)
while [[ $# -gt 0 ]]; do
	case $1 in
		-h|--help)
			usage
			;;
		-c|--compiler)
			TARGET=compiler
			CLIST=()
			;;
		-m|--mpi)
			TARGET=mpi
			MLIST=()
			;;
		-s|--system)
			HPCIOPT=-c
			;;
		*)
			case $TARGET in
				compiler)
					CLIST+=($1)
					;;
				mpi)
					MLIST+=($1)
					;;
				*)
					if [[ -z $SCRIPT ]]; then
						TEMPLATE=$1
					else
						echo "ERROR: argument not preceeded by a target (-c/-m)"
						exit 1
					fi
					;;
			esac
			;;
	esac

	shift
done

SCRIPT=build-${TEMPLATE#*-}

# If compiler list is not set, then set it
if [[ -z $CLIST ]]; then
	CLIST=($(find ${MODULEPATH_ROOT}/compilers -name \*.lua | rev \
			| cut -f1,2 -d '/' | rev | sed -e "s/.lua//g"))
fi

for COMP in "${CLIST[@]}"; do
	sed "s|@CMOD|${COMP}|g" $TEMPLATE > $SCRIPT

	if [[ ! -z $MLIST ]]; then
		for MPI in "${MLIST[@]}"; do
			sed -i "s|@MMOD|${MPI}|g" $SCRIPT
			
			build
		done
	else
		build
	fi
done
