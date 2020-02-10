provider "google" {
    credentials = "${var.credentials}"
    project     = "us106484-09122019"
    region      = "us-west2"
}