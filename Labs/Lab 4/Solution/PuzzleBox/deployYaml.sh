#!/bin/sh

source ../../../setenv.sh

echo "Setting OpenShift IP address to ${OCP_IP}"

#Please Validate the username and password
oc login https://${OCP_IP}:8443 -u ${USERNAME} -p ${PASSWORD}

echo setting the Project FIS-YasumiPuzzler
oc project ${USERNAME}yasumi

oc create -f src/main/fabric8/yasumipuzzleboxhandler.yaml
