# docker-spark-postgresql-base
#
# VERSION 0.0.1

FROM nickpoorman/docker-mesos:0.0.1
MAINTAINER Nick Poorman <mail@nickpoorman.com>

# Don't care about the all the mesos crap that was installed for mesos. We only want the native lib
RUN find / -name \*mesos\* | perl -ne 'print if !/mesos(.*)\.(so|la|jar)/' | xargs rm -rf

RUN mkdir /tmp/spark-job-server && \
    cd /tmp/spark-job-server && \
    wget -qO- https://github.com/nextglass/spark-jobserver/archive/v0.5.1-SNAPSHOT-4.27.2015.tar.gz | tar -xz --strip-components=1

# need sbt installed to build the job server
RUN echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
    apt-get update && \
    apt-get install -y --force-yes \
      sbt

# build the job-server
RUN cd /tmp/spark-job-server && \
    : ${SCALA_VERSION:=2.10.5} && \
    : ${SPARK_HOME:=/tmp/spark} && \
    echo SCALA_VERSION=${SCALA_VERSION} > config/env.sh && \
    echo SPARK_HOME=${SPARK_HOME} >> config/env.sh && \
    _JAVA_OPTIONS=$(cat .jvmopts) && \
    ./bin/server_package.sh env

WORKDIR /tmp/job-server

ADD run.sh /tmp/job-server/

ENTRYPOINT ["/tmp/job-server/run.sh"]
