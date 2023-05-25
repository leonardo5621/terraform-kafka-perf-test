variable "project_id" {
  description = "Google Cloud Project ID"
}

variable "vpc_name" {
  description = "VPC Network Name"
}

variable "region" {
  description = "VPC Region"
  default = "us-east1"
}

variable "ip_cidr_range" {
  description = "Subnet IP CIDR Range"
  default = "10.30.0.0/24"
}

variable "nodes_count" {
  description = "Number of nodes to be created in the cluster initially"
  default = 3
}