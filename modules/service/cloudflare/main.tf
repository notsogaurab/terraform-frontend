provider "aws" {
    region = "us-east-1" 
}


data "cloudflare_zone" "this" {
  name = "gaurabupreti.tech"
}

resource "cloudflare_record" "cloudflare_record" {
  zone_id = data.cloudflare_zone.this.id
  name    = var.domain_name
  value   = var.cloudfront_domain_name
  type    = "CNAME"
  proxied = false
}