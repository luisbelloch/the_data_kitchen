provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

resource "cloudflare_record" "kitchen_full" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain
  value   = "ghs.googlehosted.com"
  type    = "CNAME"
  proxied = false
}
