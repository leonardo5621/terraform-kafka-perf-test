output "monitoring_namespace" {
  description = "Namespace where the prometheus monitoring is running"
  value = kubernetes_namespace.watch.metadata.name
}

output "prometheus_set_name" {
  description = "Name of the prometheus set created"
  value = kubectl_manifest.prometheus.name
}