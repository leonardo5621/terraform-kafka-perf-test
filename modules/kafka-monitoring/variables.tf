variable "scrape_timeout" {
  description = "Metrics scraping timeout value"
  default = "5s"
}

variable "scrape_interval" {
  description = "Metrics scraping interval"
  default = "30s"
}

variable "monitor_strimzi_operator" {
  description = "Flag to create a Pod Monitor resource for the strimzi operator"
  type = bool
  default = true
}

variable "monitor_entity_operator" {
  description = "Create a Pod Monitor resource for the entity operator"
  type = bool
  default = true
}

variable "monitor_kafka_resource" {
  description = "Flag to create a Pod Monitor resource for monitoring the kafka cluster"
  type = bool
  default = true
}