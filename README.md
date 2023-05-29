# Kafka Performance Test

This project contains a infrastructure automation subdivided into Terraform modules for provisioning a Kafka cluster using the Strimzi operator for a performance test and its underlying infrastructure.

## Introduction
A message broker is a piece of software responsible for enabling the communication and exchange of information between services. It can be extremely useful in cases where message senders and receivers are distributed across different regions or platforms. One of the most notable examples of modern message brokers is [Apache Kafka](https://kafka.apache.org/), which is currently used as a event streaming tool.

The goal of this project was to create a simple way of provisioning a Kafka Cluster and executing a performance test on it. It contains three main modules:

- [**terraform-k8s-cluster**](https://github.com/leonardo5621/terraform-kafka-perf-test/blob/master/modules/terraform-k8s-cluster/README.md): This Terraform module enables the provisioning of a Kubernetes Cluster on GKE.
- [**terraform-kafka-cluster-perf-test**](https://github.com/leonardo5621/terraform-kafka-perf-test/blob/master/modules/terraform-kafka-cluster-perf-test/README.md): This module sets up a Kafka Cluster aimed towards a performance test using a basic producer and consumer pattern, it also includes a Kafka UI deployment to visualize the message exchange.
- [**terraform-kafka-monitoring**](https://github.com/leonardo5621/terraform-kafka-perf-test/blob/master/modules/terraform-kafka-monitoring/README.md): This module provides the possibility to have a prometheus-based monitoring of the Kafka Cluster.

Make sure to check out the documentation of each module for more details.

## Requirements
Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

### Using all modules
- [Terraform](https://www.terraform.io/) and [kubectl](https://kubernetes.io/docs/reference/kubectl/) tools installed.
- Google Cloud command line tool([gcloud](https://cloud.google.com/sdk/gcloud)) is installed.
- A Google Cloud Platform project ready to be used
- A Service Account with Create/Update/Delete permissions over Network and GKE resources.
- Make sure that the Compute Engine and Kubernetes Engine APIs have been enabled in the project.

### Using only the Kafka Cluster creation and monitoring modules
- [Terraform](https://www.terraform.io/) and [kubectl](https://kubernetes.io/docs/reference/kubectl/) tools correctly installed.
- A valid kubernetes context.
- A kubernetes configuration file to allow the communication with the cluster.

The `.env.example` contains a sample of the necessary environment variables you must include to your environment

## What this project has achieved

With the creation of these modules, these project has been able to achieve the creation of
a Kafka Cluster and a sample topic provisioned using the Strimzi Operator. With the possibility of creating the underlying GKE Cluster or not.

The usage of all the modules bring the creation of the Kafka Cluster on the Kubernetes Cluster, the execution of a performance test on it and a set of prometheus monitoring metrics of the cluster. In addition, the Kafka UI application allow us to see the exchanged messages during the test.

![Screenshot from 2023-05-28 21-24-34](https://github.com/leonardo5621/terraform-kafka-perf-test/assets/30439454/83a77f53-e4a9-4c4b-8058-a11804cdd399)


Also, there is the possibility of using the prometheus-based monitoring for exporting metrics to other platforms, such as Grafana.
## Further Improvements

There are also improvements that can be brought to this project, here are some of them:

- Implementation of a custom dashboard with the cluster metrics.
- Setting up alarms based on these metrics.
- Executing performance tests from the outside of the cluster.
- Integration of the terraform modules into an CI/CD pipeline system.

## References

- [Deploying and Upgrading](https://strimzi.io/docs/operators/latest/deploying.html), Strimzi documentation, available at their official website.
- [Kafka on Kubernetes: Using Strimzi](https://blog.devgenius.io/kafka-on-kubernetes-using-strimzi-part-1-83d74564135e) Post series by 
[Amarendra Singh](https://medium.com/@singh.amarendra), available on Medium, April 2022.
- [Kafka on kubernetes: The infrastructure](https://yvescallaert.medium.com/kafka-on-kubernetes-the-infrastructure-7f2d0eb1692) Post by [Yves Callaert](https://yvescallaert.medium.com/), available on Medium, May 2018.
- [Provision a GKE Cluster (Google Cloud)](https://developer.hashicorp.com/terraform/tutorials/kubernetes/gke), Hashicorp Developer Documentation, Manage Kubernetes with Terraform series.
- [Provisioning Kubernetes clusters on GCP with Terraform and GKE](https://learnk8s.io/terraform-gke), Post by Kristijan Mitevski, learnk8s tutorials, January 2023.

