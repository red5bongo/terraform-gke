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

resource "google_container_node_pool" "np" {
  name = "${var.cluster_name}-node-pool"
  zone = "${var.zone}"
  cluster = "${google_container_cluster.primary.name}"
  initial_node_count = "${var.node_count}"
  autoscaling {
    min_node_count = "${var.min_nodes}"
    max_node_count = "${var.max_nodes}"
  }
}

resource "google_container_cluster" "primary" {
  name     = "${var.cluster_name}"
  zone		 = "${var.zone}"
#  node_pool = ["${google_container_node_pool.np.name}"]
  initial_node_count = "${var.node_count}"
#  node_version = "${data.google_container_engine_versions.uswest1a.latest_node_version}"
  node_version = "${var.node_version}"
  node_config {
    machine_type = "n1-standard-1"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
    labels {
      cluster = "terraform"
    }
    tags = ["terraform", "blah"]
  }
}
