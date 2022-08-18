resource "google_compute_router" "router" {
  name    = var.router_name
  region  = var.region_name
  network = var.vpc_network_name
}