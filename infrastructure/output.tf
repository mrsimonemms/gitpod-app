output "cert_manager" {
  description = "cert-manager configuration"
  sensitive   = true
  value = {
    # Secrets required to make Cloudflare work
    secrets = {
      cloudflare-solver = {
        apiToken = var.cloudflare_api_token
      }
    }
    # ClusterIssuer configuration
    cluster_issuer = {
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
    }
  }
}

output "domain_name" {
  description = "The domain name Gitpod will be accessed on"
  value       = var.domain_name
  sensitive   = true
}

output "gitpod_config" {
  description = "Gitpod config builder"
  value = {
    authProviders = [
      {
        kind = "secret"
        name = "public-github"
      },
      {
        kind = "secret"
        name = "public-gitlab"
      },
    ]
    blockNewUsers = {
      enabled  = length(var.domain_passlist) > 0
      passlist = var.domain_passlist
    }
    domain = var.domain_name
  }
  sensitive = true
}

output "gitpod_secrets" {
  description = "Gitpod config secrets"
  value = {
    public-github = {
      provider = {
        id   = "Public-GitHub"
        host = "github.com"
        type = "GitHub"
        oauth = {
          clientId     = var.auth_providers.github.client_id
          clientSecret = var.auth_providers.github.client_secret
          callBackUrl  = "https://${var.domain_name}/auth/github.com/callback"
          settingsUrl  = var.auth_providers.github.settings_url
        }
      }
    }
    public-gitlab = {
      provider = {
        id   = "Public-GitLab"
        host = "gitlab.com"
        type = "GitLab"
        oauth = {
          clientId     = var.auth_providers.gitlab.client_id
          clientSecret = var.auth_providers.gitlab.client_secret
          callBackUrl  = "https://${var.domain_name}/auth/gitlab.com/callback"
          settingsUrl  = var.auth_providers.gitlab.settings_url
        }
      }
    }
  }
  sensitive = true
}

output "kubeconfig" {
  description = "Kubernetes config YAML file"
  value       = module.hetzner.kubeconfig
  sensitive   = true
}
