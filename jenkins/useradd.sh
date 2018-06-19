#!/usr/bin/env bash

# Translates arguments between standard useradd and busybox'es adduser
# busybox does not accept long args, uses -h instead of -d

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--uid)
    TR_UID="$2"
    shift # past argument
    shift # past value
    ;;
    -g|--gid)
    TR_GID="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--home-dir)
    TR_HOMEDIR="$2"
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

adduser -u $TR_UID -g $TR_GID -h $TR_HOMEDIR $@