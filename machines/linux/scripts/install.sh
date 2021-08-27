#!/bin/bash

osRelease=$(cat /etc/os-release)

echo "==============================="
echo "${osRelease}"
echo "==============================="

mkdir /usr/local/se
mkdir /usr/local/se/src
mkdir /usr/local/se/apps

cd /usr/local/se

case ${osRelease,,} in

  *"red hat"*)
    bash /scripts/redhat.sh    
    ;;
  *"ubuntu"*)
    bash /scripts/ubuntu.sh
    ;;
  *"centos"*)
    bash /scripts/centos.sh
    ;;
  *"suse"*)
    bash /scripts/suse.sh
    ;;
  *"debian"*)
    bash /scripts/debian.sh
    ;;
esac