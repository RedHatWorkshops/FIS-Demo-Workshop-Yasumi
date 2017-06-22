## Start Developer Studio:

### Import Main Project

In the File menu, select the import option and import existing maven projects![](/assets/importmavenprojects.png)

Go to the directory where you have checked out LAB2:   

![](/assets/checkoutDir.png)

And import the project.

### Create PuzzleStarter

Create a new Project based on the Maven Module Wizard:

![](/assets/MavenModuleWizard.png)

Select next.

insert '**fis**' into the filter and look for the correct archetype:![](/assets/Archetype.png)

Select the karaf2-camle-log-archetype and hit next.

![](/assets/mavenmoduleids.png)

Provide a meaningfull GroupId and set the Version to 1.0.0-SNAPSHOT

After these steps, your project explorer should look as follows:

![](/assets/fisprojectexplorer1.png)

Make sure to work on the PuzzleStarter Project and not in the FISYasumiWorkshop Project \(which is the master directory\).

### Adjust the Project Files

In the Main project, you will find the SupportMaterials for LAB2:

\[\[INSERT IMAGE FOR SUPPORT FILES HERE\]\]

### Preparing the project:

**Delete the content under the following directories:**

![](/assets/deletedResourceProgram.png)

src/main/java/\*  
src/main/resources/\*  
src/test/java/\*  
src/main/fabric8/\*

**Copy the following sections:**

SupportMaterials/LAB2/ProjectFiles/src/main/java/\* **to** src/main/java  
SupportMaterials/LAB2/ProjectFiles/src/main/fabric8/\* **to** src/main/fabric8  
SupportMaterials/LAB2/ProjectFiles/src/main/resources/\* **to** src/main/resources

### File Highlights:

**src/main/java/\*                  
**This section holds all the objects needed for the Puzzler Solution and defines some processors for the Camel Routes.

**src/fabric8/deployment.yml **  
This file defines all the deployment options for the Pod that will hold the Puzzle Starter. The currently used content defines a minimum on settings.

**src/main/fabric8/yasumipuzzler.yaml**  
This Yaml file contains the externalized properties that are used in the Camel Route Definition. In Fuse Standalone, this content would be located in a cfg file.

**src/main/resources/assembly/etc/com.rhworkshop.msa.yasumipuzzler.cfg**  
This is the properties configuration file that can be used when running the solution in standalone mode.

**src/main/resources/OSGI-INF/blueprint/FuseYasumiPuzzler.xml                
**![](/assets/camelpuzzlestarter.png)  
This Camel Route Definition file holds the logic that will be deployed in the Karaf Container.

### POM File Changes

Open the project POM file and insert the following lines:  
**&lt;feature&gt;fabric8-karaf-cm&lt;/feature&gt;  
&lt;feature&gt;camel-jms&lt;/feature&gt;  
&lt;feature&gt;activemq-camel&lt;/feature&gt;**

```
<!-- 2. create karaf assembly -->
            <!-- karaf-maven-plugin creates custom microservice distribution -->
            <plugin>
                <groupId>org.apache.karaf.tooling</groupId>
                <artifactId>karaf-maven-plugin</artifactId>
                <version>${karaf.plugin.version}</version>
                <extensions>true</extensions>
                <executions>
                    <execution>
                        <id>karaf-assembly</id>
                        <goals>
                            <goal>assembly</goal>
                        </goals>
                        <phase>install</phase>
                    </execution>
                </executions>
                <configuration>
                    <!-- we are using karaf 2.4.x -->
                    <karafVersion>v24</karafVersion>
                    <useReferenceUrls>true</useReferenceUrls>
                    <archiveTarGz>false</archiveTarGz>
                    <includeBuildOutputDirectory>false</includeBuildOutputDirectory>
                    <startupFeatures>
                        <feature>karaf-framework</feature>
                        <feature>shell</feature>
                        <feature>jaas</feature>
                        <feature>camel-jms</feature>
                        <feature>activemq-camel</feature>
                        <feature>aries-blueprint</feature>
                        <feature>camel-blueprint</feature>
                        <feature>fabric8-karaf-blueprint</feature>
                        <feature>fabric8-karaf-checks</feature>
                        <feature>fabric8-karaf-cm</feature>
                    </startupFeatures>
                    <startupBundles>
                        <bundle>mvn:${project.groupId}/${project.artifactId}/${project.version}</bundle>
                    </startupBundles>
                </configuration>
            </plugin>
```

### Initial Local Build

As we are interested in first building and testing all local, we will perform the following command:

mvn clean install -Ddocker.skip.build=true

When all the correct features are included in the build script, the build should complete successful.

