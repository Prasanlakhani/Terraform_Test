resource "google_compute_router_nat" "nat" {
  name                               = var.nat_name
  router                             = var.nat_router_name
  region                             = var.nat_region_name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  }
