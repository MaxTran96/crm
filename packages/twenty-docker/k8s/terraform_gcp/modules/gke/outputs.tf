output "endpoint" {
  value = "https://${google_container_cluster.primary.endpoint}" # Ensure it includes HTTPS
}

output "cluster_ca_certificate" {
  value = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}