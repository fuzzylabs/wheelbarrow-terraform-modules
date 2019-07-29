provider "google" {
  project = var.project
  region  = var.location
}

terraform {
  backend "gcs" {}
}

# Bucket names must be globally unique, hence the naming convention.
resource "google_storage_bucket" "cloud_functions" {
  location      = var.location
  name          = "${var.billing_org_id}_${var.customer}_${var.project_group}_${var.env}_cloud-functions"
  storage_class = var.storage_class
}

resource "google_storage_bucket" "ml_resources" {
  location      = var.location
  name          = "${var.billing_org_id}_${var.customer}_${var.project_group}_${var.env}_ml-resources"
  storage_class = var.storage_class
}
