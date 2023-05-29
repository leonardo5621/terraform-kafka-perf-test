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
  }
}

resource "kubernetes_namespace" "strimzi" {
  metadata {
    name = "strimzi"
    labels = {
      name = "strimzi"
    }
  }
}

resource "kubernetes_namespace" "application" {
  metadata {
    name = "application"
    labels = {
      name = "application"
    }
  }
}
