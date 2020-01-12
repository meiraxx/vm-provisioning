#!/bin/bash

sudo apt-get update && sudo apt-get install

# update Locale error message

echo 'export LANG="en_US.UTF-8"' >> ~/.bashrc
echo 'export LC_ALL="en_US.UTF-8"' >> ~/.bashrc
echo 'export LC_CTYPE="en_US.UTF-8"' >> ~/.bashrc
source ~/.bashrc
sudo update-locale LANG=en_US.UTF-8

sudo apt-get -y install software-properties-common bash-completion
sudo apt-get -y install unzip
sudo apt-get -y install curl git

sudo add-apt-repository ppa:wireshark-dev/stable -y
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install wireshark
sudo addgroup -system wireshark
sudo chown root:wireshark /usr/bin/dumpcap
sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
sudo usermod -a -G wireshark $USER

git clone git://github.com/mininet/mininet.git
git checkout 2.3.0d4
./mininet/util/install.sh -fnv



# CMD to run mininet
# sudo mn --controller=remote,ip=10.10.10.2,port=6653 --topo=linear,3
# sudo mn --topo=linear,3 --controller=remote,ip=10.10.10.2,port=6653 --switch ovsk,protocols=OpenFlow13
# where 10.10.10.2 should be substituted by ODL controller IP, 6653 is standard port to connect mininet to ODL
