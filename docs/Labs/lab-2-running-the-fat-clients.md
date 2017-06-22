# GUI Clients

This Lab is **Optional** and depending on time constraints can be skipped.

This part of the lab will give you a quick instruction set on how to get the Java clients started.

As this is basic Java compilation and execution, we are not going to set anything up in the Developer Workbench for this.

### Setup the Environment

In the Lab 2 directory, you will find 2 Project Directories. The approach to run the applications is identical and for that reason we are only going to write instructions for the GUIMonolithic application.

### Build the application

In order to build this application \(this is similar for GUIScaleUp\):

* Open a command line
* Go into the application you want to run:
   **`cd <git clone location>/Labs/Lab 2/Solution/GUIMonolithic`**
* run the maven command: 
  **`mvn clean package`**

### Run the application

In the project directory:

* Go to the target directory: 
  **`cd target`**
* execute the java command:   
  **`java -jar GUIMonolithic-1.0.0-SNAPSHOT-jar-with-dependencies.jar`**  
  ![](/docs/assets/blankGui.png)

* Click on the **New Interactive** Button to start the puzzler.

# Highlights

### POM file

The pom file for these projects are simple builders ... the extra that is introduced here is the following build plugin:

```
            <plugin>
                <artifactId>maven-assembly-plugin</artifactId>
                <version>2.2-beta-5</version>
                <executions>
                    <execution>
                        <id>assemble-jar-with-dependencies</id>
                        <goals>
                            <goal>single</goal>
                        </goals>
                        <phase>package</phase>
                    </execution>
                </executions>
                <configuration>
                    <archive>
                        <manifest>
                            <mainClass>com.rhemea.puzzler.blocks.gui.GPuzzle</mainClass>
                        </manifest>
                    </archive>
                    <descriptorRefs>
                        <descriptorRef>jar-with-dependencies</descriptorRef>
                    </descriptorRefs>
                </configuration>
            </plugin>
```

This plugin creates a Jar file that contains all dependent libraries and defines the main class for the manifest.

## Application

The application logic was written in 2001. This has been a long time ago so if you have questions around some programming techniques I used back then, I would not have a clue anymore as to why I decided to do it in that way ... ;\)

