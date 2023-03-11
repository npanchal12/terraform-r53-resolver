module "sph_corp_resolver" {
  source = "../../../modules/resolver"
  ip_address = [
    {
      ip        = null
      ip_id     = null
      subnet_id = "subnet-0f64af1b47fa50049"
    },
    {
      subnet_id = "subnet-00cb55d57a2c8b718"
    },
  ]
}
