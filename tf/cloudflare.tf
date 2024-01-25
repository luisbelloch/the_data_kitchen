provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

resource "cloudflare_record" "kitchen" {
  zone_id = var.cloudflare_zone_id
  name    = "kitchen.luisbelloch.es"
  value   = "ghs.googlehosted.com"
  type    = "CNAME"
  proxied = false
}
