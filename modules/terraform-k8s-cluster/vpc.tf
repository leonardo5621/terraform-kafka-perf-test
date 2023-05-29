module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  version      = "6.0.0"
  project_id   = var.project_id
  network_name = var.vpc_name

  subnets = [
    {
      subnet_name   = "${var.vpc_name}-sub"
      subnet_ip     = var.ip_cidr_range
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "${var.vpc_name}-sub" = [
      {
        range_name    = "pods"
        ip_cidr_range = "10.20.0.0/22"
      },
      {
        range_name    = "services"
        ip_cidr_range = "10.40.0.0/22"
      },
    ]
  }
}