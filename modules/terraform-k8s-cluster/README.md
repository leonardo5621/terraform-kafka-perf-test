## Terraform K8s Cluster

This module handles the creation of a Google Cloud Kubernetes Cluster (GKE) and its basic configuration. 
The resources creation and deletion triggered by this module are:

- A new VPC network and a subnet where the cluster will be provisioned.
- A zonal GKE cluster at the determined project.
- A GKE Node Pool configured and attached to the cluster.

## Usage

Here is an example usage of this module

```hcl
data "google_client_config" "default" {}

module "gke_cluster" {
  source = "./modules/k8s-cluster"
  project_id = var.project_id
  region = var.region
  vpc_name = "perf-test"
  nodes_count = 4
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project_id | Google Cloud Project ID | `string` | - | yes |
| region | Region where the VPC and the Cluster will be provisioned | `string` | `us-east1` | no |
| vpc_name | The name of the VPC to be created | `string` | - | yes |
| ip\_cidr\_range | Subnet IP CIDR Range | `string` | `10.30.0.0/24` | no |
| nodes\_count | Number of nodes to be created in the cluster initially | `number` | `3` | no |

## Outputs

| Name | Description |
|------|-------------|
| project_id | Google Cloud Project ID |
| gke\_cluster\_name | The name of the created cluster |
| gke\_cluster\_host | GKE Cluster Host |
| gke\_cluster\_location | GKE Cluster Location  |
| gke\_cluster\_ca\_cert | GKE Cluster Certificate Authority Certificate |

## Dependencies

The dependencies needed for this module are similar to the ones for 
the [terraform-google-kubernetes-engine](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/blob/master/README.md)

#### Kubectl
- [kubectl](https://github.com/kubernetes/kubernetes/releases)
#### Terraform and Plugins
- [Terraform](https://www.terraform.io/downloads.html)
- [Terraform Provider for GCP](https://registry.terraform.io/providers/hashicorp/google/latest/docs)  >= v4.0.0
#### gcloud
There may be some submodules used that require to have the [gcloud](https://cloud.google.com/sdk/docs/install?hl=pt-br) tool installed.
