resource "cloudflare_zone" "seaviewcottages_org" {
  account_id = var.cloudflare_account_id
  zone       = "seaviewcottages.org"
}

module "seaviewcottages_org_email" {
  source = "./modules/topicbox"

  zone_id = cloudflare_zone.seaviewcottages_org.id
  fqdn    = cloudflare_zone.seaviewcottages_org.zone

  dmarc_report_address = "mailto:c1c91df0f9af4bf8a626bd6a95e17ec5@dmarc-reports.cloudflare.net"
}

resource "cloudflare_record" "github_verification" {
  zone_id = cloudflare_zone.seaviewcottages_org.id
  type    = "TXT"
  name    = "_github-pages-challenge-Seaview-Cottages"
  content = "ee4c340666bfa62bea190b41d9db32"
}

locals {
  ses_verification_records = {
    "n4xtwin3tfhenbiggqobv2jizmbodcrz._domainkey.seaviewcottages.org" : "n4xtwin3tfhenbiggqobv2jizmbodcrz.dkim.amazonses.com",
    "cx4blsipd5ul3fh3mryhzr75zn2rfya2._domainkey.seaviewcottages.org" : "cx4blsipd5ul3fh3mryhzr75zn2rfya2.dkim.amazonses.com",
    "dffmkhmxpyhvt4rbxg5asylfgzdgcvxv._domainkey.seaviewcottages.org" : "dffmkhmxpyhvt4rbxg5asylfgzdgcvxv.dkim.amazonses.com"
  }
}

resource "cloudflare_record" "ses_dkim" {
  for_each = tomap(local.ses_verification_records)

  zone_id = cloudflare_zone.seaviewcottages_org.id
  type    = "CNAME"
  name    = each.key
  content = each.value
  proxied = false
}

resource "cloudflare_record" "ses_mail_from_mx" {
  zone_id  = cloudflare_zone.seaviewcottages_org.id
  type     = "MX"
  name     = "bounces.seaviewcottages.org"
  priority = 10
  content  = "feedback-smtp.us-west-2.amazonses.com"
}

resource "cloudflare_record" "ses_mail_from_txt" {
  zone_id = cloudflare_zone.seaviewcottages_org.id
  type    = "TXT"
  name    = "bounces.seaviewcottages.org"
  content = "v=spf1 include:amazonses.com ~all"
}

resource "cloudflare_record" "payhoa_web_www" {
  zone_id = cloudflare_zone.seaviewcottages_org.id
  type    = "CNAME"
  name    = "www.seaviewcottages.org"
  content = "seaview-cottages-coa.site.payhoa.com"
}

resource "cloudflare_record" "payhoa_web_root" {
  zone_id = cloudflare_zone.seaviewcottages_org.id
  type    = "CNAME"
  name    = "seaviewcottages.org"
  content = "seaview-cottages-coa.site.payhoa.com"
}

resource "cloudflare_record" "payhoa_web_root" {
  zone_id = cloudflare_zone.seaviewcottages_org.id
  type    = "CNAME"
  name    = "_c2476283602c38f0ad4d6105bcb4e9de.seaviewcottages.org"
  content = "_93962a83ee790fa40991ba2f6596657e.jkddzztszm.acm-validations.aws."
}
