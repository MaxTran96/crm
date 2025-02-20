resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = "us-central1-a" #var.region

  initial_node_count = var.initial_node_count

  networking_mode = "VPC_NATIVE"
  network        = var.network_id
  subnetwork     = var.subnet_id

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
  remove_default_node_pool = true
  deletion_protection = false
}

# Separate node pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name

  node_count = var.initial_node_count

  node_config {
    machine_type        = var.machine_type
    disk_size_gb        = var.disk_size_gb  # Desired disk size
    service_account     = var.node_service_account
    oauth_scopes        = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  # Optional: Enable autoscaling if needed
  # autoscaling {
  #   min_node_count = 1
  #   max_node_count = 5
  # }

  # Optional: Set lifecycle rules
  lifecycle {
    prevent_destroy = false
  }
} 