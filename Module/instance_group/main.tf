
#locals {
#  workspace_suffix = terraform.workspace == "default" ? "" : "-${terraform.workspace}"
#}


data "google_compute_image" "this" {
  family  = var.instance_boot_disk.image_family
  project = var.instance_boot_disk.image_project
}

resource "google_compute_health_check" "http_check" {
  name                = "${var.health_check.name}" #${local.workspace_suffix}"
  timeout_sec         = var.health_check.timeout_sec
  check_interval_sec  = var.health_check.check_interval_sec
  healthy_threshold   = var.health_check.healthy_threshold
  unhealthy_threshold = var.health_check.unhealthy_threshold

  http_health_check {
    port_name = var.health_check.port_name
    port      = var.health_check.port
  }
}

resource "google_compute_instance_template" "this" {
  #name        = "tf-${random_string.instance_template_suffix.id}"
  name_prefix  = var.instance_template.name_prefix
  machine_type = var.instance_template.machine_type

  scheduling {
    automatic_restart   = var.instance_template.scheduling.automatic_restart
    on_host_maintenance = var.instance_template.scheduling.on_host_maintenance
  }

  disk {
    source_image = data.google_compute_image.this.self_link
    auto_delete  = var.instance_template.disk.auto_delete
    boot         = var.instance_template.disk.boot
  }

  network_interface {
    network    = var.network_interface.network_id
    subnetwork = var.network_interface.subnetwork_id

    #access_config { # External IPs blocked in Atos
    #  network_tier = "STANDARD"
    #}
  }

  metadata = {
    "ssh-keys" = var.public-ssh-key
  }

  metadata_startup_script = file("${path.module}/web_server.tpl")

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_region_instance_group_manager" "this" {
  name                      = "${var.group_manager.name}" #${local.workspace_suffix}"
  base_instance_name        = var.group_manager.base_instance_name
  region                    = var.group_manager.region
  distribution_policy_zones = var.group_manager.distribution_policy_zones

  version {
    instance_template = google_compute_instance_template.this.id
  }

  named_port {
    name = var.group_manager.named_port.name
    port = var.group_manager.named_port.port
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.http_check.id
    initial_delay_sec = var.group_manager.initial_delay_sec
  }
}

resource "google_compute_region_autoscaler" "this" {
  name   = var.autoscaler.name #${local.workspace_suffix}"
  region = var.group_manager.region
  target = google_compute_region_instance_group_manager.this.id

  autoscaling_policy {
    max_replicas    = var.autoscaler.autoscaling_policy.max_replicas
    min_replicas    = var.autoscaler.autoscaling_policy.min_replicas
    cooldown_period = var.autoscaler.autoscaling_policy.cooldown_period

    cpu_utilization {
      target = var.autoscaler.cpu_utilization.target
    }
  }
}

