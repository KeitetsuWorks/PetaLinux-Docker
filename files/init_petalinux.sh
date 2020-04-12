#!/bin/bash -eu

##
## @file        init_petalinux.sh
## @brief       Script to initialize PetaLinux
## @author      Keitetsu
## @date        2019/11/04
## @copyright   Copyright (c) 2019 Keitetsu
## @par         License
##              This software is released under the MIT License.
##

if [ -f /opt/Xilinx/PetaLinux/settings.sh ]; then
    . /opt/Xilinx/PetaLinux/settings.sh
fi

