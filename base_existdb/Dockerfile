FROM acdh/java8centos
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN yum install -y ant maven git patch && \
    cd /opt && git clone --depth 1 --branch eXist-2.2 --verbose --progress https://github.com/eXist-db/exist.git && \
    cd /opt/exist &&\
    ant clean &&\
    cd /opt && git clone --verbose --progress https://github.com/dariok/eXgit.git && \
    cd /opt/eXgit && git checkout 3a331ac4228d2d47bb39126563a95bd055f04cc8 && \
    mvn clean package && cp target/exgit-full.jar $EXIST_HOME/lib/user && \
    yum -y remove ant maven && yum -y autoremove && \
    yum clean all &&\
    rm -rf ~/.m2 /var/cache/yum/
ENV EXIST_HOME /opt/exist
ENV PATH $PATH:/opt/exist/bin

# docker tools assumes these exist so provide wrappers.
COPY useradd.sh /usr/bin/useradd
COPY groupadd.sh /usr/bin/groupadd

 # not usable on its own! Use existdb22 or existdb30