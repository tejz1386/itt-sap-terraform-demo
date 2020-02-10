variable csv_input_file_name {}
locals {
  instances = "${csvdecode(file(var.csv_input_file_name))}"
#  instances = "${csvdecode(file("./gcp_server_input.csv"))}"
}

module "shared_vars"{
  source = "../shared_vars"
}

module "csv_output" {
  source = "../csv_output"
  csv_input_file_name = module.shared_vars.csv_input_filename
}


resource "google_compute_address" "internal_with_subnet_and_address" {
  for_each      = { for inst in local.instances : inst.server_name => inst }
    name         = "${each.value.server_name}-backupip"
    subnetwork   = module.shared_vars.subnetname
    address_type = "INTERNAL"
    address      = each.value.backup-ip
    region       = each.value.location
}

