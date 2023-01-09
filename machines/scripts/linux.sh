#!/bin/bash
set -ex

sudo su -

pathCustom="/vagrant/scripts/custom/custom.sh"

if [[ -f $pathCustom ]]; then
  bash $pathCustom
fi