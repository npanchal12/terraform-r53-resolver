variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "Tags for the resources"
  type        = string
  default     = "vpc-00824df13a928c7cd"
}

variable "ip_address" {
  description = "nested block: NestingSet, min items: 2, max items: 10 - The subnets and IP addresses in your VPC that you want DNS queries to pass through on the way from your VPCs to your network (for outbound endpoints) or on the way from your network to your VPCs (for inbound endpoints)."
  type = set(object(
    {
      ip        = optional(string)
      ip_id     = optional(string)
      subnet_id = string
    }
  ))
}

variable "target_ips" {
  description = "AWS based DNS Servers IP"
  type        = list(string)
  default     = ["10.67.23.5", "10.67.23.70"]
}

#########################
# Resource Access Manager
#########################
variable "ram_name" {
  description = "The name of the resource share"
  type        = string
  default     = "corp-dns-resolver"
}

variable "allow_external_principals" {
  description = "Indicates whether principals outside your organization can be associated with a resource share."
  type        = bool
  default     = true
}
