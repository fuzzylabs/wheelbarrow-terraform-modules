variable "location" {
  description = "The GCP Location in which resources are created"
  type        = string
}

variable "project" {
  description = "The GCP Project in which resources are created, typically $project_group-$env"
  type        = string
}
