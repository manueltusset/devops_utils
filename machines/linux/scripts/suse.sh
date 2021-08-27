#!/bin/bash

osVersion=$(grep '^VERSION=' /etc/os-release)

zypper update -y
zypper in -y unzip
zypper in -y vim

cd /usr/local/se/src

zypper addrepo -f http://download.opensuse.org/distribution/leap/42.1/repo/oss/ OSS
zypper addrepo -f http://download.opensuse.org/distribution/leap/42.2/repo/oss/ OSS2
zypper refresh

zypper in -y autoconf automake bison flex fontconfig-devel \
             freetype-devel gcc gcc-c++ ghostscript-fonts gperf \
             libicu-devel libjpeg8-devel libmcrypt-devel libpng12-devel \
             libtool libxml2-devel make net-tools libopenssl-devel \
             pcre-devel postgresql-devel psmisc re2c readline-devel \
             ruby unixODBC-devel wget libaio1
