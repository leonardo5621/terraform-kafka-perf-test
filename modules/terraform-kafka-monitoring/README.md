## Terraform Kafka Monitoring

This module is meant to enable a Prometheus-based monitoring of the Kafka Cluster.
The resource creation/deletions triggered are:

- The creation of the `watch` namespace where everything in this module will be deployed.
- The deployment of the [prometheus-operator](https://github.com/prometheus-operator/prometheus-operator).
- A configured prometheus instance.
- Optional `PodMonitor` for the following resources: `strimzi` operator, the `entity` operator and the Kafka Cluster itself.

In order to check the scraped Prometheus metrics, you can run:

```bash
  kubectl port-forward svc/prometheus-operated 9090:9090 -n watch
```
 And it will become available at the port 9090 at the localhost.

 If none of the Kafka Cluster or operator metrics are readily available, try restarting the `prometheus` or the `prometheus-monitoring-kube` pods.

## Usage

Here is an example of the usage of this module:

```hcl
module "cluster-monitoring" {
  source = "./modules/kafka-monitoring"
  monitor_entity_operator = false
  scrape_interval = "20s"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| scrape\_timeout | Metrics scraping timeout value | `string` | `5s` | no |
| scrape\_interval | Metrics scraping interval | `string` | `30s` | no |
| monitor\_strimzi\_operator | Flag to create a Pod Monitor resource for the strimzi operator | `boolean` | `true` | no |
| monitor\_entity\_operator | Create a Pod Monitor resource for the entity operator | `boolean` | `true` | no |
| monitor\_kafka\_resource | Flag to create a Pod Monitor resource for monitoring the kafka cluster | `boolean` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| monitoring\_namespace | Namespace where the prometheus monitoring is running | 
| prometheus\_set\_name | Name of the prometheus instance |
