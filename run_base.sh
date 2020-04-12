#!/bin/bash -eu

##
## @file        run_base.sh
## @brief       Script to run the PetaLinux Docker Image
## @author      Keitetsu
## @date        2019/11/04
## @copyright   Copyright (c) 2019 Keitetsu
## @par         License
##              This software is released under the MIT License.
##

xhost +local:root

docker run \
    --interactive \
    --tty \
    --net host \
    --rm \
    --name petalinux \
    --env TZ=Asia/Tokyo \
    --env DISPLAY=${DISPLAY} \
    --env QT_X11_NO_MITSHM=1 \
    --env HOST_USER=${USER} \
    --env HOST_UID=$(id -u ${USER}) \
    --env HOST_GROUP=${USER} \
    --env HOST_GID=$(id -g ${USER}) \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --volume /data1/Software/Xilinx:/data \
    keitetsu/petalinux:ubuntu16.04-base
