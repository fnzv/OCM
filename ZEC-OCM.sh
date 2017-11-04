#!/bin/bash
# Ubuntu 16.04 Server LTS - with Xorg
# Author: Sami Yessou

WALLET="Insert your wallet HERE"


# Install required packages
sudo apt-add-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get -y install nvidia-384 nvidia-smi lm-sensors screen python-pip
pip install gpustat

# Setup miner ENV
cd / && mkdir minerctl && cd minerctl
wget https://github.com/nanopool/ewbf-miner/releases/download/v0.3.4b/Zec.miner.0.3.4b.Linux.Bin.tar.gz
tar -xf Zec.miner.0.3.4b.Linux.Bin.tar.gz

# Enable persistence mode
nvidia-smi -pm 1

# Set PowerLimit to 75 W for all GPU cards (if not supported on some GPUs you need to manually set for each GPU)
nvidia-smi -pl 75

# Start FANS with Xorg settings
screen -S FAN-ON -d -m startx

# Start Miner
screen -S MINER-ON -d -m 0.3.4b/miner --server eu1-zcash.flypool.org --user $WALLET.rig --pass z --port 3333 --pec --log 2 --logfile /var/log/ewbf.log --tempunits C --templimit 85

