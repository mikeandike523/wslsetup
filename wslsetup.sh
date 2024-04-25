#!/bin/bash

# Exit on error
set -e

# Update and upgrade the package list
sudo apt-get update
sudo apt-get upgrade -y

# Install Python 3.12 and python3.12-venv
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get update
sudo apt-get install python3.12 python3.12-venv -y

# Ensure pip is installed and upgraded
sudo python3.12 -m ensurepip --upgrade

# Install software-properties-common for adding repositories
sudo apt-get install software-properties-common

# Install Node.js and npm
# Using NodeSource's binary distributions
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get install -y nodejs

sudo npm install -g npm@latest

# Verify the installation of Node.js and npm
node --version
npm --version

# Install Yarn globally using npm
sudo npm install --global yarn

# Verify Yarn installation
yarn --version

# Setup the folders recommended for single-user software installation
# We use single-user isntallation since we dont want to be forced to run it as sudo
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/bin"


# Install custom tool "gitsleuth"
cd "$HOME/.local/share"
git clone https://github.com/mikeandike523/gitsleuth
cd gitsleuth
python3.12 -m venv pyenv
pyenv/bin/python3 -m pip install -r requirements.txt
rm -f "$HOME/.local/bin/gitsleuth"
ln -s "$HOME/.local/share/gitsleuth/gitsleuth" "$HOME/.local/bin/gitsleuth"

# Install custom tool "tsleuth"
cd "$HOME/.local/share"
git clone https://github.com/mikeandike523/tsleuth
cd tsleuth
yarn install
# hotfix, I actually need to go back to the tsleuth repo and add the dependency
yarn run build-all
rm -f "$HOME/.local/bin/tsleuth"
ln -s "$HOME/.local/share/tsleuth/tsleuth" "$HOME/.local/bin/tsleuth"

# Install custom tool "eolinuxify"
cd "$HOME/.local/share"
git clone https://github.com/mikeandike523/eolinuxify
cd eolinuxify
./configure
rm -f "$HOME/.local/bin/eolinuxify"
ln -s "$HOME/.local/share/tsleuth/eolinuxify" "$HOME/.local/bin/eolinuxify"

# test installations
gitsleuth --help
tsleuth --help
eolinixufy --help

echo "All installations are complete"

# usage

# cd ~
# curl https://raw.githubusercontent.com/mikeandike523/wslsetup/main/wslsetup.sh -o wslsetup.sh 
# bash wslsetup.sh 
# rm -f wslsetup.sh

# -------------------------------

# Note:

# to get a clean slate on wsl

# open terminal with admin perms

# wsl unregister ubuntu

# go to the start menu and type in ubuntu to open ubuntu back up

# ubuntu will be reinstalled

# it will prompt you to make your in-wsl user account again

# use the same credentials as you did previously