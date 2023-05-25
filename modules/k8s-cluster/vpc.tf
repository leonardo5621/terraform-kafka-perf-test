resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.vpc_name}-sub"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.ip_cidr_range
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.20.0.0/22"
  }

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.40.0.0/22"
  }
}