output "cluster_id" {
 value = "${google_container_cluster.primary.self_link}"
}
output "cluster_version" {
 value = "${google_container_cluster.primary.node_version}"
}
output "endpoint" {
  value = "${google_container_cluster.primary.endpoint}"
}
output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}
