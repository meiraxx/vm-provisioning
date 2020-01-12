# Terraform Openstack (VM Cloud) multi tier deployment
# Author: Rafael Belchior - rafael.belchior@tecnico.ulisboa.pt


resource "openstack_networking_network_v2" "backend_network" {
  name           = "backend_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "backend_subnet" {
  name       = "backend_subnet"
  network_id = "${openstack_networking_network_v2.backend_network.id}"
  cidr       = "192.168.1.0/24"
  ip_version = 4
}

#  creating security group to allow access to  servers

resource "openstack_compute_secgroup_v2" "sec_ingr" {
  name        = "sec_ingr"
  description = "a security group"

  rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}
