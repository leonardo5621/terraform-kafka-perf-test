resource "kubernetes_deployment" "consumer" {
  metadata {
    name = "consumer"
    namespace = "application"
    labels = {
      name = "consumer"
    }
  }

  spec {
    replicas = var.consumer_replicas
    selector {
      match_labels = {
        name = "consumer"
      }
    }
    template {
      metadata {
        labels = {
          name = "consumer"
        }  
      }
      spec {
        container {
          image = "quay.io/strimzi/kafka:0.35.0-kafka-3.4.0"
          image_pull_policy = "IfNotPresent"
          name = "consumer"
          command = ["bin/kafka-console-consumer.sh"]
          args = [
            "--topic=${var.topic_name}",
            "--from-beginning",
            "--bootstrap-server",
            "message-broker-kafka-bootstrap:9092",
            "--max-messages=${var.consumer_max_messages}"
          ]
        }
      }
    }
  }
  depends_on = [kubectl_manifest.topic]
}