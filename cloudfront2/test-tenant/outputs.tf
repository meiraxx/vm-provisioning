# Terraform Openstack (VM Cloud) multi tier deployment
# Author: Rafael Belchior - rafael.belchior@tecnico.ulisboa.pt
# To output variables, follow pattern:
# value = "${TYPE.NAME.ATTR}

output "Network name" {
    value = "${openstack_networking_network_v2.backend_network.name}"
}

output "Subnet ID" {
	description = "Outputs the ID of the created subnet"
    value = "${openstack_networking_subnet_v2.backend_subnet.network_id}"
}

output "Created rule" {
	description = "Outputs the sec_ingr rule"
    value = "${openstack_compute_secgroup_v2.sec_ingr.rule}"
}

output "web1 IP"	{
	value = "${openstack_compute_instance_v2.web1.access_ip_v4} initialized with success"
}

#output "web2 IP"	{
#	value = "${openstack_compute_instance_v2.web2.access_ip_v4} initialized with success"
#}

output "bastionbal IP"	{
	value = "${openstack_compute_instance_v2.bastionbal.access_ip_v4} initialized with success"
}

output "private key"	{
	value = "${file(var.ssh_key_private)}"
}

output "public key"	{
	value = "${file(var.ssh_key_public)}"
}
