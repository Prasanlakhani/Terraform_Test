resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.ipaddress[0]
  region        = var.region_name
  network       = var.vpc_network_name
}

