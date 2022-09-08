resource "google_service_account" "default" {
  account_id   = "${var.project_name_id}-id"
  display_name = var.project_name_id
}