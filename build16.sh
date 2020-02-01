#!/bin/bash

docker build -t freeswitch-docker:1.6-latest . -f Dockerfile-1.6

FS_16_TMP=$(docker run --rm --entrypoint="" -it freeswitch-docker:1.6-latest /usr/bin/freeswitch -version 2> /dev/null)
echo "--------------==="
echo $FS_16_TMP

FS_16_V_A=(${FS_16_TMP[@]})
FS_16_VERSION=${FS_16_V_A[2]::-14}
FS_16_A=(${FS_16_VERSION//./ })
FS_16_A=(${FS_16_A[@]})
FS_16_MM="${FS_16_A[0]}.${FS_16_A[1]}"

docker tag freeswitch-docker:1.6-latest readytalk/freeswitch-docker:${FS_16_VERSION}
docker tag freeswitch-docker:1.6-latest readytalk/freeswitch-docker:${FS_16_MM}
docker tag freeswitch-docker:1.6-latest readytalk/freeswitch-docker:1.6-latest

echo "-----------------------"
echo "Saved Tag \"readytalk/freeswitch-docker:${FS_16_VERSION}\""
echo "Saved Tag \"readytalk/freeswitch-docker:${FS_16_MM}\""
echo "-----------------------"

if [[ ${TRAVIS} && "${TRAVIS_BRANCH}" == "master" && -n $DOCKER_USERNAME && -n $DOCKER_PASSWORD ]]; then
  docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
  docker push readytalk/freeswitch-docker:${FS_16_VERSION}
  docker push readytalk/freeswitch-docker:${FS_16_MM}
  docker push readytalk/freeswitch-docker:1.6-latest
fi

