provider "google" {
  project = var.project
  region  = var.location
}

terraform {
  backend "gcs" {}
}

resource "google_bigquery_dataset" "default" {
  location   = var.location
  dataset_id = var.dataset_id
}
