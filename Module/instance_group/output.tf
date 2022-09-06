# Exercise 8 - Modules
# instance_group/instance_group_out.tf

output "health_check_id" {
  value = google_compute_health_check.http_check.id
}

output "instance_group" {
  value = google_compute_region_instance_group_manager.this.instance_group
}
