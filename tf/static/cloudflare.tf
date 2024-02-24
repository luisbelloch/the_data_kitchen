provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

resource "cloudflare_record" "kitchen" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain
  value   = "c.storage.googleapis.com"
  type    = "CNAME"
  proxied = true
}
