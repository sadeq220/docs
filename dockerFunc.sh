#!usr/bin/env bash

buildContainer(){
	dockerContainerName=${2:-test}
	dockerImageName=${1:-acme/my-final-image}
docker run --rm -dit --name $dockerContainerName $dockerImageName bash 
}

useContainer(){
	dockerContainerName=${1:-test}
docker exec -it $dockerContainerName bash
}
