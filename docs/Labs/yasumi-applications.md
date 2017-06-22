# Yasumi Application Scaling

## Available Yasumi Applications

We have included 2 Java Applications in the Cloned repository. These are located under the **GUIMonolithic** and **GUIScaleUp** directories.

![](/assets/mirrorSolutions.png)

This will show the following growth paths![](/assets/ScalingOptions.png)

### GUIMonolithic - Vertical Scaling

This application is exactly the same as the one we have been running in 2001 on the PentiumIII machines with JDK1.2.

We have not changed the code and as such we can compare what new versions of Java in combination with better CPU power can bring to **VERTICAL Scaling**. This shows that we can become more performant with better CPU power. As a comparison, the program that took around 20 minutes on the P3 is now taking just over 1 minute on the mcBookPro i7.

### GUIScaleUp - Horizontal Scaling

The GUIScaleUp application enhanced the initial Monolithic approach and is using multiple Threads to perform the calculation. The monolithic application is only using 2 Java Threads to operate. 1 Thread is used for display and 1 Thread for Calculation purposes. The ScaleUp application is using the concurrent possibilities of the newer Java implementations.

This approach is showing the **HORIZONTAL Scaling** where more CPU's will get the job done in a better time. This application is finishing the job in around 25 seconds on the i7.

### FIS-Gui - Scale Out![](/assets/yasumiScaleOut.png)

The last application that we will be building during the workshop, will allow us to Scale Out and make use of machine resources that are not local to the application. We will be using AMQ as messaging broker in order to request and receive the puzzle solutions. We will further split our application MSA over 3 different responsibilities and each will be deployed in its own POD so they can be scaled independently.

* Puzzle Starter
  This application will just receive the request message and prepare 8 basic puzzle blocks

* PuzzleBox  
  This application is receiving the 8 starter blocks and will validate if they are allowed to move furter

* PuzzleCalculator  
  This is a recursive application that will calculate the solutions, and forward it until  a solution is found. In case a solution is not valid, it is dropped from the stack.

## Conclusion

Given these 2 monolithic applications, it is showing how CPU/Memory power can give you better performance however, what if we still need to go faster? What if we would like to have a RBPI showing the results?

Having a Monolithic Solution will give you problems along the way of growth. For that reason, we thought it would be a good opportunity to create a ScaleOut version of the Application. For a first try we have focussed on having a solution using Fuse Integration Services that can be scaled out on OpenShift.

