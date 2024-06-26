#!/bin/bash

set -eu
if [ $(id -u) -ne 0 ]; then
  echo "This script must be run as root. Please use sudo."
  exit 1
fi
echo "Install arm tool chain..."
pushd /opt/
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
ARM_DIR="arm_tool_chain"
ARM_TAR="$ARM_DIR.tar.xz"
ARM_NAME="arm-gnu-toolchain-13.2.Rel1-aarch64-arm-none-eabi"
ARM_URL="https://developer.arm.com/-/media/Files/downloads/gnu/13.2.rel1/binrel/$ARM_NAME.tar.xz?rev=17baf091942042768d55c9a304610954&hash=06E4C2BB7EBE7C70EA4EA51ABF9AAE2D" 
apt-get update -y
apt-get install -y stlink-tools
wget -O $ARM_TAR $ARM_URL 

mkdir -p "$ARM_DIR"
tar -xvf "$ARM_TAR" -C "$ARM_DIR"

echo "export PATH=$PATH:/opt/$ARM_DIR/$ARM_NAME/bin">>$USER_HOME/.bashrc
echo "arm toolchain installed, source your ~/.bashrc"


popd
