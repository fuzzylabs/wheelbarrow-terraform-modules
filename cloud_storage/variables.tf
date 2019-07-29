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

variable "storage_class" {
  description = "The storage class of the Cloud Storage Bucket"
  type        = string
  default     = "REGIONAL"
}
