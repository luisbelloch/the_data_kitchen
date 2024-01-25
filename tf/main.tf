terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.9.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.72.1"
    }
  }
}
