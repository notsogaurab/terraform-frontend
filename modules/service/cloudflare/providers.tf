terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.0"
    }
  }
}

provider "cloudflare" {
  retries = 1
  
}
