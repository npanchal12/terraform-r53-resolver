#############
# Route53 resolver
#############
resource "aws_route53_resolver_rule" "this" {
  name                 = "sphnet_com_sg"
  domain_name          = "sphnet.com.sg"
  resolver_endpoint_id = aws_route53_resolver_endpoint.this.id
  rule_type            = "FORWARD"
  target_ip {
    ip = "123.45.67.89"
  }

  target_ip {
    ip = "123.45.67.81"
  }
}

# Create a Route 53 Resolver endpoint
resource "aws_route53_resolver_endpoint" "this" {
  direction          = "OUTBOUND"
  name               = "resolver-corp-dns"
  security_group_ids = [aws_security_group.this.id]
  tags               = var.tags

  dynamic "ip_address" {
    for_each = var.ip_address
    content {
      ip        = ip_address.value["ip"]
      subnet_id = ip_address.value["subnet_id"]
    }
  }
}

resource "aws_route53_resolver_rule_association" "this" {
  resolver_rule_id = aws_route53_resolver_rule.this.id
  vpc_id           = var.vpc_id
}

# Create a security group
resource "aws_security_group" "this" {
  name_prefix = "example"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###############################
# Resource Access Manager (RAM)
###############################
resource "aws_ram_resource_share" "this" {
  name                      = var.ram_name
  allow_external_principals = var.allow_external_principals

  tags = (
    var.tags
  )
}

resource "aws_ram_resource_association" "this" {
  resource_arn       = aws_route53_resolver_rule.this.arn
  resource_share_arn = aws_ram_resource_share.this.arn
  depends_on = [
    aws_route53_resolver_rule.this
  ]
}

resource "aws_ram_principal_association" "this" {
  principal          = aws_organizations_organization.org.arn
  resource_share_arn = aws_ram_resource_share.this.arn
}

resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set = "ALL"
}
