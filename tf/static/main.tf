terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.23.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.13.0"
    }
  }
}
