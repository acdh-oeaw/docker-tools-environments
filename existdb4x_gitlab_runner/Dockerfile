FROM acdh/existdb4x
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

# Get node, npm, yarn and chromium-browser to have some tools for testing, ant and mvn for building
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash - &&\
    yum -y update && yum install -y git tar xz-utils bzip2 zstd p7zip ant maven chromium-browser nodejs &&\
    yum clean all &&\
    npm -g install corepack &&\
    curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/rpm/gitlab-runner_amd64.rpm"
RUN yum install -y /gitlab-runner_amd64.rpm && rm /gitlab-runner_amd64.rpm
COPY register-gitlab-runner.sh /
# wrapper with added gitlab-runner, needs a work directory /home/gitlab-runner, config in /etc/gitlab-runner
VOLUME /home/gitlab-runner
VOLUME /etc/gitlab-runner
COPY wrapper.sh /opt/exist/tools/yajsw/bin/wrapper.sh
COPY diffpng /usr/bin
#@INJECT_USER@
RUN chmod a+x /opt/exist/tools/yajsw/bin/wrapper.sh