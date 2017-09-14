provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_container_cluster" "primary" {
  name           = "terraform-test"
  zone		 = "us-west1-a"
  initial_node_count = 3
  node_config {
    machine_type = "n1-standard-1"
    labels {
      cluster = "terraform"
    }
    tags {
      ["terraform", "blah"]
    }

output "cluster_id" {
 value = "${google_container_cluster.primary.self_link}"
}

