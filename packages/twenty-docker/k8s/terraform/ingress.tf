resource "kubernetes_ingress" "twentycrm" {
  metadata {
    name      = "${var.twentycrm_app_name}-ingress"
    namespace = kubernetes_namespace.twentycrm.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.twentycrm_app_hostname
      http {
        path {
          path = "/"

          backend {
            service_name = kubernetes_service.twentycrm_server.metadata[0].name
            service_port = kubernetes_service.twentycrm_server.spec[0].port[0].port
          }
        }
      }
    }
  }
}