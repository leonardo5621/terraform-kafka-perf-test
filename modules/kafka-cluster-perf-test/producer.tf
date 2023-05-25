resource "kubernetes_job" "job" {
  metadata {
    name = "producer"
    namespace = "application"
  }
  spec {
    backoff_limit = "4"
    template {
      metadata {
        labels = {
          name = "producer"
        }  
      }
      spec {
        restart_policy = "Never"
        container {
          name = "producer-test"
          image = "quay.io/strimzi/kafka:0.35.0-kafka-3.4.0"
          image_pull_policy = "IfNotPresent"
          command = ["bin/kafka-producer-perf-test.sh"]
          args = ["--topic=${var.topic_name}",
           "--throughput=-1",
           "--num-records=100",
           "--record-size=1024",
           "--producer-props",
           "acks=all",
           "bootstrap.servers=message-broker-kafka-bootstrap:9092",
          ]
        }
      }
    }
  }
  depends_on = [kubectl_manifest.topic]
}