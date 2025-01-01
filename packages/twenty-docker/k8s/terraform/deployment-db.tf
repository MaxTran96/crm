resource "kubernetes_deployment" "twentycrm_db" {
  metadata {
    name      = "${var.twentycrm_app_name}-db"
    namespace = kubernetes_namespace.twentycrm.metadata.0.name
    labels = {
      app = "${var.twentycrm_app_name}-db"
    }
  }

  spec {
    replicas = var.twentycrm_db_replicas
    selector {
      match_labels = {
        app = "${var.twentycrm_app_name}-db"
      }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "1"
        max_unavailable = "1"
      }
    }

    template {
      metadata {
        labels = {
          app = "${var.twentycrm_app_name}-db"
        }
      }

      spec {
        container {
          image = var.twentycrm_db_image
          name  = var.twentycrm_app_name
          stdin = true
          tty   = true

          image_pull_policy  = "IfNotPresent"

          security_context {
            allow_privilege_escalation = true
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = var.twentycrm_pgdb_admin_password
          }
          env {
            name  = "BITNAMI_DEBUG"
            value = true
          }

          port {
            container_port = 5432
            protocol       = "TCP"
          }

          resources {
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
            limits = {
              cpu    = "1000m"
              memory = "1024Mi"
            }
          }

          volume_mount {
            name       = "db-data"
            mount_path = "/bitnami/postgresql"
          }

          readiness_probe {
            exec {
              # "pg_isready" checks if Postgres is ready for connections:
              command = ["pg_isready", "-U", "postgres", "-h", "127.0.0.1"]
            }
            initial_delay_seconds = 10
            period_seconds        = 5
          }
        }

        volume {
          name = "db-data"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.db.metadata.0.name
          }
        }

        dns_policy     = "ClusterFirst"
        restart_policy = "Always"
      }
    }
  }
}
