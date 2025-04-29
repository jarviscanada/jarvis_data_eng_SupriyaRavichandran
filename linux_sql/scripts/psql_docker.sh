#!/bin/bash

# Capture CLI arguments
cmd=$1
db_username=$2
db_password=$3

# Check if Docker is running
sudo systemctl status docker || sudo systemctl start docker

# Check if container exists
docker container inspect jrvs-psql &>/dev/null
container_status=$?

# Handle create, start, stop
case $cmd in
  create)
    # Check if container already exists
    if [ $container_status -eq 0 ]; then
      echo 'Container already exists.'
      exit 1
    fi

    # Validate arguments
    if [ $# -ne 3 ]; then
      echo 'Create requires both username and password.'
      exit 1
    fi

    # Create container
    docker volume create pgdata
    docker run --name jrvs-psql -e POSTGRES_PASSWORD=$db_password -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine
    exit $?
    ;;

  start|stop)
    # Check if container exists
    if [ $container_status -ne 0 ]; then
      echo 'Container does not exist.'
      exit 1
    fi

    # Start or stop the container
    docker container $cmd jrvs-psql
    exit $?
    ;;

  *)
    echo 'Invalid command. Use start|stop|create.'
    exit 1
    ;;
esac
