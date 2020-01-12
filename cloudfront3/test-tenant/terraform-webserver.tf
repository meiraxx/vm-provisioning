
# Elemets of the cloud such as virtual servers,
# networks, firewall rules are created as resources
# syntax is: resource RESOURCE_TYPE RESOURCE_NAME
# https://www.terraform.io/docs/configuration/resources.html

# create the frontend server
resource "google_compute_instance" "webserver1" {
    name = "web1"
    machine_type = "${var.GCP_MACHINE_TYPE}"
    zone = "${var.GCP_REGION}"

    boot_disk {
        initialize_params {
        # image list can be found at:
        # https://cloud.google.com/compute/docs/images
        image = "ubuntu-os-cloud/ubuntu-1604-lts"
        }
    }

    network_interface {
        network = "default"
        access_config {
        }
    }
  tags = ["web"]
}


# create the frontend server
resource "google_compute_instance" "webserver2" {
    name = "web2"
    machine_type = "${var.GCP_MACHINE_TYPE}"
    zone = "${var.GCP_REGION}"

    boot_disk {
        initialize_params {
        # image list can be found at:
        # https://cloud.google.com/compute/docs/images
        image = "ubuntu-os-cloud/ubuntu-1604-lts"
        }
    }

    network_interface {
        network = "default"
        access_config {
        }
    }
  tags = ["web"]
}


# create the frontend server
resource "google_compute_instance" "webserver3" {
    name = "web3"
    machine_type = "${var.GCP_MACHINE_TYPE}"
    zone = "${var.GCP_REGION}"

    boot_disk {
        initialize_params {
        # image list can be found at:
        # https://cloud.google.com/compute/docs/images
        image = "ubuntu-os-cloud/ubuntu-1604-lts"
        }
    }
	
    network_interface {
        network = "default"
        access_config {
        }
    }
  tags = ["web"]
}

output "web1" {
    value = "${join(" ", google_compute_instance.webserver1.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

output "web2" {
    value = "${join(" ", google_compute_instance.webserver2.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}

output "web3" {
    value = "${join(" ", google_compute_instance.webserver3.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}
