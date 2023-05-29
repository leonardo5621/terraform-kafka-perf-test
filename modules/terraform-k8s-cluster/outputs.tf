output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "gke_cluster_name" {
  value       = module.gke.name
  description = "GKE Cluster Name"
}

output "gke_cluster_host" {
  value       = "https://${module.gke.endpoint}"
  description = "GKE Cluster Host"
}

output "gke_cluster_location" {
  value = module.gke.location
  description = "Cluster Location"
}

output "gke_cluster_ca_cert" {
  value = module.gke.ca_certificate
  description = "Cluster CA Certificate"
} 

