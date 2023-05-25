terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.4.1"
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

provider "kubernetes" {
  config_path = "~/.kube/config"
  config_context = "broker"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    config_context = "broker"
  }
}

provider "kubectl" {
  config_path = "~/.kube/config"
  config_context = "broker"
}

provider "google" {
  project = var.project_id
  region = var.region
}

module "gke-cluster" {
  source = "./modules/k8s-cluster"
  project_id = var.project_id
  region = var.region
  vpc_name = "perf-test"
  nodes_count = 4
}

module "kafka-cluster-perf-test" {
  source = "./modules/kafka-cluster-perf-test"
  kafka_replicas = 2
  topic_name = "messages"
  depends_on = [ module.gke-cluster ]
}