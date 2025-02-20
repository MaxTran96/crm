provider "google" {
  project = var.project_id
  region  = var.region
}

# Create VPC
module "vpc" {
  source = "terraform-google-modules/network/google"

  project_id   = var.project_id
  network_name = "${var.app_name}-network"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "${var.app_name}-subnet"
      subnet_ip     = "10.0.0.0/24"
      subnet_region = var.region
    }
  ]
}

module "gke" {
  source = "../../modules/gke"

  project_id         = var.project_id
  region             = var.region
  cluster_name       = "${var.app_name}-prod"
  initial_node_count = 1
  machine_type       = "e2-standard-2"
  network_id         = module.vpc.network_self_link
  subnet_id          = module.vpc.subnets_self_links[0]
  disk_size_gb       = 10
}


module "storage" {
  source = "../../modules/storage"

  project_id  = var.project_id
  bucket_name = "${var.app_name}-prod-${var.project_id}"
  region      = var.region
  environment = "prod"
}
