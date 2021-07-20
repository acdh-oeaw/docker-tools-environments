FROM acdh/java8centos
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN yum install -y ant maven git patch && \
    cd /opt && git clone --verbose --progress https://github.com/eXist-db/exist.git && \
    cd /opt/exist && git checkout eXist-2.2 &&\
    ant clean && rm -f extensions/betterform/main/lib/* && git reset --hard &&\
    git gc --aggressive --prune && \
    cd /opt && git clone --verbose --progress https://github.com/dariok/eXgit.git && \
    cd /opt/eXgit && git checkout 3a331ac4228d2d47bb39126563a95bd055f04cc8 && \
    mvn clean package && cp target/exgit-full.jar $EXIST_HOME/lib/user && \
    yum -y remove ant maven && yum -y autoremove && \
    rm -rf ~/.m2
ENV EXIST_HOME /opt/exist
ENV PATH $PATH:/opt/exist/bin

 # not usable on its own! Use existdb22 or existdb30