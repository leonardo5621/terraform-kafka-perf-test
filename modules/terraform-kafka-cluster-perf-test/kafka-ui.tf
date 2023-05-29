resource "kubernetes_config_map" "kafka_ui_config" {
  metadata {
    name = "kafka-ui-configmap"
    namespace = "application"
  }
  data = {
    "config.yml" = <<YAML
      kafka:
        clusters:
          - name: yaml
            bootstrapServers: message-broker-kafka-bootstrap:9092
      auth:
        type: disabled
      management:
        health:
          ldap:
            enabled: false 
    YAML
  }
}

resource "helm_release" "kafka_ui" {
  name       = "kafka-ui"
  namespace = "application"
  
  repository = "https://provectus.github.io/kafka-ui"
  chart      = "kafka-ui"

  set {
    name = "yamlApplicationConfigConfigMap.name"
    value = "kafka-ui-configmap"
  }

  set {
    name = "yamlApplicationConfigConfigMap.keyName"
    value = "config.yml"
  }

  depends_on = [kubernetes_namespace.application, kubernetes_config_map.kafka_ui_config]
}
