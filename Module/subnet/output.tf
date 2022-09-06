output "subnet_out" {
  value = google_compute_subnetwork.subnet
}

#output "subnet_out_s1" {
#  value = google_compute_subnetwork.subnet["s1"]
  #value = toset(values(module.subnetwork)[*].region)
#}