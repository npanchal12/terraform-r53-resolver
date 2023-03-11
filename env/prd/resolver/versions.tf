terraform {
  required_providers {
    # tflint-ignore: terraform_unused_required_providers
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45.0"
    }
  }

  cloud {
    organization = "Jiya"

    workspaces {
      name = "terraform-r53-resolver"
    }
  }
}
