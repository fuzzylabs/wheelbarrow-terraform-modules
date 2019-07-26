provider "google" {
  project = var.project
  region  = var.location
}

terraform {
  backend "gcs" {}
}

module "cloud_function" {
  source   = "github.com/fuzzylabs/terraform-google-service-account?ref=master"
  location = var.location
  project  = var.project
  name     = "cloud-function"
  roles = [
    "roles/viewer",
    "roles/storage.objectAdmin",
    "roles/ml.developer"
  ]
}
