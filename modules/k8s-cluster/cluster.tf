# resource "google_container_cluster" "primary" {
#   name     = "${var.project_id}-cluster"
#   location = "${var.region}-b"
  
#   remove_default_node_pool = true
#   initial_node_count       = 1

#   network    = google_compute_network.vpc.name
#   subnetwork = google_compute_subnetwork.subnet.name

#   cluster_autoscaling {
#     auto_provisioning_defaults {
#       disk_size = 50
#     }
#   }

#   ip_allocation_policy {
#     cluster_secondary_range_name  = "pods"
#     services_secondary_range_name = google_compute_subnetwork.subnet.secondary_ip_range.0.range_name
#   }
# }

# resource "google_container_node_pool" "nodes" {
#   name       = google_container_cluster.primary.name
#   location   = "${var.region}-b"
#   cluster    = google_container_cluster.primary.name
#   node_count = var.nodes_count
#   node_config {
#     disk_size_gb = 30
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/logging.write",
#       "https://www.googleapis.com/auth/monitoring",
#     ]

#     labels = {
#       env = var.project_id
#     }

#     preemptible  = true
#     machine_type = "n1-standard-1"
#     tags         = ["gke-node", "${var.project_id}-gke"]
#     metadata = {
#       disable-legacy-endpoints = "true"
#     }
#   }
# }

module "gke" {
  source                 = "terraform-google-modules/kubernetes-engine/google"
  version                = "26.1.1"
  project_id             = var.project_id
  name                   = "${var.project_id}-cluster"
  region = var.region
  zones = ["${var.region}-b"]
  network                = module.gcp-network.network_name
  subnetwork             = module.gcp-network.subnets_names[0]
  ip_range_pods          = "pods"
  ip_range_services      = "services"
  create_service_account = false
  
  node_pools = [
    {
      name                      = "${var.project_id}-node-pool"
      machine_type              = "n1-standard-1"
      min_count                 = 1
      max_count                 = 4
      disk_size_gb              = 40
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}