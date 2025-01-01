resource "kubernetes_persistent_volume" "db" {
  metadata {
    name = "${var.twentycrm_app_name}-db-pv"
  }

  spec {
    storage_class_name = "default"
    capacity = {
      storage = var.twentycrm_db_pv_capacity
    }
    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      local {
        path = var.twentycrm_db_pv_path # Ensure this path exists on the target node
      }
    }

    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key      = "kubernetes.io/hostname"
            operator = "In"
            values   = var.twentycrm_db_pv_hostnames # Replace with the hostname(s) where the volume should be created
          }
        }
      }
    }
  }
}