FROM acdh/existdb4x
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
VOLUME /home/gitlab-runner
VOLUME /etc/gitlab-runner
COPY wrapper.sh /opt/exist/tools/yajsw/bin/wrapper.sh
#@INJECT_USER@
RUN chmod a+x /opt/exist/tools/yajsw/bin/wrapper.sh