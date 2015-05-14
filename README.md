# docker-spark-job-server

Runs [nickpoorman/docker-spark-postgresql-base](https://github.com/nickpoorman/docker-spark-postgresql-base) Docker image.

*Note: It's actual parent is [nickpoorman/docker-mesos](https://github.com/nickpoorman/docker-mesos) so that we have the mesos lib included.*

This container should be used to run a Spark [Job Server](https://github.com/spark-jobserver/spark-jobserver) and packaged with everything the master needs.

To make this easier, supply a url to fetch your custom [conf](https://github.com/spark-jobserver/spark-jobserver/blob/master/job-server/config/local.conf.template).

The [environment](https://github.com/spark-jobserver/spark-jobserver/blob/master/job-server/config/local.sh.template) should be specified with Docker's [-e switch](https://docs.docker.com/reference/run/#env-environment-variables).

After setup this "essentially" runs the [start script](https://github.com/spark-jobserver/spark-jobserver/blob/master/bin/server_start.sh) customized for the Dockerfile.

## example

```
docker -H tcp://${HOST_IP_0}:2375 run -it \
    --net=host \
    -e APP_USER=root \
    -e APP_GROUP=root \
    -e SCALA_VERSION=2.10.5 \
    -e SPARK_HOME=/spark \
    -e SPARK_CONF_DIR=/spark/conf \
    -e INSTALL_DIR=/job-server \
    -e JOB_SERVER_CONFIG_URI=https://raw.githubusercontent.com/nextglass/spark-jobserver/master/job-server/config/local.conf.template \
    -p 8090:8090 \
    -p 9999:9999 \
    nickpoorman/docker-spark-job-server
```
