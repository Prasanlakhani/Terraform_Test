resource "google_compute_firewall" "this" {
  name     = var.firewall.name
  network  = var.network_id
  priority = var.firewall.priority

  dynamic "allow" {
    for_each = var.firewall.allow
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  source_ranges = var.firewall.source_ranges
}
