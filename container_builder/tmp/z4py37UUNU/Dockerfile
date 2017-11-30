FROM docker.sdlocal.net/websurvey/websurvey

COPY default/docker/ /docker
COPY . /surveys

RUN chown -R websurvey:websurvey /surveys
USER websurvey

CMD /docker/start.sh
