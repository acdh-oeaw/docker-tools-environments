#!/usr/bin/env bash

# Translates arguments between standard groupadd and busybox'es addgroup
# busybox does not accept long args

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -g|--gid)
    TR_GID="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo addgroup -g $TR_GID $@