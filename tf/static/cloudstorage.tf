provider "google" {
  project      = var.gcloud_project
  region       = var.region
  access_token = var.gcloud_access_token
}

resource "google_storage_bucket" "kitchen" {
  name                        = var.domain
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  cors {
    origin          = ["https://${var.domain}"]
    method          = ["GET"]
    response_header = ["*"]
    max_age_seconds = 0
  }

  provisioner "local-exec" {
    command     = "gsutil -m rsync app/docs gs://${self.name}/"
    working_dir = "../.."
  }
}

resource "google_storage_bucket_iam_binding" "kitchen" {
  bucket  = google_storage_bucket.kitchen.name
  role    = "roles/storage.objectViewer"
  members = ["allUsers"]
}
