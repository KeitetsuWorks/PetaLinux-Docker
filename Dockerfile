##
## @file        Dockerfile
## @brief       Dockerfile for PetaLinux
## @author      Keitetsu
## @date        2019/11/04
## @copyright   Copyright (c) 2019 Keitetsu
## @par         License
##              This software is released under the MIT License.
##

FROM ubuntu:18.04

LABEL maintainer="KeitetsuWorks@users.noreply.github.com"

##
## install PetaLinux dependencies
## http://dora.bk.tsukuba.ac.jp/~takeuchi/?%E9%9B%BB%E6%B0%97%E5%9B%9E%E8%B7%AF%2Fzynq%2FPetalinux%20%E3%81%AE%E3%83%93%E3%83%AB%E3%83%89
##
ENV DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        tofrodos \
        iproute2 \
        gawk \
        net-tools \
        libncurses5-dev \
        libncursesw5-dev \
        zlib1g:i386 \
        libssl-dev \
        flex \
        bison \
        libselinux1 \
        gnupg \
        wget \
        diffstat \
        chrpath \
        socat \
        xterm \
        autoconf \
        libtool \
        tar \
        unzip \
        texinfo \
        zlib1g-dev \
        gcc-multilib \
        build-essential \
        screen \
        pax \
        gzip \
        python2.7 \
        binutils \
        cpio \
        expect \
        file \
        fonts-noto-cjk \
        git \
        gosu \
        lib32z1-dev \
        libglib2.0-dev \
        libgtk2.0-0 \
        libsdl1.2-dev \
        libtool-bin \
        locales \
        lsb-release \
        ncurses-dev \
        sudo \
        u-boot-tools \
        vim \
        xvfb \
        bc \
        rsync && \
    apt-get clean && \
    apt-get autoclean && \
    ln -fs /bin/bash /bin/sh && \
    \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/* && \
    rm -rf /var/lib/apt/lists/*

##
## locale settings
##
RUN locale-gen en_US.UTF-8 && \
    update-locale
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

##
## vim settings
##
RUN cd ~ && \
    git clone --depth 1 https://github.com/tomasr/molokai.git && \
    mkdir -p ~/.vim/colors && \
    mv ./molokai/colors/molokai.vim ~/.vim/colors && \
    rm -rf ./molokai && \
    git clone --depth 1 https://github.com/KeitetsuWorks/VimSettings.git && \
    mv ./VimSettings/.vimrc ~ && \
    rm -rf ./VimSettings && \
    sed -i -e "/^colorscheme.*/i set t_Co=256" .vimrc && \
    cp -r ~/.vim /etc/skel && \
    cp ~/.vimrc /etc/skel

##
## Xilinx PetaLinux settings
##
COPY files/init_petalinux.sh /usr/local/bin/init_petalinux.sh
RUN chmod +x /usr/local/bin/init_petalinux.sh && \
    echo '. /usr/local/bin/init_petalinux.sh' >> /etc/skel/.bashrc

##
## make installation directory
##
RUN mkdir -p /opt/Xilinx/PetaLinux

##
## ENTRYPOINT settings
##
COPY files/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash", "-l"]

