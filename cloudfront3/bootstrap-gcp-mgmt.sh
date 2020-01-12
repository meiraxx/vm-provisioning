#!/usr/bin/env bash
sudo apt-get update

# install tools for managing ppa repositories
sudo apt-get -y install software-properties-common
sudo sudo apt-get -y install unzip vim
sudo apt-get -y install build-essential libssl-dev libffi-dev python-pip python3-pip

# Add graph builder tool for Terraform
sudo sudo apt-get -y install graphviz

# install Ansible (http://docs.ansible.com/intro_installation.html)
sudo apt-add-repository -y --update ppa:ansible/ansible
# update cache with new repositories data
sudo apt-get update
sudo apt-get -y install ansible

# Install Terraform
wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
sudo unzip terraform_0.11.10_linux_amd64.zip -d /usr/local/bin
rm terraform_0.11.10_linux_amd64.zip


# add Google Cloud SDK
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install -y --allow-unauthenticated google-cloud-sdk
snap install google-cloud-sdk --classic

# clean up cached packages
sudo apt-get clean all

# update Locale error message
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
sudo update-locale LANG=en_US.UTF-8

# Copy special files into /home/vagrant (from inside the mgmt node)
sudo chown -R vagrant:vagrant /home/vagrant
# Preserve original Ansible configuration files
cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.org
cp /etc/ansible/hosts /etc/ansible/hosts.org
