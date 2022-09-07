# Exercise 8 - Modules
# lb/lb.tf

#locals {
#  workspace_suffix = terraform.workspace == "default" ? "" : "-${terraform.workspace}"
#}

resource "google_compute_backend_service" "this" {
  name                  = "${var.load_balancer.backend_service.name}" #${local.workspace_suffix}"
  health_checks         = [var.health_check_id]
  load_balancing_scheme = var.load_balancer.backend_service.load_balancing_scheme
  protocol              = var.load_balancer.backend_service.protocol
  port_name             = var.load_balancer.backend_service.port_name

  backend {
    group = var.instance_group
  }
}

resource "google_compute_url_map" "this" {
  name            = "${var.load_balancer.url_map.name}" #${local.workspace_suffix}"
  default_service = google_compute_backend_service.this.id
}

resource "google_compute_target_http_proxy" "this" {
  name    = "${var.load_balancer.http_proxy.name}" #${local.workspace_suffix}"
  url_map = google_compute_url_map.this.id
}

resource "google_compute_global_forwarding_rule" "this" {
  name       = "${var.load_balancer.forwarding_rule.name}" #${local.workspace_suffix}"
  target     = google_compute_target_http_proxy.this.id
  port_range = var.load_balancer.forwarding_rule.port_range
}

resource "google_compute_project_default_network_tier" "this" {
  network_tier = var.load_balancer.network_tier
}
