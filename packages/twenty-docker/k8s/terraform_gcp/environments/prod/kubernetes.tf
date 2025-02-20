data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = module.gke.endpoint
  cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

resource "kubernetes_deployment" "saleda" {
  metadata {
    name      = "saleda"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "saleda"
      }
    }

    template {
      metadata {
        labels = {
          app = "saleda"
        }
      }

      spec {
        container {
          image = "nginx"
          name  = "nginx-container"

          volume_mount {
            mount_path = "/data"
            name       = "storage"
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
        }
      }
    }
  }
}