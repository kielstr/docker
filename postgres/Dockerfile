FROM postgres:9.6.3 AS postgres

RUN apt-get update && apt-get -y install \
	apt-utils \
	joe \
    libdbd-pg-perl

COPY ./db_ready.pl /bin/db_ready.pl
