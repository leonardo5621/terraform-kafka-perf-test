resource "kubernetes_cluster_role" "monitoring" {
  metadata {
    name = "prometheus-server"
    labels = {
      app = "strimzi"
    }
  }
  rule {
    api_groups = [""]
    resources = [ 
      "nodes",
      "nodes/proxy",
      "services",
      "endpoints",
      "pods",
    ]
    verbs = ["get", "list", "watch"]
  }
  rule {
    api_groups = [ "extensions" ]
    resources = [ "ingresses" ]
    verbs = ["get", "list", "watch"]
  }
  rule {
    non_resource_urls = [ "/metrics" ]
    verbs = [ "get" ]
  }
}

resource "kubernetes_service_account" "monitoring" {
  metadata {
    name = "prometheus-server"
    labels = {
      app = "strimzi"
    }
    namespace = "watch"
  }
}

resource "kubernetes_cluster_role_binding" "monitoring" {
  metadata {
    name = "prometheus-server"
    labels = {
      app = "strimzi"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "prometheus-server"
  }

  subject {
    kind = "ServiceAccount"
    name = "prometheus-server"
    namespace = "watch"
  }
}