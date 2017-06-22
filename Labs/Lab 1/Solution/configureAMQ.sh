#!/bin/sh

source ../../setenv.sh

echo "Setting OpenShift IP address to ${OCP_IP}"

#Please Validate the username and password
oc login https://${OCP_IP}:8443 -u ${USERNAME} -p ${PASSWORD}

echo Creating the Project FIS-YasumiPuzzler
oc new-project ${USERNAME}yasumi --display-name="Yasumi Puzzler" --description="Yasumi Puzzle Solver Project"

echo Adding the policy rule
oc policy add-role-to-user view --serviceaccount=default

echo Install JBoss A-MQ templates
oc create -f AMQ/amq62-exposed.json

echo Define artifacts for A-MQ and deploy it as service on Openshift
oc create -f AMQ/amq-app-secret.json
oc policy add-role-to-user view system:serviceaccount:${USERNAME}yasumi:default
oc policy add-role-to-user view system:serviceaccount:${USERNAME}yasumi:amq-service-account
oc new-app yasumi-amq -p MQ_USERNAME="admin" -p MQ_PASSWORD="change12_me"
oc expose service broker-amq-tcp
