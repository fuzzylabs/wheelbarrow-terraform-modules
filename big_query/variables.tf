variable "location" {
  description = "The GCP Location in which resources are created"
  type        = string
}

variable "project" {
  description = "The GCP Project in which resources are created"
  type        = string
}

variable "dataset_id" {
  description = "The name of the Big Query dataset"
  type        = string
}
