# Starting the Client

Once all the PODs are deployed, it is time to test the environment and check if we can beat our 25 seconds defined goal.

---

## Compiling the Client

Go to the Github clone and perform the following:

* cd  Labs/Lab 6/Solution/FISGuiScaleOut
* Edit the file:

  * src/main/resources/resources/block.properties.

  * Locate the property:  
    **blocks.jms.url **and set its value to your exposed Broker.  
    ![](/docs/assets/exposedbrokeronamq.png)This is the hostname on the top-right of the YASUMI AMQ pane. Replace the http with **tcp** and add port **30616 **to it. The URL will look something like: **tcp://broker-amq-tcp-yasumi.shift.pc2017.local:30616**

  * From the Project Directory run: **mvn clean install**

---

## Running the Client

* Once the build is successfully done perform:  
  **java -jar target/FISGuiScaleout-1.0.0-SNAPSHOT-jar-with-dependencies.jar**

* Next the application should come up:  
  ![](/docs/assets/initialGUI.png)

* Then select the **New Interactive** button to start the puzzle

* Do some timeing

---

## Change some Parameters

As this is a big OpenShift Cluster, you can now use this system to perform some tests:

* put all pods on 1 replica and see what happens
* give the calculation pod at least 2 CPU to get the work done \(to get better results\)
* increase the number of calculation pods to 5
* Increase the pods to 25

In my testing, 10-12 seconds is the minimum range on this platform.



