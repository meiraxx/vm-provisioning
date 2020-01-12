#!/bin/bash

sudo apt-get update && sudo apt-get install

# update Locale error message
echo 'export LANG="en_US.UTF-8"' >> ~/.bashrc
echo 'export LC_ALL="en_US.UTF-8"' >> ~/.bashrc
echo 'export LC_CTYPE="en_US.UTF-8"' >> ~/.bashrc
source ~/.bashrc
sudo update-locale LANG=en_US.UTF-8

sudo apt-get -y install software-properties-common bash-completion

sudo add-apt-repository ppa:wireshark-dev/stable -y
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install wireshark
sudo addgroup -system wireshark
sudo chown root:wireshark /usr/bin/dumpcap
sudo setcap cap_net_raw,cap_net_admin=eip /usr/bin/dumpcap
sudo usermod -a -G wireshark $USER

sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer oracle-java8-set-default

# Clean up cached packages
apt-get clean all

echo 'JAVA_HOME="/usr/lib/jvm/java-8-oracle"' | sudo tee -a /etc/environment
source /etc/environment

# wget https://nexus.opendaylight.org/content/groups/public/org/opendaylight/integration/distribution-karaf/0.2.4-Helium-SR4/distribution-karaf-0.2.4-Helium-SR4.tar.gz -O odl-controller.tar.gz
# wget https://nexus.opendaylight.org/content/groups/public/org/opendaylight/integration/distribution-karaf/0.3.0-Lithium/distribution-karaf-0.3.0-Lithium.tar.gz -O odl-controller.tar.gz
wget -q https://nexus.opendaylight.org/content/groups/public/org/opendaylight/integration/distribution-karaf/0.4.0-Beryllium/distribution-karaf-0.4.0-Beryllium.tar.gz -O odl-controller.tar.gz
mkdir odl-controller
tar zxf odl-controller.tar.gz -C ./odl-controller --strip-components=1
rm odl-controller.tar.gz
sudo ./odl-controller/bin/start
sudo ./odl-controller/bin/client -u karaf -h localhost -r 7 "feature:install odl-dlux-all"
sudo ./odl-controller/bin/client -u karaf -h localhost -r 7 "feature:install odl-restconf-all"
sudo ./odl-controller/bin/client -u karaf -h localhost -r 7 "feature:install odl-openflowplugin-all"
sudo ./odl-controller/bin/client -u karaf -h localhost -r 7 "feature:install odl-l2switch-all"
sudo ./odl-controller/bin/client -u karaf -h localhost -r 7 "feature:install odl-mdsal-all"
sudo ./odl-controller/bin/client -u karaf -h localhost -r 7 "feature:install odl-yangtools-common"
