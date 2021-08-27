#!/bin/bash

osVersion=$(grep '^VERSION=' /etc/os-release)

yum update -y
yum install unzip -y
yum install vim -y

cd /usr/local/se/src

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y autoconf automake bison bzip2 \
               dejavu-fonts-common dejavu-sans-fonts dejavu-serif-fonts \
               flex fontconfig-devel freetype-devel gcc gcc-c++ \
               ghostscript-fonts gperf libaio libfontenc \
               libicu-devel libjpeg-devel libmcrypt-devel \
               libpng-devel libtool libXfont libxml2-devel \
               make net-tools openssl-devel pcre-devel \
               postgresql-devel psmisc re2c readline-devel \
               sqlite-devel unixODBC-devel wget xorg-x11-font-utils \
               libaio libaio-devel