#!/bin/bash

# sudo apt-get -y update
sudo apt-get -y install build-essential unzip python3 python3-venv nfs-common
# sudo apt-get -y upgrade

# Mount /data
if [ ! -d "/data" ]; then
    echo "Mount /data"
    sudo mkdir -p /data
    sudo sh -c 'echo "aialgocommonpremfile.file.core.windows.net:/aialgocommonpremfile/fileshare      /data   nfs     defaults,vers=4,minorversion=1,sec=sys,nconnect=4        0       0" >> /etc/fstab' 
    sudo mount -a
fi
