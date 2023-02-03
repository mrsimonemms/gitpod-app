output "cert_manager" {
  description = "cert-manager configuration"
  sensitive   = true
  value = {
    # Secrets required to make Cloudflare work
    secrets = [
      {
        name  = "cloudflare-solver"
        key   = "apiToken"
        value = var.cloudflare_api_token
      }
    ]
    # ClusterIssuer configuration
    cluster_issuer = jsonencode({
      spec = {
        acme = {
          solvers = [
            {
              dns01 = {
                cloudflare = {
                  apiTokenSecretRef = {
                    name = "cloudflare-solver"
                    key  = "apiToken"
                  }
                }
              }
            }
          ]
        }
      }
    })
  }
}

output "domain_name" {
  description = "The domain name Gitpod will be accessed on"
  value       = var.domain_name
  sensitive   = true
}

output "gitpod_config" {
  description = "Gitpod config builder"
  value = jsonencode({
    blockNewUsers = {
      enabled  = length(var.domain_passlist) > 0
      passlist = var.domain_passlist
    }
    domain = var.domain_name
  })
  sensitive = true
}

output "gitpod_secrets" {
  description = "Gitpod config secrets"
  value       = jsonencode({})
  sensitive   = true
}

output "kubeconfig" {
  description = "Kubernetes config YAML file"
  value       = module.hetzner.kubeconfig
  sensitive   = true
}
