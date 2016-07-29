#!/usr/bin/env bash
mkdir -p /opt/exist/autodeploy
if [ ! "$(ls -A /opt/exist/autodeploy)" ];
then cp /opt/exist/autodeploy.init/* /opt/exist/autodeploy
fi
/opt/exist/tools/wrapper/bin/wrapper-linux-x86-64 "$@"