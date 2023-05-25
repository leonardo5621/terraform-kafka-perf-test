resource "kubectl_manifest" "topic" {
  yaml_body = <<YAML
  apiVersion: kafka.strimzi.io/v1beta2
  kind: KafkaTopic
  metadata:
    name: ${var.topic_name}
    labels:
      strimzi.io/cluster: message-broker
    namespace: application
  spec:
    partitions: 1
    replicas: 1
    config:
      retention.ms: 7200000
      segment.bytes: 1073741824
  YAML
  depends_on = [helm_release.strimzi, kubectl_manifest.kafka]
}