# Kafka Performance Test

This project contains a infrastructure automation in Terraform for provisioning a Kafka cluster using the Strimzi operator for a performance test and its underlying infrastructure.

## Modules

The infrastructure provisioning has been divided into separated modules, the following ones are included:

### k8s-cluster

This Terraform module enables the provisioning of a Kubernetes Cluster on GKE. It sets up the following components:

- The creation of a VPC
- A subnet for the created VPC
- The GKE cluster and its node pool

### kafka-cluster-perf-test

This module sets up a Kafka Cluster aimed towards a performance test using a basic producer and a consumer. The following components are provisioned by this module:

- The namespace `strimzi` containing a deployment of a Strimzi operator.
- The deployment of a Kafka Cluster at the `application` namespace using the Strimzi Operator.
- A Kafka topic created using Strimzi's entities operator
- A job that runs the [kafka-producer-perf-test](https://github.com/apache/kafka/blob/trunk/bin/kafka-producer-perf-test.sh) script.
- A `consumer` deployment that runs the [kafka-console-consumer](https://github.com/apache/kafka/blob/trunk/bin/kafka-console-consumer.sh) script.

### kafka-monitoring

This module provides the possibility to have a prometheus-based monitoring of the Kafka Cluster. It contains:

- The creation of a `watch` namespace
- The deployment of a [prometheus-operator](https://github.com/prometheus-operator/prometheus-operator) at the `watch` namespace.
- The creation of a `PodMonitor` for the Kafka Cluster.
- The creation of a `PodMonitor` for the Strimzi Operator.
- The creation of a `PodMonitor` for the Entity Operator.

