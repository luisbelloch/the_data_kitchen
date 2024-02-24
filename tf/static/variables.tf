variable "cloudflare_zone_id" {}
variable "cloudflare_email" {}
variable "cloudflare_api_key" {}
variable "gcloud_access_token" {}
variable "gcloud_project" {}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "domain" {
  type    = string
  default = "kitchen.luisbelloch.es"
}
