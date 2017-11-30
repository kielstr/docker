# Note that on the bottom line, we specify 'selenium_test.sh' again as that becomes $0
# inside bash and then the rest of the args become $@.
if [ $# -eq "0" ]
then
    ARGS="discover -v"
else
    ARGS="$@"
    ARGS=${ARGS//\//.}
    ARGS=${ARGS#selenium.}
    ARGS=${ARGS%.py}
fi
docker-compose run -T --rm python_selenium bash -c '
    cd /shared && ./discover.sh "$@"
' selenium_test.sh $ARGS
