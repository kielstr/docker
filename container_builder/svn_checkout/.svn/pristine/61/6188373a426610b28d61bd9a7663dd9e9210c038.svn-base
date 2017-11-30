#!/bin/bash

# set -a
# eval $( /docker/setup-mysql-env );
# echo "select user_id from $MYSQL_DBNAME.user_session where false" > check-exists.sql
# If database does not exist, create it.
# if ! mysql -u $WS_DB_USER < check-exists.sql 2> /dev/null ; then
#    echo Creating new websurvey database $MYSQL_DBNAME
#    SD_CONF_FILE=/websurvey/conf/config.pl ws-database -S > s.ql
#    cat s.ql
#    if ! mysql -u $WS_DB_USER < s.ql; then
#        echo Database creation failed - aborting
#        exit 1
#    fi
# fi


generate-meta stfu
exec plackup -s Gazelle --listen :5000 --no-default-middleware --app /websurvey/ws.psgi --preload-app --backlog 16
