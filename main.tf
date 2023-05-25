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

module "kafka-cluster-perf-test" {
  source = "./modules/kafka-cluster-perf-test"
  kafka_replicas = 2
  topic_name = "messages"
}