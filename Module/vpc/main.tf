resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  project                 = var.project_name
  auto_create_subnetworks = false
  mtu                     = 1460
}