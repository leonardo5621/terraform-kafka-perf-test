## Pod monitor
## Source: https://github.com/AmarendraSingh88/kafka-on-kubernetes/blob/main/kafka-demo/demo3-monitoring/strimzi-pod-monitor.yaml
resource "kubectl_manifest" "operator-monitoring" {
  yaml_body = <<YAML
    apiVersion: monitoring.coreos.com/v1
    kind: PodMonitor
    metadata:
      name: cluster-operator-metrics
      labels:
        app: strimzi
      namespace: watch
    spec:
      selector:
        matchLabels:
          strimzi.io/kind: cluster-operator
      namespaceSelector:
        matchNames:
          - strimzi
      podMetricsEndpoints:
      - path: /metrics
        port: http
  YAML
  depends_on = [ helm_release.operator ]
}

resource "kubectl_manifest" "entity-monitoring" {
  yaml_body = <<YAML
    apiVersion: monitoring.coreos.com/v1
    kind: PodMonitor
    metadata:
      name: entity-operator-metrics
      labels:
        app: strimzi
      namespace: watch
    spec:
      selector:
        matchLabels:
          app.kubernetes.io/name: entity-operator
      namespaceSelector:
        matchNames:
          - application
      podMetricsEndpoints:
      - path: /metrics
        port: healthcheck
  YAML
  depends_on = [ helm_release.operator ]

}

resource "kubectl_manifest" "resources-monitoring" {
  yaml_body = <<YAML
    apiVersion: monitoring.coreos.com/v1
    kind: PodMonitor
    metadata:
      name: kafka-resources-metrics
      labels:
        app: strimzi
      namespace: watch
    spec:
      selector:
        matchExpressions:
          - key: "strimzi.io/kind"
            operator: In
            values: ["Kafka", "KafkaConnect"]
      namespaceSelector:
        matchNames:
          - application
      podMetricsEndpoints:
      - path: /metrics
        port: tcp-prometheus
        relabelings:
        - separator: ;
          regex: __meta_kubernetes_pod_label_(strimzi_io_.+)
          replacement: $1
          action: labelmap
        - sourceLabels: [__meta_kubernetes_namespace]
          separator: ;
          regex: (.*)
          targetLabel: namespace
          replacement: $1
          action: replace
        - sourceLabels: [__meta_kubernetes_pod_name]
          separator: ;
          regex: (.*)
          targetLabel: kubernetes_pod_name
          replacement: $1
          action: replace
        - sourceLabels: [__meta_kubernetes_pod_node_name]
          separator: ;
          regex: (.*)
          targetLabel: node_name
          replacement: $1
          action: replace
        - sourceLabels: [__meta_kubernetes_pod_host_ip]
          separator: ;
          regex: (.*)
          targetLabel: node_ip
          replacement: $1
          action: replace
  YAML
  depends_on = [ helm_release.operator ]

}