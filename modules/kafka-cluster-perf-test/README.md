## Terraform Kafka Cluster Performance Test

This module handles the provisioning of a Kafka Cluster using the [Strimzi](https://strimzi.io/) operator and the execution of a performance test using a simple
consumer and producer pair. The resource creation/deletions triggered by this module are:

- The deployment of the Strimzi operator at the `strimzi` namespace.
- The deployment of a Kafka Cluster at the `application` namespace using the Strimzi Operator.
- The creation of Kafka topic using Strimzi's entities operator
- A `producer` job that runs the [kafka-producer-perf-test](https://github.com/apache/kafka/blob/trunk/bin/kafka-producer-perf-test.sh) script.
- A `consumer` deployment configured to run the [kafka-console-consumer](https://github.com/apache/kafka/blob/trunk/bin/kafka-console-consumer.sh) script.

## Usage

This module can be invoked as follows:

```hcl

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = var.kube_context
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = var.kube_context
  }
}

provider "kubectl" {
  config_path = "~/.kube/config"
  config_context = var.kube_context
}


module "kafka-cluster-perf-test" {
  source = "./modules/kafka-cluster-perf-test"
  kafka_replicas = 3
  topic_name = "messages"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kafka\_replicas | Number of replicas in the Kafka Cluster | `string` | - | yes |
| topic\_name | Name of the test topic to be created | `string` | - | yes |
| consumer\_replicas | Consumer Replicas to be Created By its Deployment | `number` | `2` | no |
| consumer\_max\_messages | Maximum amount of messages a consumer can ingest | `number` | `50` | no |


## Outputs

| Name | Description |
|------|-------------|
| kafka\_cluster\_name | Kafka Cluster Name |
| kafka\_cluster\_namespace | Kafka Cluster Namespac |
