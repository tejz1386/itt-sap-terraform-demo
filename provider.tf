provider "google" {
    credentials = "${var.credentials}"
    project     = "optimal-pursuit-261608"
    region      = "us-west2"
}