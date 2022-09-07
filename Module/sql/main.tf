# Exercise 11 - Cloud SQL
# sql/sql.tf

resource "google_sql_database_instance" "master" {
  #name             = "tf-instance" # Will be auto-generated
  database_version    = var.database_instance.database_version
  region              = var.database_instance.region
  deletion_protection = var.database_instance.deletion_protection

  settings {
    tier = var.database_instance.settings.tier
    backup_configuration {
      enabled = true
    } 
    ip_configuration {
      ipv4_enabled    = var.database_instance.settings.ipv4_enabled
      private_network = var.network_id
      require_ssl = true
      #authorized_networks {
      #  name  = "my-ip"
      #  value = "89.64.3.100"
      #}
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_user" "users" {
  name     = var.sql_user
  instance = google_sql_database_instance.master.name
}

resource "google_sql_database" "database" {
  name     = var.sql_database_name
  instance = google_sql_database_instance.master.name
}

# For private IP

resource "google_compute_global_address" "private_ip_address" {
  #provider = google-beta

  name          = var.global_address.name
  purpose       = var.global_address.purpose
  address_type  = var.global_address.address_type
  prefix_length = var.global_address.prefix_length
  network       = var.network_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  #provider = google-beta

  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
