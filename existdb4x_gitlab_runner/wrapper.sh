#!/usr/bin/env bash
mkdir -p /opt/exist/autodeploy
if [ ! "$(ls -A /opt/exist/autodeploy)" ];
then cp /opt/exist/autodeploy.init/* /opt/exist/autodeploy
fi
gitlab-runner run --working-directory=/home/gitlab-runner --config=/etc/gitlab-runner/config.toml &
exec ${JAVA_HOME}/bin/java -Dwrapper.pidfile=${EXIST_HOME}/webapp/WEB-INF/logs/wrapper.pid -Dwrapper.service=true -Dwrapper.visible=false -Djna_tmpdir=${EXIST_HOME}/tools/yajsw/tmp -jar ${EXIST_HOME}/tools/yajsw/wrapper.jar -c ${EXIST_HOME}/tools/yajsw/conf/wrapper.conf
