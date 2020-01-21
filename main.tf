resource "null_resource" "cluster" {
  provisioner "local-exec" {
    # Bootstrap script called with private_ip of each node in the clutser
    command = "echo sap_first_deployment"
  }
}
module "null_resource" {
  source  = "app.terraform.io/bso-cloud-03/null_resource/azure"
  version = "0.0.2"
}