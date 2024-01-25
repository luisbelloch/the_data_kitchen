variable "cloudflare_zone_id" {}
variable "cloudflare_email" {}
variable "cloudflare_api_key" {}
variable "gcloud_access_token" {}
variable "gcloud_project" {}

variable "image_tag" {
  type    = string
  default = "latest"
}
