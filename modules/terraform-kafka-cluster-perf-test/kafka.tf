resource "kubectl_manifest" "kafka" {
  yaml_body = <<YAML
  apiVersion: kafka.strimzi.io/v1beta2
  kind: Kafka
  metadata:
    name: message-broker
    namespace: application
  spec:
    kafka:
      metricsConfig:
        type: jmxPrometheusExporter
        valueFrom:
          configMapKeyRef:
            name: kafka-metrics
            key: kafka-metrics-config.yml
      readinessProbe:
        initialDelaySeconds: 20
        timeoutSeconds: 5
      livenessProbe:
        initialDelaySeconds: 20
        timeoutSeconds: 5
      version: 3.4.0
      replicas: ${var.kafka_replicas}
      listeners:
        - name: plain
          port: 9092
          type: internal
          tls: false
        - name: tls
          port: 9093
          type: internal
          tls: true
      config:
        offsets.topic.replication.factor: 1
        transaction.state.log.replication.factor: 1
        transaction.state.log.min.isr: 1
        default.replication.factor: 1
        min.insync.replicas: 1
        inter.broker.protocol.version: "3.4"
      storage:
        type: jbod
        volumes:
        - id: 0
          type: persistent-claim
          size: 1Gi
          deleteClaim: false
    zookeeper:
      replicas: ${var.kafka_replicas}
      storage:
        type: persistent-claim
        size: 1Gi
        deleteClaim: false
      readinessProbe:
        initialDelaySeconds: 20
        timeoutSeconds: 5
      livenessProbe:
        initialDelaySeconds: 20
        timeoutSeconds: 5
    entityOperator:
      topicOperator: {}
      userOperator: {}
    kafkaExporter:
      topicRegex: ".*"
      groupRegex: ".*"
  YAML
  depends_on = [helm_release.strimzi, kubernetes_namespace.application]
}