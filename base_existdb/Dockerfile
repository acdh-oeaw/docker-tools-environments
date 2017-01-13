FROM acdh/java8
MAINTAINER Omar Siam <omar.siam@oeaw.ac.at>

RUN sed -i -e 's~http://archive~http://at.archive~' /etc/apt/sources.list &&\
    apt-get update && apt-get dist-upgrade -y && apt-get clean
RUN apt install -y openjdk-8-jdk git patch && apt-get clean &&\
    update-ca-certificates -f
RUN cd /opt && git clone --verbose --progress https://github.com/eXist-db/exist.git &&\
    cd /opt/exist && ant clean && rm -f extensions/betterform/main/lib/* && git reset --hard &&\
    git gc --aggressive --prune
ENV EXIST_HOME /opt/exist
ENV PATH $PATH:/opt/exist/bin

 # not usable on its own! Use existdb22 or existdb30