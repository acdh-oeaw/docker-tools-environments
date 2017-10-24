#!/usr/bin/env sh
if [ "x$2" != "x" ] && [ -f "$2" ]
then bzip2 $2
fi