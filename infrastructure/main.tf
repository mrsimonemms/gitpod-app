# Configure the Terraform remote state
# @link https://developer.hashicorp.com/terraform/cli/cloud/settings
terraform {
  cloud {
    workspaces {
      tags = [
        "gitpod",
        "production"
      ]
    }
  }
}

# Configure the infrastructure in Hetzner
module "hetzner" {
  source = "github.com/mrsimonemms/gitpod-self-hosted/infrastructure/providers/hetzner"

  domain_name          = var.domain_name
  location             = var.location
  size                 = var.size
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key_path  = var.ssh_public_key_path
}
