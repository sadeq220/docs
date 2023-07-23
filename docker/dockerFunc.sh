#!usr/bin/env bash

searchInRegistry(){
local dockerImageName=${1:-ubuntu}
# "is-official" to return only official image builds
docker search --filter is-official=true "$dockerImageName"
}

runContainer(){
	local dockerContainerName=${2:-test}
	local dockerImageName=${1:-acme/my-final-image}
	# --rm to remove container after it has stopped
	#
docker run --rm -dit --name "$dockerContainerName" "$dockerImageName" bash
}

useContainer(){
	local dockerContainerName=${1:-test}
  docker exec -it "$dockerContainerName" bash
}
