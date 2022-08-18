
resource "random_id" "bucket_id1" {
  byte_length = 16
}

resource "random_integer" "bucket_id2" {
  min = 1
  max = 50000
}

resource "random_password" "bucket_id3" {
  length           = 8
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
  upper            = "false"
}

resource "random_pet" "bucket_id4" {
  #   length = 8
  #   special          = false
  #   override_special = "!#$%&*()-_=+[]{}<>:?"
  #   upper = "false"
}

resource "random_shuffle" "bucket_id5" {
  input        = ["a", "c", "d", "b"]
  result_count = 1
}
output "Bucket5_output" {
  value = random_shuffle.bucket_id5.result
}

resource "random_string" "bucket_id6" {
  length           = 2
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
  upper            = "false"
}

resource "random_uuid" "bucket_id7" {
}

############################################################
resource "google_storage_bucket" "bucket1" {
  name                        = "prasan1-${random_id.bucket_id1.dec}"
  location                    = "US-CENTRAL1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket2" {
  name                        = "prasan2-${random_integer.bucket_id2.result}"
  location                    = "US-CENTRAL1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket3" {
  name                        = "prasan3-${random_password.bucket_id3.result}"
  location                    = "US-CENTRAL1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket4" {
  name                        = "prasan4-${random_pet.bucket_id4.id}"
  location                    = "US-CENTRAL1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket5" {
  name                        = "prasan5-${random_shuffle.bucket_id5.result[0]}"
  location                    = "US-CENTRAL1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket6" {
  name                        = "prasan6-${random_string.bucket_id6.result}"
  location                    = "US-CENTRAL1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket" "bucket7" {
  name                        = "prasan7-${random_uuid.bucket_id7.result}"
  location                    = "US-CENTRAL1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
}