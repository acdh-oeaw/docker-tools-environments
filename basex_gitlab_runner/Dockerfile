FROM acdh/java8
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

# Get node, npm, yarn and chromium-browser to have some tools for testing, ant and mvn for building
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - &&\
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list &&\
    apt update && apt install -y git curl tar xz-utils bzip2 zstd p7zip ant maven chromium-browser nodejs yarn
# The deb file is broken ...
COPY gitlab-runner_amd64.deb /
RUN dpkg-deb -x /gitlab-runner_amd64.deb / && rm /gitlab-runner_amd64.deb
COPY register-gitlab-runner.sh /
# wrapper with added gitlab-runner, needs a work directory /home/gitlab-runner, config in /etc/gitlab-runner
# Cannot force volumes here because populating them with contents from within the container needs a
# runnable container. This container cannot run without an unpacked BaseX installation.
# VOLUME /home/gitlab-runner
# VOLUME /etc/gitlab-runner
# VOLUME /opt/basex forced by tools
#@INJECT_USER@
# USER user
RUN mkdir -p /opt/basex &&\
    if [ $(id user >/dev/null  2>&1; echo $?) -eq "0" ]; then chown user:user /opt/basex; fi
WORKDIR /opt/basex/bin
# This also has to start gitlab-runner
# Change /opt/basex/bin/basexhttp (mounted from project dir)
#   # Run code
# + gitlab-runner run --working-directory=/home/gitlab-runner --config=/etc/gitlab-runner/config.toml &
#   exec java -cp "$CP" $BASEX_JVM org.basex.BaseXHTTP "$@"
CMD ["/opt/basex/bin/basexhttp"]
