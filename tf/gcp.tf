provider "google" {
  project      = var.gcloud_project
  region       = "europe-west1"
  access_token = var.gcloud_access_token
}

resource "google_project_service" "run_api" {
  service            = "run.googleapis.com"
  disable_on_destroy = true
}

resource "google_cloud_run_service" "kitchen" {
  name     = "kitchen"
  location = "europe-west1"

  template {
    spec {
      containers {
        image = "eu.gcr.io/${var.gcloud_project}/luisbelloch/kitchen:${var.image_tag}"
        ports {
          container_port = 3000
        }
        resources {
          limits = {
            "cpu"  = "1000m"
            memory = "128Mi"
          }
        }
      }
    }
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = "0",
        "autoscaling.knative.dev/maxScale" = "2"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_project_service.run_api]
}

data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.kitchen.location
  project     = google_cloud_run_service.kitchen.project
  service     = google_cloud_run_service.kitchen.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_domain_mapping" "kitchen" {
  location = "europe-west1"
  name     = "kitchen.luisbelloch.es"

  metadata {
    namespace = var.gcloud_project
  }

  spec {
    route_name = google_cloud_run_service.kitchen.name
  }
}

output "kitchen_url" {
  value = google_cloud_run_service.kitchen.status[0].url
}
