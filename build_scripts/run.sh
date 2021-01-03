#!/bin/bash

CD=$(dirname $(readlink -f $BASH_SOURCE))/../
cd $CD

docker build $CD -f $CD/Dockerfile -t synology_build_env

docker rm -f synology_build_env
mkdir -p $CD/synology/source/
docker run --rm --privileged --name synology_build_env -ti -v $CD/synology:/root/synology/ synology_build_env "$@"
