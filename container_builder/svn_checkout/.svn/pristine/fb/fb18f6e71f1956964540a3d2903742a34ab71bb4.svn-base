#!/bin/bash

docker-compose build ws ws-admin
docker-compose up -d ws ws-admin proxy

echo "* Waiting for link me to start up..."

HOST=localhost
PORT=5556

count=1
max=30
while [[ $count -le $max ]]; do
	echo -n "."
    if $(curl --output /dev/null --silent --head --fail http://$HOST:$PORT); then
    echo "."
		echo "* Adding sessions to the database"
		docker-compose exec ws /surveys/default/scripts/push-sessions
	  break
	fi
	count=$(( $count + 1 ))
	sleep 2
done

echo "* link-me is available at http://localhost:5556"
echo "* to stop it when done: docker-compose down"
echo "* to check the logs: docker-compose logs ws"
