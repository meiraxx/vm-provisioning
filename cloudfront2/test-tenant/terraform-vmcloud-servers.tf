# Terraform Openstack (VM Cloud) multi tier deployment
# Author: Rafael Belchior - rafael.belchior@tecnico.ulisboa.pt
# Author: Rui Cruz - rui.s.cruz@tecnico.ulisboa.pt

# Elements of the cloud such as virtual servers,
# networks, firewall rules are created as resources
# syntax is: resource RESOURCE_TYPE RESOURCE_NAME
# https://www.terraform.io/docs/configuration/resources.html
# https://www.terraform.io/docs/providers/openstack/


# Creates an SSH keypair resource
# https://www.terraform.io/docs/providers/openstack/r/compute_keypair_v2.html

resource "openstack_compute_keypair_v2" "cloud-key" {
  name   = "cloud-key"
  public_key = "${file(var.ssh_key_public)}"
}


###########  Web Server 1   #############


resource "openstack_compute_instance_v2" "web1" {
  name            = "web1"
  image_name      = "Ubuntu-18.04-Latest"
  flavor_id       = "0"
  key_pair        = "${openstack_compute_keypair_v2.cloud-key.name}"
  security_groups = ["default", "${openstack_compute_secgroup_v2.sec_ingr.name}"]

  network {
    name = "${var.unique_network_name}"
  }

  network {
    name = "${openstack_networking_network_v2.backend_network.name}"
  }
}

# https://www.terraform.io/docs/providers/openstack/r/compute_volume_attach_v2.html
resource "openstack_blockstorage_volume_v2" "volume_1" {
  name = "volume_1"
  size = 1
}

resource "openstack_compute_volume_attach_v2" "va_1" {
  instance_id = "${openstack_compute_instance_v2.web1.id}"
  volume_id   = "${openstack_blockstorage_volume_v2.volume_1.id}"
}


###########  Web Server 2   #############
# REMOVED


###########  Database   #############


resource "openstack_compute_instance_v2" "dbase" {
  name            = "dbase"
  image_name      = "Ubuntu-18.04-Latest"
  flavor_id       = "0"
  key_pair        = "${openstack_compute_keypair_v2.cloud-key.name}"
  security_groups = ["default", "${openstack_compute_secgroup_v2.sec_ingr.name}"]

  network {
    name = "${openstack_networking_network_v2.backend_network.name}"
  }
}

###########  Bastion Balancer   #############

resource "openstack_compute_instance_v2" "bastionbal" {
  name            = "bastionbal"
  image_name      = "Ubuntu-18.04-Latest"
  flavor_id       = "0"
  key_pair        = "${openstack_compute_keypair_v2.cloud-key.name}"
  security_groups = ["default","${openstack_compute_secgroup_v2.sec_ingr.name}"]

  network {
    name = "${var.unique_network_name}"
  }
}



# What happens if you uncomment the following block? Why?

# provisioner "local-exec" {
#   command = "ansible-playbook -u ubuntu -i '${self.access_ip_v4}},' --private-key ${var.ssh_key_private} -T 300 vmcloud-site-servers-setup-all.yml"
# }
