variable "kafka_replicas" {
  description = "Number of replicas in the Kafka Cluster"
  type = string
}

variable "topic_name" {
  description = "Name of the test topic to be created"
  type = string
}

variable "consumer_replicas" {
  description = "Consumer Replicas to be Created By its Deployment"
  type = number
  default = 2
}

variable "consumer_max_messages" {
  description = "Maximum amount of messages a consumer can ingest"
  type = number
  default = 50
}