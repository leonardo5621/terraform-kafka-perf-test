output "kafka_cluster_name" {
  description = "Kafka Cluster Name"
  value = kubectl_manifest.kafka.name
}

output "kafka_cluster_namespace" {
  description = "Kafka Cluster Namespace"
  value = kubectl_manifest.kafka.namespace
}