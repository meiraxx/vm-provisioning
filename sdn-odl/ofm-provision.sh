#!/bin/bash

sudo apt-get update && sudo apt-get install

# update Locale error message
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo update-locale LANG=en_US.UTF-8

sudo apt-get -y install software-properties-common bash-completion
sudo apt-get -y install unzip
sudo apt-get -y install curl git


# curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo aptitude install -y npm

# Clean up cached packages
sudo apt-get clean all

git clone https://github.com/CiscoDevNet/OpenDaylight-Openflow-App.git
sed -i 's/localhost/10.10.10.2/g' ./OpenDaylight-Openflow-App/ofm/src/common/config/env.module.js
cd OpenDaylight-Openflow-App
sudo npm install -g grunt-cli


# now you should SSH to the VM
# and cd OpenDaylight-Openflow-App and run these:
# grunt
### "http://localhost:9000" will display.
