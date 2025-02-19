variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "initial_node_count" {
  description = "Initial number of nodes in the cluster"
  type        = number
  default     = 0
}

variable "machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
  default     = "e2-standard-2"
}

variable "disk_size_gb" {
  description = "Disk size for GKE nodes in GB"
  type        = number
  default     = 10
}

variable "network_id" {
  description = "VPC network self link"
  type        = string
}

variable "subnet_id" {
  description = "Subnet self link"
  type        = string
}

variable "node_service_account" {
  description = "Service account for GKE nodes"
  type        = string
  default     = null
}
