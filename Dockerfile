# docker-spark-job-server
#
# VERSION 0.0.1

FROM nickpoorman/docker-mesos
MAINTAINER Nick Poorman <mail@nickpoorman.com>

# Don't care about the all the mesos crap that was installed for mesos. We only want the native lib
RUN find / -name \*mesos\* | perl -ne 'print if !/mesos(.*)\.(so|la|jar)/' | xargs rm -rf

# Download the pre-built package
RUN mkdir -p /job-server && \
    cd /job-server && \
    wget -qO- https://github.com/nextglass/spark-jobserver/raw/jobserver-0.5.1-BUILD-4.28.2015/dist/job-server.tar.gz | tar xz

ADD run.sh /job-server/

WORKDIR /job-server

ENTRYPOINT ["/job-server/run.sh"]
