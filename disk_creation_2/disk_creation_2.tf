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

variable server_size {}
variable disk_number {}

resource "google_compute_attached_disk" "attachdisk" {
  for_each      = { for inst in local.instances : inst.server_name => inst }
    disk     =  google_compute_disk.testdisk[each.key].self_link
    instance = each.value.server_name
    zone = each.value.zone
}
resource "google_compute_disk" "testdisk" {
  for_each      = { for inst in local.instances : inst.server_name => inst }
      name  = "${each.value.server_name}-${each.value.data_disk_01}-${var.disk_number}"
      size  = var.server_size[each.key]
      type  = "pd-ssd"
      zone  = each.value.zone
    labels = {
      environment = module.shared_vars.env_suffix
    }
    physical_block_size_bytes = 4096
}

