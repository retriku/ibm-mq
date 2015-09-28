#!/bin/bash

docker run \
--name ibmmq \
--ipc host \
-p 1414:1414 \
-v /var/example:/var/mqm \
-e LICENSE=accept \
-e MQ_QMGR_NAME=QM1 \
-d \
ibmimages/mqadvanced

sleep 30

docker exec ibmmq bash -c 'setmqaut -m QM1 -t qmgr -p ibmuser +connect +inq +dsp'
docker exec ibmmq bash -c 'setmqaut -m QM1 -t q -n MESSAGE.QUEUE -p ibmuser +inq +browse +get +put +dsp'
