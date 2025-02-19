resource "google_sql_database_instance" "instance" {
  name             = var.instance_name
  database_version = "POSTGRES_13"
  region           = var.region
  project          = var.project_id

  settings {
    tier = var.instance_tier
    
    backup_configuration {
      enabled                        = true
      start_time                    = "02:00"
      point_in_time_recovery_enabled = true
    }

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.network_id
    }

    insights_config {
      query_insights_enabled = true
    }
  }

  deletion_protection = true
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.instance.name
  project  = var.project_id
}

resource "google_sql_user" "user" {
  name     = var.database_user
  instance = google_sql_database_instance.instance.name
  password = var.database_password
  project  = var.project_id
} 