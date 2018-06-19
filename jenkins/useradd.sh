#!/usr/bin/env bash

# Translates arguments between standard useradd and busybox'es adduser
# busybox does not accept long args, uses -h instead of -d

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--uid)
    UID="$2"
    shift # past argument
    shift # past value
    ;;
    -g|--gid)
    GID="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--home-dir)
    HOMEDIR="$2"
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

adduser -u $UID -g $GID -h $HOMEDIR $@