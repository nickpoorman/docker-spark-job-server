# docker-spark-job-server

Runs [nickpoorman/docker-spark-postgresql-base](https://github.com/nickpoorman/docker-spark-postgresql-base) Docker image.

*Note: It's actual parent is [nickpoorman/docker-mesos](https://github.com/nickpoorman/docker-mesos) so that we have the mesos lib included.*

This container should be used to run a Spark [Job Server](https://github.com/spark-jobserver/spark-jobserver) and packaged with everything the master needs.

To make this easier, supply a url to fetch your custom [conf](https://github.com/spark-jobserver/spark-jobserver/blob/master/job-server/config/local.conf.template).

The [environment](https://github.com/spark-jobserver/spark-jobserver/blob/master/job-server/config/local.sh.template) should be specified with Docker's [-e switch](https://docs.docker.com/reference/run/#env-environment-variables).

After setup this "essentially" runs the [start script](https://github.com/spark-jobserver/spark-jobserver/blob/master/bin/server_start.sh) customized for the Dockerfile.

## example

```
docker run -it \
    -e "SPARK_HOME=/tmp/spark" \
    -e "SPARK_EXECUTOR_URI=" \
    -e "APP_USER=spark" \
    -e "APP_GROUP=spark" \
    -e "INSTALL_DIR=/tmp/job-server" \
    -e "SCALA_VERSION=2.10.5" \
    -e "SPARK_HOME=/tmp/spark" \
    -e "SPARK_CONF_DIR=/tmp/spark/conf" \
    nickpoorman/docker-spark-job-server
```
