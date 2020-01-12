
# Elemets of the cloud such as virtual servers,
# networks, firewall rules are created as resources
# syntax is: resource RESOURCE_TYPE RESOURCE_NAME
# https://www.terraform.io/docs/configuration/resources.html

resource "google_compute_firewall" "frontend_rules" {
  name    = "frontend"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["bastionbal"]
}

# create the frontend server
resource "google_compute_instance" "bastionbal" {
    name = "bastionbal"
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
  tags = ["bastionbal"]
}

output "bastionbal" {
    value = "${join(" ", google_compute_instance.bastionbal.*.network_interface.0.access_config.0.assigned_nat_ip)}"
}
