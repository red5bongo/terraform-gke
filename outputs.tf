output "cluster_id" {
 value = "${google_container_cluster.primary.self_link}"
}
output "cluster_version" {
 value = "${google_container_cluster.primary.node_version}"
}
output "endpoint" {
  value = "${google_container_cluster.primary.endpoint}"
}
