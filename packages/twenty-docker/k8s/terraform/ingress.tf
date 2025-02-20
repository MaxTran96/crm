resource "kubernetes_ingress_v1" "twentycrm" {
  metadata {
    name      = "${var.twentycrm_app_name}-ingress"
    namespace = kubernetes_namespace.twentycrm.metadata.0.name
    annotations = {
      "kubernetes.io/ingress.class"                       = "nginx"
      "nginx.ingress.kubernetes.io/force-ssl-redirect"    = "false"
      "nginx.ingress.kubernetes.io/backend-protocol"      = "HTTP"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.twentycrm_app_hostname
      http {
        path {
          path = "/*"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.twentycrm_server.metadata.0.name
              port {
                number = kubernetes_service.twentycrm_server.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }

  timeouts {
    create = "30s"
  }
}
