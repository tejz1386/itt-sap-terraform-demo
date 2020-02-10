module "shared_vars"{
  source = "../shared_vars"
}
module "csv_output" {
  source = "../csv_output"
  csv_input_file_name = module.shared_vars.csv_input_filename
}
module "vm_creation_module_csv" {
  source = "../vm_creation_module_csv"
  csv_input_file_name = module.shared_vars.csv_input_filename
}
module "disk_creation_1" {
  source = "../disk_creation_2"
  server_size =  module.csv_output.server_disk1_consolidation
  disk_number = "disk-01"
  csv_input_file_name = module.shared_vars.csv_input_filename
}
module "disk_creation_2" {
  source = "../disk_creation_2"
  server_size =  module.csv_output.server_disk2_consolidation
  disk_number = "disk-02"
  csv_input_file_name = module.shared_vars.csv_input_filename
}
module "disk_creation_3" {
  source = "../disk_creation_2"
  server_size =  module.csv_output.server_disk3_consolidation
  disk_number = "disk-03"
  csv_input_file_name = module.shared_vars.csv_input_filename
}
module "network_creation" {
  source = "../network_creation"
  csv_input_file_name = module.shared_vars.csv_input_filename
}
