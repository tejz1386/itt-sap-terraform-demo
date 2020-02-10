module "shared_vars"{
  source = "../shared_vars"
}

variable csv_input_file_name {}
locals {
#  virtualmachines = "${csvdecode(file("./gcp_server_input.csv"))}"
  virtualmachines = "${csvdecode(file(var.csv_input_file_name))}"
}
    data "null_data_source" "csv_file" {
      inputs = {
#        file_data = "${chomp(file("./gcp_server_input.csv"))}"
        file_data = "${chomp(file(var.csv_input_file_name))}"
               }
}

resource "null_resource" "csv_interpolation_method" {
  count = length(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))))

  triggers = {
    01 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 0)}"
    02 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 1)}"
    03 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 2)}"
    04 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 3)}"
    05 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 4)}"
    06 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 5)}"
    07 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 6)}"
    08 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 7)}"
    09 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 8)}"
    10 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 9)}"
    11 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 10)}"
    12 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 11)}"
    13 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 12)}"
    14 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 13)}"
    15 = "${element(split(",", element(slice(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")), 1, length(split("\n", lookup(data.null_data_source.csv_file.outputs, "file_data")))), count.index)), 14)}"
  }
}

locals {
  server_index   = null_resource.csv_interpolation_method.*.triggers.01
  server_name    = null_resource.csv_interpolation_method.*.triggers.02
  location       = null_resource.csv_interpolation_method.*.triggers.03
  zone           = null_resource.csv_interpolation_method.*.triggers.04
  ipaddr         = null_resource.csv_interpolation_method.*.triggers.05
  backup         = null_resource.csv_interpolation_method.*.triggers.06
  machine_type   = null_resource.csv_interpolation_method.*.triggers.07
  instance_type  = null_resource.csv_interpolation_method.*.triggers.08
  os_disk        = null_resource.csv_interpolation_method.*.triggers.09
  data_disk_01   = null_resource.csv_interpolation_method.*.triggers.10
  data_disk_02   = null_resource.csv_interpolation_method.*.triggers.11
  data_disk_03   = null_resource.csv_interpolation_method.*.triggers.12
  data_disk_04   = null_resource.csv_interpolation_method.*.triggers.13
  disk_number    = null_resource.csv_interpolation_method.*.triggers.14
  ha_enabled     = null_resource.csv_interpolation_method.*.triggers.15
  servercount   = length(local.virtualmachines)
  
  disk_list        = tolist(["${local.data_disk_01}", "${local.data_disk_02}", "${local.data_disk_03}", "${local.data_disk_04}"])
#  server_disk_size = tomap 
# for_each = local.virtualmachines
    server_disk_01 = zipmap("${local.server_name}","${local.data_disk_01}")
    server_disk_02 = zipmap("${local.server_name}","${local.data_disk_02}")
    server_disk_03 = zipmap("${local.server_name}","${local.data_disk_03}")


}
output "server_disk1_consolidation" {
  value = "${local.server_disk_01}"
}
output "server_disk2_consolidation" {
  value = "${local.server_disk_02}"
}
output "server_disk3_consolidation" {
  value = "${local.server_disk_03}"
}
output "server_index" {
  value = "${local.server_index}"
}
output "server_disk_list" {
  value = "${local.disk_list}"
}
output "server_output" {
  value = "${local.server_name}"
}
output "server_location" {
  value = "${local.location}"
}
output "server_ip" {
  value = "${local.ipaddr}"
}
output "backup_ip" {
  value = "${local.backup}"
}
output "server_zone" {
  value = "${local.zone}"
}
output "server_type" {
  value = "${local.instance_type}"
}
output "server_machine_type" {
  value = "${local.machine_type}"
}
output "server_instance_type" {
  value = "${local.instance_type}"
}
output "server_os_disk" {
  value = "${local.os_disk}"
}
output "server_disk_1" {
  value = "${local.data_disk_01}"
}
output "server_disk_2" {
  value = "${local.data_disk_02}"
}
output "server_disk_3" {
  value = "${local.data_disk_03}"
}
output "server_disk_4" {
  value = "${local.data_disk_04}"
}
output "server_disk_number" {
  value = "${local.disk_number}"
}
output "server_count" {
  value = "${local.servercount}"
}


