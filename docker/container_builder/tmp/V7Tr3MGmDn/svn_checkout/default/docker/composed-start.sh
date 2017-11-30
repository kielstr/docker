#!/bin/bash

export PERL5LIB=/websurvey/lib:$PERL5LIB
export PATH=/websurvey/bin:$PATH

eval $( /docker/setup-mysql-env );
# Setup proper mysql env variables.
export MYSQL_TCP_PORT=3306

wait-for-port() {
    local host=$1;      shift
    local port=$1;      shift
    local timeout=$1;   shift

    local sleeptime=2
    local retries=$(( $timeout / $sleeptime ))

    for i in $( seq $retries ); do
        echo Waiting for $@ to start \(attempt $i of $retries\)
        if nc -z $host $port; then
            echo $@ is ready
            return 0
        fi
        sleep $sleeptime
    done
    echo $@ is not ready - aborting after $timeout seconds
    return 1
}

# Wait for the MySQL container to become ready.
if ! wait-for-port $MYSQL_HOST $MYSQL_TCP_PORT 60 MySQL server; then
    exit 1
fi

deploy-db
/docker/start.sh
