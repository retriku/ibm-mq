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
