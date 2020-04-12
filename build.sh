#!/bin/bash -eu

##
## @file        build.sh
## @brief       Script to build the Docker Image
## @author      Keitetsu
## @date        2019/11/04
## @copyright   Copyright (c) 2019 Keitetsu
## @par         License
##              This software is released under the MIT License.
##

docker build \
    --tag keitetsu/petalinux:ubuntu16.04-base \
    .

