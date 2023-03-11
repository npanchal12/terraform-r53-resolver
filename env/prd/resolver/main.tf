module "sph_corp_resolver" {
  source = "../../../modules/resolver"
  ip_address = [
    {
      ip        = null
      ip_id     = null
      subnet_id = "subnet-0e0fa656e9b3e3287"
    },
    {
      subnet_id = "subnet-0b6450fc97b23be2f"
    },
  ]
}
