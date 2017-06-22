# Cheat Sheet

This page provides a couple of cheat shortcuts:

# Lightning Speed

Here you find all the needed commands to make the workshop deploy, leaving step 6 to start testing.

* cd to your home directory
  * **`cd`**
* `git clonehttps://github.com/RedHatWorkshops/FIS-Demo-Workshop-Yasumi.gitFISLAB`

* **`cd FISLAB/Labs`**

* Edit the setenv.sh script to provide the needed global information: \(vi setenv.sh\)  
  `#!/bin/sh`

  `#PLEASE VALIDATE THE IP`

  `export OCP_IP=`

  `export USERNAME=`

  `export PASSWORD=`

* **`cd Lab 1/Solution;source configureAMQ.sh;cd ../..`**

* **`cd Lab 3/solution/PuzzleStarter;source deployPuzzleStarter.sh;cd ../../..`**

* **`cd Lab 4/Solution/PuzzleBox/;source deployPuzzleBox.sh;cd ../../..`**

* **`cd Lab 5/Solution/PuzzleCalculator/;source deployPuzzleCalculator.sh;cd ../../..`**

## External IP Access

Remember that the Puzzle Client is running outside the 'OCP Cluster' and as such needs external access. This is provided to the broker and can be found on the GUI:

![](/docs/assets/amqocpexternaladdress.png)

You will need to replace the **http** with **tcp** and add the port number **:30616**

