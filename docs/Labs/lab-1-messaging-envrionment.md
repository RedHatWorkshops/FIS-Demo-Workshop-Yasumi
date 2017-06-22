# Creation of the Messaging layer

As the Yasumi Puzzle Solution on OCP is using the AMQ messaging layer, we will first go through a set of steps in order to deploy an AMQ Message Broker in the OpenShift environment. That way, all URI References within the FIS flow can reference an internal message broker.

---

**Looking at the LAB 1 directory, you will find only a Solution part as setting up the Broker in OpenShift is not considered a main objective in the workshop.**

---

## Word of thanks

A big thanks goes to **Patrick Steiner** who used his acquired knowledge on other projects to help me adding the AMQ broker to the project.

---

## Configure the AMQ Creation Script

As this solution depends on AMQ to provide the messaging layer, we will need to get a JMS Broker installed. The Script that will be used will provide OpenShift with the needed templates and variables to perform this operation. More information is available in the **Highlights** section

Please perform the following steps:

* Go into the Lab 1/Solution directory
* Edit the configureAMQ.sh script and set the OCP\_IP variable to the correct IP Address.
* Run the Script.

Upon successful execution of the script, you will find the OpenShift Console to be showing the following:

* Added a Project **Yasumi Puzzler**
* Added a Template for the AMQ Broker in the OpenShift Project \(yasumi-amq\)

* In the Overview of the Yasumi Puzzler project you can see the AMQ Broker Pod

![](/docs/assets/AMQBrokerPod.png)

# Highlights

## Configuration Script

The configuration script performs the following tasks:

* Connecting to the correct OpenShift instance
* Uploads the AMQ Template \(AMQ/amq62-exposed.json\)
* Creates the Yasumi Puzzler Project
* Logs in with the openshift-dev user \(password = devel\)
* Adds some security secret information \(amq-app-secret.json\)
* Adding roles and policies in order to get a view on the AMQ functioning.
* Exposes the broker-amq-tcp definition in the environment

## amq62-exposed.json

This configuration file contains all the needed information to create the key and trust stores for the amq broker to startup.

## amq-app-secret.json

This is the template that defines the characteristics for the AMQ broker. Special item to notice is that the port 61616 \(default messaging port for openwire\) is augmented with a nodePort \(30616\) in order to bridge into the container using a TCP Port.

