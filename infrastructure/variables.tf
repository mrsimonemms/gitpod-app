
# Common variables
variable "domain_name" {
  description = "The domain name Gitpod will be accessed on"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Data centre location - this is dependent upon your provider"
  type        = string
}

variable "size" {
  description = "Deployment size"
  type        = string
  default     = "small"

  validation {
    error_message = "Value must be small, medium or large"
    condition     = contains(["small"], var.size)
  }
}

## Specific to this deployment
variable "cloudflare_api_token" {
  description = "API token for Cloudflare"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Zone ID to place DNS records in"
  type        = string
}


variable "ssh_public_key_path" {
  description = "Path to public key, used for logging in to VM - passphrases are not supported"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key_path" {
  description = "Path to private key, used for logging in to VM - passphrases are not supported"
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "domain_passlist" {
  description = "Passlist for domains that are allowed to sign up to the instance"
  type        = list(string)
  default     = []
}
