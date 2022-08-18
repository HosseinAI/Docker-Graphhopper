# Docker-Graphhopper
## Table of contents
* [Project Description](#Project-Description)
* [Technologies](#technologies)
* [Setup](#setup)
* [Use the Project](#Use-the-Project)

## Project Description
This project is all about containerizing Graphhopper for a region in docker, so it can be ran independently consuming a certain amount of resources on cloud such as Azure, Aws or Google Cloud. 
In order to make it simple and straight forward, I will deploy only the Great Britain map but you can just replace the Osm file with your own one. 

## Technologies


What you need to get this setup working is listed as below. I tried to associate them with a link so you can easily click and get directed to the pre-requesits. 

* Docker Acount (https://hub.docker.com/signup)
* Docker Application (https://www.docker.com/get-started/)

## Setup
1- Download your Osm map file in Pbf format from (https://download.geofabrik.de/index.html).

Or you can use the query below to get it downloaded:
```
mkdir -p ~/<user>/Osm-File/UK/
cd ~/<user>/Osm-File/UK/
wget https://download.geofabrik.de/europe/great-britain-latest.osm.pbf
```
you can mode the osm file to where ever you are comfortable, remember you need the directory to this file later on. 

2- We need .yml config to get the osm file encoded via java. You can find a sample of this yml file in this repo but you can modify it to meet your requirments. In case you are using a different osm file than mine, change the name of the osm file in config. Also, the yml is appropriate for cars. If you need foot walk or cycling, please change the configration as explained here (https://github.com/graphhopper/graphhopper/blob/master/config-example.yml).

3- Generate a bash runnable file to be runned when starting the container. It will be the container entrypoint basically. The bash file is created and can be found in the repo. You only need to change the version of Graphhopper and the heap size in case that yours is different. The below size enough for extracting UK map but if your map is larger, you can increase that numbers.
```
-Xmx2048m -Xms1024m
```

4- Generate a docker file using notepad. A dockerfile is already included in the repo for the graphhopper web version 3. You can change the version with a newer or older versions that are available over here (https://graphhopper.com/public/releases/). 

5- Copy all the necessary files into a working directory and open a terminal window in the working directory. Run the below command to create the docker image:
```
docker build -t graph-uk-image .
```
Then create the docker container out of the image using the below command:
```
docker run -d --name=graph-uk-container -v <Osm Directory>:/opt/graphhopper/data -p 127.0.0.1:8989:8989 graph-uk-image /opt/graphhopper/starter.sh
```
Please note you can change the name of the image, name of the container, and the port if you want. remember to replace <Osm Directory> with your osm file directory. 

6- Check out the outcome of the process using:
```
docker logs -f graph-uk-container
```
In situation where it is running successfully, you should see a big GRAPHHOPPER sign on the terminal. In case you faced any issues, you need to read through the exception and get it solved. The main issues are with the heap size( ran out of memory), files directory (files not found and) and encoding config which easily can be solved by looking at the process once again and corecting the directories, reviewing the config file and the bash file as well. For the first time it should take almost half an hour to extract the map but for the scond time it will take mss. 

## Use the Project
In order to remove the container to fix the issues, you need to run the below commands for tremoving the container and it's image first. 
```
docker rm graph-uk-container

docker rmi graph-uk-image
```
In case your project run successfully, you can give it a try and see if it return the right information by passing two points by an APi request. 
Open the localhost:8989 and you should be able to reach out to graphhopper.
