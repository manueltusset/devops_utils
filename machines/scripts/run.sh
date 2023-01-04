#!/bin/bash
set -ex

if [[ -f /scripts/custom/custom.sh ]]; then
    bash /scripts/custom/custom.sh || true
fi