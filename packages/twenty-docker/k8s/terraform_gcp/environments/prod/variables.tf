variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "database_user" {
  description = "Database user name"
  type        = string
  default     = "postgres"
}

variable "database_password" {
  description = "Database user password"
  type        = string
  sensitive   = true
}

variable "app_name" {
  description = "Application name used as prefix for all resources"
  type        = string
  default     = "saleda"
}
