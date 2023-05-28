variable "scrape_timeout" {
  description = "Metrics scraping timeout value"
  value = "5s"
}

variable "scrape_interval" {
  description = "Metrics scraping interval"
  value = "30s"
}

variable "monitor_strimzi_operator" {
  description = "Flag to create a Pod Monitor resource for the strimzi operator"
  type = "boolean"
  default = true
}

variable "monitor_entity_operator" {
  description = "Create a Pod Monitor resource for the entity operator"
  type = "boolean"
  default = true
}

variable "monitor_kafka_resource" {
  description = "Flag to create a Pod Monitor resource for monitoring the kafka cluster"
  type = "boolean"
  default = true
}