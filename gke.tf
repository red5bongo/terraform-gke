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
data "google_container_engine_versions" "uswest1a" {
  zone = "us-west1-a"
}
resource "google_container_cluster" "primary" {
  name           = "terraform-gke"
  zone		 = "us-west1-a"
  initial_node_count = "${var.node_count}"
  node_version = "${data.google_container_engine_versions.uswest1a.latest_node_version}"
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
output "cluster_version" {
 value = "${google_container_cluster.primary.node_version}"
}
output "endpoint" {
  value = "${google_container_cluster.primary.endpoint}"
}
