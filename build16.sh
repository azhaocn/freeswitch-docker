#!/bin/bash

LOCAL_HUB="hub.nxtele.xyz"

docker build -t freeswitch-docker:1.6-latest . -f Dockerfile-1.6

FS_16_TMP=$(docker run --rm --entrypoint="" -it freeswitch-docker:1.6-latest /usr/bin/freeswitch -version 2> /dev/null)
echo "--------------==="
echo $FS_16_TMP

FS_16_V_A=(${FS_16_TMP[@]})
FS_16_VERSION=${FS_16_V_A[2]::-14}
FS_16_A=(${FS_16_VERSION//./ })
FS_16_A=(${FS_16_A[@]})
FS_16_MM="${FS_16_A[0]}.${FS_16_A[1]}"

docker tag freeswitch-docker:1.6-latest ${LOCAL_HUB}/asu/freeswitch-docker:${FS_16_VERSION}
docker tag freeswitch-docker:1.6-latest ${LOCAL_HUB}/asu/freeswitch-docker:${FS_16_MM}
docker tag freeswitch-docker:1.6-latest ${LOCAL_HUB}/asu/freeswitch-docker:1.6-latest

echo "-----------------------"
echo "Saved Tag \"${LOCAL_HUB}/freeswitch-docker:${FS_16_VERSION}\""
echo "Saved Tag \"${LOCAL_HUB}/freeswitch-docker:${FS_16_MM}\""
echo "-----------------------"

docker push ${LOCAL_HUB}/asu/freeswitch-docker:${FS_16_VERSION}
docker push ${LOCAL_HUB}/asu/freeswitch-docker:${FS_16_MM}
docker push ${LOCAL_HUB}/asu/freeswitch-docker:1.6-latest

