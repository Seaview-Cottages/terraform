resource "cloudflare_zone" "seaviewcottages_org" {
  account_id = var.cloudflare_account_id
  zone       = "seaviewcottages.org"
}

module "seaviewcottages_org_email" {
  source = "./modules/topicbox"

  zone_id = cloudflare_zone.seaviewcottages_org.id
  fqdn    = cloudflare_zone.seaviewcottages_org.zone
}

resource "cloudflare_record" "github_verification" {
  zone_id = cloudflare_zone.seaviewcottages_org.id
  type    = "TXT"
  name    = "_github-pages-challenge-Seaview-Cottages"
  content = "ee4c340666bfa62bea190b41d9db32"
}