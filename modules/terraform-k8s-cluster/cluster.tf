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