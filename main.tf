resource "null_resource" "cluster" {
  provisioner "local-exec" {
    # Bootstrap script called with private_ip of each node in the clutser
    command = "echo sap_first_deployment"
  }
}