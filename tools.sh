#!/bin/bash

set -eu
if [ $(id -u) -ne 0 ]; then
  echo "This script must be run as root. Please use sudo."
  exit 1
fi
apt-get update -y
apt-get install -y git build-essential python3-pip python3-venv cmake \
silversearcher-ag clangd clang-format tree \
minicom gitk \
