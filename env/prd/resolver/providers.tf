provider "aws" {
  region = "ap-southeast-1"
  allowed_account_ids = [
    "418156166869", # infra-corpnw-prd (child account of masternewcapital)
  ]

  default_tags {
    tags = {
      environment = "production"
      source      = "https://github.com/SPHTech-Platform/ct-accounts/tree/main/envs/newcapitol/resolver"


      "sph:env"         = "prd"
      "sph:app-tier"    = "1"
      "sph:appteam"     = "Cloud Platform"
      "sph:cost-centre" = "1694"
      "sph:biz-dept"    = "Engineering"
      "sph:product"     = "aws"

      map-migrated = "d-server-00fyc0pr7gc8hv"
    }
  }
}
