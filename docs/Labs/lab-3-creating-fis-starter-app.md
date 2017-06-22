# Creating the Puzzle Starter POD

In the Labs directory, you will find all relevant information in the exercise - solution - support directories.

# Hands-On:

As this is the first project for Fuse Integration Services, we will be building this completely from scratch \(and without the Developer Studio\). The reason for this approach is to get some practice going and understanding what the wizards in Developer Studio are doing for us.

## Preparation:

Open a shell and position yourself in the **Labs/Lab 3/exercise **directory**.**

## Creating a new Project

We will start off a new Project by using the Maven Archetype that is created for fis-karaf. The base project used for this approach is located [here](https://gitlab.com/rh-emea-ssa-fuse-tutorial/fis-configmap-karaf).

```
mvn org.apache.maven.plugins:maven-archetype-plugin:2.4:generate -DarchetypeCatalog=https://maven.repository.redhat.com/ga/io/fabric8/archetypes/archetypes-catalog/2.2.195.redhat-000007/archetypes-catalog-2.2.195.redhat-000007-archetype-catalog.xml -DarchetypeGroupId=org.jboss.fuse.fis.archetypes -DarchetypeArtifactId=karaf2-camel-log-archetype -DarchetypeVersion=2.2.195.redhat-000007
```

When executing this command \(ctrl-a and copy\), the following questions will come up \(Please fill in accordingly\):

---

Define value for property 'groupId': :** **`com.rhworkshop.msa`**                                              
**Define value for property 'artifactId': : `PuzzleStarter`  
Define value for property 'version': 1.0-SNAPSHOT: : `1.0.0-SNAPSHOT`  
Define value for property 'package': com.rhworkshop.msa: : ```      
Confirm properties configuration:      
groupId: com.rhworkshop.msa      
artifactId: PuzzleStarter      
version: 1.0.0-SNAPSHOT      
package: com.rhworkshop.msa      
Y: : **``Y\`\*\*

---

After a successful build, you will have now a project created called PuzzleStarter.![](/assets/puzzlestartercreated.png)

---

## Changing the created project

in the shell, go to the project directory:

---

#### `cd PuzzleStarter`

---

### Java Code/Libraries

First we will remove all generated code:

`rm -rf src/main/java/*`**  **

**  
**`rm -rf src/test/java/*`

Then copy all the Java Sources into place

`cp -r ../../support/src/main/java/* src/main/java`

---

### Local Configurations

In camel, we are using the PropertyPlaceHolder approach in order to externalize properties. With the type of project we are currently creating, we will have a standalone version \(running local on OSGI/Karaf\) and a version that can be deployed into OpenShift \(on Docker\). In case we need to have a local version with tailored variables, we need to copy the configuration file in the right location.

`cp ../../support/src/main/resources/assembly/etc/* src/main/resources/assembly/etc      
 cp -r ../../support/src/main/resources/resources src/main/resources/`

---

### OpenShift Configurations

The externalized properties in OpenShift are stored in a ConfigMap. This is a yaml file with the following content:

```
kind: ConfigMap
apiVersion: v1
metadata:
  name: yasumipuzzler
  labels:
    karaf.pid: com.rhworkshop.msa.yasumipuzzler

data:
  Puzzler.Start.Destination: qa.test.yasumi.start
  Puzzler.Stop.Destination: qa.test.yasumi.stop
  Puzzler.PuzzleBox.Destination: qa.test.yasumi.puzzlebox.start
  Puzzler.Forward.Destination: qa.test.yasumi.forwardEntry
  Puzzler.Solution.Destination: qa.test.yasumi.solutionEntry
  Puzzler.amq.BrokerURL: tcp://broker-amq-tcp:61616
  Puzzler.amq.Username: admin
  Puzzler.amq.Password: change12_me
  Puzzler.TestMessage: QA PUZZLER TESTING
  Puzzler.amq.tuning.concurrentConsumers: '1'
  Puzzler.amq.tuning.maxConnections: '1'
  Puzzler.amq.tuning.maximumActiveSessionPerConnectione: '50'
```

It is important that the **karaf.pid** identifier has the same value as defined in the Camel Route Property Placeholder PID.

in order to copy this file in the right location:

`cp ../../support/src/main/fabric8/*.yaml src/main/fabric8`

---

### Camel Route

The Camel Route Definitions is moved into place using the following lines:

`rm src/main/resources/OSGI-INF/blueprint/camel-log.xml      
cp ../../support/src/main/resources/OSGI-INF/blueprint/FuseYasumiPuzzler.xml src/main/resources/OSGI-INF/blueprint`

The following sections in the Camel Route File are important:

```
<cm:property-placeholder id="yasumipuzzler" persistent-id="com.rhworkshop.msa.yasumipuzzler" update-strategy="reload">
        <cm:default-properties>
            <cm:property name="Puzzler.Start.Destination" value="localhost.test.yasumi.start"/>
            <cm:property name="Puzzler.Stop.Destination" value="localhost.test.yasumi.stop"/>
            <cm:property name="Puzzler.PuzzleBox.Destination" value="localhost.test.yasumi.puzzlebox.start"/>
            <cm:property name="Puzzler.Forward.Destination" value="localhost.test.yasumi.forwardEntry"/>
            <cm:property name="Puzzler.amq.BrokerURL" value="tcp://localhost:61616"/>
            <cm:property name="Puzzler.amq.Username" value="admin"/>
            <cm:property name="Puzzler.amq.Password" value="admin"/>
            <cm:property name="Puzzler.TestMessage" value="LOCALHOST PUZZLER TESTING"/>
            <cm:property name="Puzzler.amq.tuning.maxConnections" value="5"/>
            <cm:property name="Puzzler.amq.tuning.maximumActiveSessionPerConnection" value="50"/>
            <cm:property name="Puzzler.amq.tuning.concurrentConsumers" value="1"/>
        </cm:default-properties>
    </cm:property-placeholder>
```

This part is defining default values for properties and making reference to an externalized file/location available uing the **persistent-id** reference

Further note is that referencing a property in the Camel Environment is done in 2 different ways.

When outside the camelContext \(mostly bean definitions\) we are using **${PROPERTY NAME}**

When inside the camelContext we are using ** { { PROPERTY\_NAME } } **

---

### POM file changes

#### Information Tags

Replacing the name and description:

```
<name>Puzzle Starter</name>
<description>Camel route to start off the Puzzler application</description>
```

### Feature Startup Definition

Locate the **karaf-maven-plugin** section and find the **startupFeatures **section.

In this section, add the following features:

```
<feature>camel-jms</feature>
<feature>activemq-camel</feature>
<feature>fabric8-karaf-cm</feature>
```

These features are enabling JMS in the karaf instance and allow the property resolution to happen.

---

### Building the Project

Once all the changes are made, we can execute a local build from the commandline:

`mvn clean install -Ddocker.skip.build=true`

The added parameter will prevent any docker images to be build.

---

### Inspecting the Build

Looking into the target directory, you will find an assembly subdirectory. This is basically a StandAlone Karaf environment that can be started with the bin/start command. This is not working in the current environment as there is no AMQ Broker running on port 61616 but if you would startup a local broker, the Route would connect and start running.

---

### Deployment

In order to deploy the project into the OpenShift Environment, copy the deployment script using the following:

`cp ../../support/deployPuzzleStarter.sh .`

Change the IP addres in the script to point to the OCP location. Then execute the script in the project directory:

`./deployPuzzleStarter.sh`

This script will:

* connect to the OpenShift environment with the openshift-dev user
* select the yasumi project as the active project
* Upload \(Create\) the yasumipuzzler.yaml ConfigurationMap
* Deploy the Project in the OpenShift environment using:
  * mvn clean fabric8:deploy

This approach will speedup the test deployments. The container image is build local on your machines using S2I and then this is passed as a reference to OpenShift where is is instantiated. This means that all your dependency management is handled locally.

---

### Environment Views

Once you have successfully executed these steps, you can use the OpenShift Console to see the following:

On the Overview Page, the PuzzleStarter Pod is added:![](/docs/assets/puzzlestarterpod.png)

Selecting the pod \(by clicking in the circle\) you can then see the details:![](/docs/assets/PuzzleStarterDetails.png)

On this screen you can then select the **Open Java Console** which will open the Jolokia overview where you can find all local information on the Camel Route\(s\).

![](/docs/assets/puzzlestarterCamelRoutes.png)

