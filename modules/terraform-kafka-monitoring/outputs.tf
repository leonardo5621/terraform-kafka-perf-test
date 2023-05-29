output "monitoring_namespace" {
  description = "Namespace where the prometheus monitoring is running"
  value = kubernetes_namespace.watch.id
}

output "prometheus_set_name" {
  description = "Name of the prometheus instance"
  value = kubectl_manifest.prometheus.name
}