module "null_resource" {
  source  = "app.terraform.io/bso-cloud-03/null_resource/azure"
  version = "0.0.2"
}
module "shared_vars"{
  source = "./shared_vars"
}
#module "vm_creation_module_csv" {
#  source = "./vm_creation_module_csv"
#  csv_input_file_name = module.shared_vars.csv_input_filename
#}
module "csv_output" {
  source = "./csv_output"
  csv_input_file_name = module.shared_vars.csv_input_filename
}
#module "disk_creation" {
#  source = "./disk_creation"
#}


module "app_vm_build" {
  source = "./app_vm_build"
}




# output values
output "server_consolidation_1" {
  value = module.csv_output.server_disk1_consolidation
}
output "server_consolidation_2" {
  value = module.csv_output.server_disk1_consolidation
}
output "server_consolidation_3" {
  value = module.csv_output.server_disk1_consolidation
}

output "server_value" {
  value = module.csv_output.server_output
}
output "disk1" {
  value = module.csv_output.server_disk_1
}
output "disk2" {
  value = module.csv_output.server_disk_2
}
output "disk3" {
  value = module.csv_output.server_disk_3
}
output "disk4" {
  value = module.csv_output.server_disk_4
}
output "disk_number" {
  value = module.csv_output.server_disk_number
}
output "location" {
  value = module.csv_output.server_location
}
output "zone" {
  value = module.csv_output.server_zone
}
output "machinetype" {
  value = module.csv_output.server_machine_type
}
output "instancetype" {
  value = module.csv_output.server_instance_type
}
output "osdisk" {
  value = module.csv_output.server_os_disk
}
output "data_disk_list" {
  value = module.csv_output.server_disk_list
}
