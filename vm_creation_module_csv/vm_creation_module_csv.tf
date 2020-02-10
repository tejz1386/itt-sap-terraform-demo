variable csv_input_file_name {}
locals {
#  instances = "${csvdecode(file("./gcp_server_input.csv"))}"
  instances = "${csvdecode(file(var.csv_input_file_name))}"
}
module "shared_vars"{
  source = "../shared_vars"
}
module "csv_output" {
  source = "../csv_output"
  csv_input_file_name = module.shared_vars.csv_input_filename
}
locals {
  env = "${terraform.workspace}"
}


resource "google_compute_address" "internal_with_subnet_and_address" {
  for_each      = { for inst in local.instances : inst.server_name => inst }
    name         = "${each.value.server_name}-dataip"
    subnetwork   = module.shared_vars.subnetname
    address_type = "INTERNAL"
    address      = each.value.ipaddr
    region       = each.value.location
}

resource "google_compute_instance" "instancecreationcsv" {
  for_each      = { for inst in local.instances : inst.server_name => inst }
  name          = each.value.server_name
  machine_type  = each.value.machine_type
  zone          = each.value.zone

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = each.value.instance_type
    }
  }

  network_interface {
    subnetwork = module.shared_vars.subnetname
    network_ip = each.value.ipaddr
    alias_ip_range {
      ip_cidr_range = each.value.backup-ip
#      subnetwork_range_name  = module.shared_vars.subnetname
    }
  }
  lifecycle {
    ignore_changes = [attached_disk]
  }
  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

