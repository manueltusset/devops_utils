#!/bin/bash

osVersion=$(grep '^VERSION=' /etc/os-release)

apt-get update -y
apt-get install unzip -y
apt-get install vim -y

cd /usr/local/se/src

cp /etc/apt/sources.list /etc/apt/backup.sources.list
rm -rf /etc/apt/sources.list

echo "deb http://us.archive.ubuntu.com/ubuntu/ xenial main restricted
deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates main restricted
deb http://us.archive.ubuntu.com/ubuntu/ xenial universe
deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates universe
deb http://us.archive.ubuntu.com/ubuntu/ xenial multiverse
deb http://us.archive.ubuntu.com/ubuntu/ xenial-updates multiverse
deb http://us.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu xenial-security main restricted
deb http://security.ubuntu.com/ubuntu xenial-security universe
deb http://security.ubuntu.com/ubuntu xenial-security multiverse" > /etc/apt/sources.list

apt-get update -y
apt-get install -y autoconf automake bison gcc libcurl4-openssl-dev \
                   libfreetype6-dev libjpeg-dev libmcrypt-dev libodbc1 \
                   libpcre3 libpcre3-dev libpng-dev libreadline-dev libssl-dev \
                   libtool libxml2-dev make net-tools openssl pkg-config postgresql \
                   psmisc re2c unixodbc-dev wget libpq-dev build-essential g++ flex \
                   bison gperf ruby perl libsqlite3-dev libfontconfig1-dev libicu-dev \
                   libfreetype6 libssl-dev libpng-dev libjpeg-dev python libx11-dev \
                   libxext-dev libaio1 libaio-dev