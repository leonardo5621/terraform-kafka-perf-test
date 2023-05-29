terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.8.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }

    google = {
      source = "hashicorp/google"
      version = ">=4.0.0"
    }
  }
}

data "google_client_config" "default" {}

module "gke_cluster" {
  source = "./modules/terraform-k8s-cluster"
  project_id = var.project_id
  region = var.region
  vpc_name = "perf-test"
  nodes_count = 4
}

provider "kubernetes" {
  host                   = module.gke_cluster.gke_cluster_host
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.gke_cluster_ca_cert)
}

provider "helm" {
  kubernetes {
    host                   = module.gke_cluster.gke_cluster_host
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke_cluster.gke_cluster_ca_cert)
  }
}

provider "kubectl" {
  host                   = module.gke_cluster.gke_cluster_host
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke_cluster.gke_cluster_ca_cert)
}

module "kafka-cluster-perf-test" {
  source = "./modules/terraform-kafka-cluster-perf-test"
  kafka_replicas = 2
  topic_name = "messages"
  depends_on = [ module.gke_cluster ]
}

module "cluster-monitoring" {
  source = "./modules/terraform-kafka-monitoring"
  depends_on = [ module.gke_cluster ]
}