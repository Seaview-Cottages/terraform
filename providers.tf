terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}


provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "random" {
}
