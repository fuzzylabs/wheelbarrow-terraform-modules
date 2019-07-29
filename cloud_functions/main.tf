provider "google" {
  project = var.project
  region  = var.location
}

terraform {
  backend "gcs" {}
}

data "terraform_remote_state" "cloud_storage" {
  backend = "gcs"
  config = {
    bucket   = "${var.billing_org_id}_${var.customer}_${var.project_group}_${var.env}_terraform-state"
    prefix   = "${var.location}/data_stores/cloud_storage"
  }
}

data "archive_file" "default" {
  count       = "${length(var.cloud_functions)}"
  type        = "zip"
  source_dir  = "${var.source_dir}/${lookup(var.cloud_functions[count.index], "name")}"
  output_path = "${path.module}/tmp/${lookup(var.cloud_functions[count.index], "name")}.zip"

}

resource "google_storage_bucket_object" "default" {
  count      = "${length(var.cloud_functions)}"
  name       = "${lookup(var.cloud_functions[count.index], "name")}.zip"
  bucket     = "${var.billing_org_id}_${var.customer}_${var.project_group}_${var.env}_cloud-functions"
  source     = "${path.module}/tmp/${lookup(var.cloud_functions[count.index], "name")}.zip"
  depends_on = ["data.archive_file.default"]
}

resource "google_cloudfunctions_function" "default" {
  count       = "${length(var.cloud_functions)}"
  project     = var.project
  region      = var.location
  name        = "${lookup(var.cloud_functions[count.index], "name")}"
  description = "${lookup(var.cloud_functions[count.index], "description")}"
  runtime     = "${lookup(var.cloud_functions[count.index], "runtime")}"

  available_memory_mb   = "${lookup(var.cloud_functions[count.index], "memory")}"
  source_archive_bucket = "${var.billing_org_id}_${var.customer}_${var.project_group}_${var.env}_cloud-functions"
  source_archive_object = "${lookup(var.cloud_functions[count.index], "name")}.zip"
  trigger_http          = true
  timeout               = 60
  entry_point           = "EntryPoint"
  service_account_email = "${lookup(var.cloud_functions[count.index], "service_account_email")}"

  environment_variables = {
    PROJECT = var.project
    REGION = var.location
    BUCKET = data.terraform_remote_state.cloud_storage.outputs.ml-resources-name
  }
}
