# Note the structure of how we organise resources in GCP
# billing_org_id (organisation) -> customer (folder) -> project_group (folder) -> project (project)

variable "location" {
  description = "The GCP Location in which resources are created"
  type        = string
}

variable "billing_org_id" {
  description = "The ID of the GCP billing organisation"
  type        = string
}

variable "customer" {
  description = "The name of the parent customer (GCP folder) in which the $project_group resides"
  type        = string
}

variable "project_group" {
  description = "The name of the project_group (GCP folder) in which the $project resides"
  type        = string
}

variable "project" {
  description = "The GCP Project in which resources are created, typically $project_group-$env"
  type        = string
}

variable "env" {
  description = "The name of the environment (dev|qa|prod)"
  type        = string
}

variable "source_dir" {
  description = "The path to the source code of the cloud functions"
  type        = string
}

variable "cloud_functions" {
  description = "A list of maps containing cloud function attributes"
  type        = list
  default = [
    {
      "name" : "train",
      "description" : "Training Function",
      "runtime" : "go111",
      "memory" : "128",
      "entry_point" : "Train",
      "service_account_email" : "cloud-function@wheelbarrow-dev.iam.gserviceaccount.com"
    }
  ]
}
