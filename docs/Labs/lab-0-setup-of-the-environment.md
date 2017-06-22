# Setting up the Lab Environment

In this section we need to make sure that all machines are setup and configured to talk to the OCP instance of choice.

In the Red Hat Workshop locations, you will find instructions that provide you with the needed variable values to continue. All Software will be installed upfront.

## Labs and Solutions

From the **git URL, **clone the environment to your local drive.

```
#Go to your home directory
cd
git clone https://github.com/RedHatWorkshops/FIS-Demo-Workshop-Yasumi.git FISLAB
cd FISLAB
```

When inspecting the FISLAB directory structure, you will find a Labs directory that will contain all sections \(labs\) we can touch upon. Each Lab sub-directory contains an exercise part that you will be able to complete and execute and a Solutions part that you can use to skip the step-through in the exercise part.

## Environment Configuration

In order to get some scripts working, it is important to make adjustments to the following file:

FISLAB/Labs/setenv.sh

```
#!/bin/sh
#PLEASE VALIDATE THE IP
export OCP_IP=
export USERNAME=
export PASSWORD=
```

### Workshop At Red Hat:

These variables will then be used in the scripts to get to your specific environment which is provided in the class.

