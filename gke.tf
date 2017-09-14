provider "google" {
#  credentials = "${file("account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket = "glds-terraform-remote-state-storage"
    path = "wsk/terraform.tfstate"
    project = "glds-gcp"
  }
}

resource "google_container_cluster" "primary" {
  name           = "terraform-test"
  zone		 = "us-west1-a"
  initial_node_count = 3
  node_version = "1.6.7"
  node_config {
    machine_type = "n1-standard-1"
    labels {
      cluster = "terraform"
    }
    tags = ["terraform", "blah"]
  }
}
output "cluster_id" {
 value = "${google_container_cluster.primary.self_link}"
}

