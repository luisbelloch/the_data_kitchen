provider "google-beta" {
  project      = var.gcloud_project
  region       = var.region
  access_token = var.gcloud_access_token
}

resource "google_artifact_registry_repository" "deploydocus" {
  provider      = google-beta
  location      = var.region
  repository_id = var.repository_id
  format        = "DOCKER"

  cleanup_policies {
    id     = "keep-minimum-versions"
    action = "KEEP"
    most_recent_versions {
      keep_count = 2
    }
  }
}
