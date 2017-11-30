FROM python:2

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive http_proxy=http://proxycache.fz.sdlocal.net:3128 apt-get install \
        -y --no-install-recommends \
    curl netcat-openbsd

RUN pip install selenium ddt xmlrunner

