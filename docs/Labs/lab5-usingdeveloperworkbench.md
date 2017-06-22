# Using the Developer Workbench

In this Lab, we will be starting the Developer Workbench and import an existing Project. Then we will make some adjustments, deploy it using the mvn fabric8 plugin and view the deployment in the workbench using the OpenShift View Plugin.

## Starting the Workbench

Locate the JBoss Developer WorkBench and start it up.

![](/assets/workbenchStartUp.png)

---

### Integration Stack

When working with Fuse, it could be interesting to install the JBoss Fuse Development Stack \(is probably already done\)

![](/assets/jbdevfusestack.png)

---

## Importing the Exercise

![](/assets/jbodimportproject.png)

Import an existing Maven Project

![](/assets/jbodimportyasumiexercise.png)

Import the Exercise directory in Lab 5.

![](/assets/jbodprojectimportview.png)

As a result the project is imported.

---

## Install the OpenShift Explorer View

From the Menu bar, select the **Window - Show view - Other** option:

![](/assets/jbodshowviewother.png)

In the filter box, filter on open and select the OpenShift Explorer.

---

## Configure OpenShiftExplorer

Locate the Explorer View and either select a new connection wizard or select the option to **Sign in to OpenShift**

![](/assets/jbodopenshiftviewlogin.png)

---

## The View

Once you establish the connection, you get the following:

![](/assets/jbodopenshiftviewresult.png)By right-clicking on the different components you can now see how you can easily edit configurations, and do basic operations on the OpenShift Instance from within the Developer Workbench.

---

### Developer Workbench Possibilities

![](/assets/jbodocptoolingopenshift.png)

Using the tooling, you can:

* Create new connections to other OpenShift instances
* Create new Projects within the connected instance
* Create Applications within these Projects
* Upload JSON resource files

Other options you will be able to use are related to:

![](/assets/jbodocptoolingview2.png)

* Scaling the pod instances
* Looking at pod log contents
* Editing the configurations
* Defining Environment Variables

---

## Finishing the Calculator Service

In order to move through the important files and reflecting on the purpose, we have commented out a few lines. Running through the list will make the deployment work.

---

## Camel Route

When the Fuse workbench plugins are installed, you have a visual editor to manipulate the Camel Routes.

Open the file: PuzzleCalculator/src/main/resources/OSGI-INF/blueprint/FuseYasumiPuzzleBoxCalculator.xml

![](/assets/jbodocpcalcopenproject.png)

When in Design mode, the canvas is showing the following:

![](/assets/jbodocpcanvassimple.png)

Next, go into the Source view and uncomment the **BoxProcessor** Route

Switching back to the Design View, the Canvas now looks like:![](/assets/jbodocpcanvascomplex.png)Save the file ... \(in case there are questions around the route, we can address those off-line\).

---

## Local Configuration

The file /PuzzleCalculator/src/main/resources/assembly/etc/com.rhworkshop.msa.yasumipuzzleboxcalculator.cfg contains information that can be used in case we want to deploy this Route into a standalone OSGI \(karaf\) environment.![](/assets/jbodsocpconfigurationfile.png)We are not going to change anything at this moment, it is just a thing to remember.

---

## Deployment Yaml

![](/assets/jbodocpdeploymentyaml.png)

The deployment yaml is the place where we are able to modify the way our deployment will be pushed out. please uncomment the lines in the file: /PuzzleCalculator/src/main/fabric8/deployment.yml

* replicas to define the number of Pods will be spinning up
* resources - requests to define the minimum cpu and memory allocations are needed
* resources - limits to define the maximum allowed resource allocation

---

## Calculator YAML

/PuzzleCalculator/src/main/fabric8/yasumipuzzleboxcalculator.yaml

![](/assets/jbodocpyamlcalculator.png)

Uncomment the lines in this file to:

* Make the Camel Route connect to the AMQ instance using the Internal Address within the OpenShift Cluster
* Make use of the defined username
* Make use of the defined password

---

## Build Local

Next step is to build a local version using the Developer Workbench. This is provided that your maven settings within the Workbench are aligned.

Right-Click the Project, select Run-As then select the Run As Maven Build ...

![](/assets/jbodsocprunasmvnbuild.png)

In the dialog that follows:

![](/assets/jbodsocpcleaninstall.png)

name: **PuzzleCalculator Local**  
Goals: **clean install**

Add a parameter that is:

name: **docker.skip.build**  
value: **true**

This will then build a local configuration without the Docker overhead. The reason to mention this is that local building and testing is faster compared to deploying it to CDK for testing.

---

## Deployment

For the deployment, you can create another Run As - maven build ... instance without the docker skip and as goals **clean fabric8:deploy.**

There is also the script that will perform the same execution ... however, the script is also installing the calculator yaml file with all the variables. So in order to have a clean installation, please use the script after adjusting the IP address for the OCP environment.

---

## Final situation

After the deployment, you will find the following situation in your OpenShift View:

![](/assets/jbodsocpfinaldeployment.png)

Which is mirroring the situation in the Overview Browser Window:

![](/assets/ocpdeployumentoverview.png)

