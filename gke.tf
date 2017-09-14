provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_instance" "default" {
  name           = "terraform-test"
  machine_type   = "g1-small"
  zone		 = "us-west1-a"
  boot_disk {
    initialize_params {
      image = "coreos-stable-1409-9-0-v20170814"
      }
  }
  network_interface {
    network = "default"
    access_config {
     nat_ip = "${google_compute_address.default.address}"
    }
  }
}

resource "google_compute_address" "default" {
  name = "terraform-ip"
}

output "instance_id" {
 value = "${google_compute_instance.default.self_link}"
}
output "instance_IP" {
 value = "${google_compute_address.default.default.network_interface.0.access_config.0.nat_ip}"
}
