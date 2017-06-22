# Creating the Puzzle Box POD

All relevant files will be located in the Lab 4 exercise - solution - support directories.

## Hands-On:

In this section, we will be exploring the OpenShift Web Console in combination with the Git Repository, to create a POD Deployment using **S2I** from the Server Side. You will find all the files that are needed in the Solutions directory but we are going to use the On-Line repository directly.

---

## Preparing the ConfigMap

In order to abstract the Configuration Properties out of the Runtime environment, OpenShift offers the notion of ConfigMaps. These artifacts will be used by the Camel Routes.

In order for the Pod to connect to the correct environment, we first need to upload the configmap. This can be done using the  
**deployYaml.sh **script that is located in the Solutions Directory.

---

## Console Login

First you need to connect to your OpenShift Environment.![](/assets/ocpLogin.png)

URL: [https://192.168.64.2:8443](https://192.168.64.2:8443)** **\(please replace the IP with your environment\)  
Username: **openshift-dev                            
**Password: **devel**

---

## Overview Status

The Overview window should be reflecting the following situation where the AMQ Pod and the puzzlestarter are running.![](/docs/assets/ocpboxoverview.png)

---

## Add to Project

Perform the following steps:

* Select the Add to project link which is located Top Center in the browser window
* Select the Java Language
* Select **s2i-karaf2-camel-log**![](/docs/assets/ocpboxcamelloginit.png)

name: **puzzlebox                      
**Git URL: [https://github.com/tdeborge/FIS-Workshop-Yasumi.git](https://github.com/RedHatWorkshops/FIS-Demo-Workshop-Yasumi.git)  
Git Reference: **master**  
Service Name: **puzzlebox**  
Maven Build Directory:

![](/docs/assets/ocpboxkarafparameters1.png)

#### LEAVE THE MAVEN BUILD DIRECTORY EMPTY!!!

Provide the CPU and Memory Limits:

![](/docs/assets/ocpboxkaraflogrequirements.png)

**Hit the Create Button**![](/docs/assets/ocpboxcreated.png)

---

## Overview Window after Creation

![](/docs/assets/ocpblockguicreation.png)As you notice, there is no deployment going on ... The reason for this is that something did not work out correctly and we  will need to fix this.

---

## Assembly Failed

![](/docs/assets/ocpboxassemblyfailed.png)in order to solve this issue, select the puzzlebox link and select the action to edit the build.

In this window, select the **advanced options **and you will notice that the Context Dir field is empty. As we are building from a subdirectory, we can set it to the correct value here:

Context Dir:** /Labs/Lab 4/Solution/PuzzleBox**

![](/docs/assets/ocpfixcontextdir.png)Once this change is in, select the save button on the bottom.

![](/docs/assets/ocpboxstartbuild.png)

Then select the **Start Build** option

---

## Select View Log on Build![](/docs/assets/ocpboxbuildlog.png)

---

## Build Finished View

![](/docs/assets/ocpblockfinishedandfixed.png)

These steps have created a running pod that is connected to our AMQ Broker that is defined in the previously uploaded ConfigMap \(Yaml file\).

---

## Conclusion

In the deployment process we are missing a crucial field to provide the Context Directory. Once this is Fixed, the build works fine and the container is deployed.![](/docs/assets/ocpboxpodrunning.png)

