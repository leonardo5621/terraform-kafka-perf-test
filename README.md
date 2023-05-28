# Kafka Performance Test

This project contains a infrastructure automation subdivided into Terraform modules for provisioning a Kafka cluster using the Strimzi operator for a performance test and its underlying infrastructure.

## Introduction
A message broker is a piece of software responsible for enabling the communication and exchange of information between services. It can be extremely useful in cases where message senders and receivers are distributed across different regions or platforms. One of the most notable examples of modern message brokers is [Apache Kafka](https://kafka.apache.org/), which is currently used as a event streaming tool.

The goal of this project was to create a simple way of provisioning a Kafka Cluster and executing a performance test on it. It contains three main modules:

- **k8s-cluster**: This Terraform module enables the provisioning of a Kubernetes Cluster on GKE.
- **kafka-cluster-perf-test**: This module sets up a Kafka Cluster aimed towards a performance test using a basic producer and a consumer.
- **kafka-monitoring**: This module provides the possibility to have a prometheus-based monitoring of the Kafka Cluster.

Make sure to check out the documentation of each module for more details.

## Requirements
Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

### Using the three modules
- [Terraform](https://www.terraform.io/) and [kubectl](https://kubernetes.io/docs/reference/kubectl/) tools are correctly installed.
- Have a Service Account that is able to execute the module with the Create/Update/Delete permissions over Network and GKE resources.
- Make sure that the Compute Engine and Kubernetes Engine APIs have been enabled in the project.

### Using only the Kafka Cluster creation and monitoring modules
- A valid kubernetes context.
- A kubernetes configuration file to allow the communication with the cluster.

## Modules

The infrastructure provisioning has been divided into separated modules, the following ones are included:

- The creation of a VPC
- A subnet for the created VPC
- The GKE cluster and its node pool

- The namespace `strimzi` containing a deployment of a Strimzi operator.
- The deployment of a Kafka Cluster at the `application` namespace using the Strimzi Operator.
- A Kafka topic created using Strimzi's entities operator
- A job that runs the [kafka-producer-perf-test](https://github.com/apache/kafka/blob/trunk/bin/kafka-producer-perf-test.sh) script.
- A `consumer` deployment that runs the [kafka-console-consumer](https://github.com/apache/kafka/blob/trunk/bin/kafka-console-consumer.sh) script.

- The creation of a `watch` namespace
- The deployment of a [prometheus-operator](https://github.com/prometheus-operator/prometheus-operator) at the `watch` namespace.
- The creation of a `PodMonitor` for the Kafka Cluster.
- The creation of a `PodMonitor` for the Strimzi Operator.
- The creation of a `PodMonitor` for the Entity Operator.

