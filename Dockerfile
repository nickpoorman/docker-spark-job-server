# docker-spark-job-server
#
# VERSION 0.0.1

FROM nickpoorman/docker-mesos:0.0.1
MAINTAINER Nick Poorman <mail@nickpoorman.com>

# Don't care about the all the mesos crap that was installed for mesos. We only want the native lib
RUN find / -name \*mesos\* | perl -ne 'print if !/mesos(.*)\.(so|la|jar)/' | xargs rm -rf

# Download the pre-built package
RUN mkdir /tmp/job-server && \
    cd /tmp/job-server && \
    wget -qO- https://github.com/nextglass/spark-jobserver/raw/jobserver-0.5.1-BUILD-4.28.2015/dist/job-server.tar.gz | tar xz

ADD run.sh /tmp/job-server/

WORKDIR /tmp/job-server

ENTRYPOINT ["/tmp/job-server/run.sh"]
