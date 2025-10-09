# Azure Container App Module

This module creates and configures an Azure Container App with ingress settings, identity management, Dapr integration, and container specifications. It follows Azure best practices for container deployment and security.

## 🚀 Overview

The Container App module provides a standardized way to deploy and manage containerized applications with:
- Ingress configuration
- Identity management
- Dapr integration
- Container specifications
- Tagging and environment metadata

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. Container registry and Key Vault set up

## 📦 Usage

```hcl
module "container_app" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/container-app"

  # Required parameters
  resource_group_name             = "my-resource-group"
  container_app_environment_id    = "my-environment-id"
  sub                             = "myapp"
  region                          = "eastus"
  environment                     = "dev"
  domain                          = "myapp"
  name_discriminator              = "app"
  sequence                        = "001"
  container_registry              = {
    login_server = "myregistry.azurecr.io"
  }
  key_vault                       = {
    name = "mykeyvault"
  }
  container                       = {
    name       = "mycontainer"
    image_name = "myimage"
    image_tag  = "latest"
    cpu        = "0.5"
    memory     = "1Gi"
  }
  secrets                         = [
    {
      name                = "secret1"
      key_vault_secret_name = "secret1"
    }
  ]
  env_vars                        = [
    {
      name  = "ENV_VAR1"
      value = "value1"
    }
  ]
  env_secret_vars                 = [
    {
      name        = "SECRET_VAR1"
      secret_name = "secret1"
    }
  ]
  ingress_allow_insecure_connections = false
  ingress_external_enabled           = true
  ingress_target_port                = 80
  ingress_traffic_weights            = [
    {
      latest_revision = true
      percentage      = 100
    }
  ]
  dapr                             = {
    app_id       = "myapp"
    app_protocol = "http"
  }
  min_replicas                     = 1
  max_replicas                     = 3
  startup_probe_relative_url       = "/health"

  tags = {
    Environment = "dev"
    Project     = "MyProject"
  }
}
```

## 📋 Required Parameters

| Name | Type | Description |
|------|------|-------------|
| resource_group_name | string | Name of the resource group |
| container_app_environment_id | string | ID of the container app environment |
| sub | string | Subscription identifier |
| region | string | Azure region for the container app |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the container app |
| name_discriminator | string | Unique identifier for the container app |
| sequence | string | Sequence number for the container app |
| container_registry | object | Container registry configuration |
| key_vault | object | Key Vault configuration |
| container | object | Container configuration |
| secrets | list(object) | List of secrets to be used by the container app |
| env_vars | list(object) | List of environment variables |
| env_secret_vars | list(object) | List of environment variables using secrets |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| ingress_allow_insecure_connections | bool | false | Allow insecure connections |
| ingress_external_enabled | bool | true | Enable external ingress |
| ingress_target_port | number | 80 | Target port for ingress |
| ingress_traffic_weights | list(object) | [] | Traffic weights for ingress |
| dapr | object | null | Dapr configuration |
| min_replicas | number | 1 | Minimum number of replicas |
| max_replicas | number | 3 | Maximum number of replicas |
| startup_probe_relative_url | string | "/health" | Relative URL for startup probe |
| tags | map(string) | {} | Tags to apply to the container app |

## 📤 Outputs

| Name | Description |
|------|-------------|
| container_app_name | Name of the created container app |
| container_app_id | Resource ID of the container app |

## 🔒 Security Features

- Identity management
- Secret management
- Ingress configuration
- Dapr integration

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure Container Apps Documentation](https://docs.microsoft.com/en-us/azure/container-apps/)

## ⚠️ Notes

- Container app names must be unique within the environment
- Review ingress settings for your environment
- Ensure Key Vault and Container Registry are properly configured
- Consider using private endpoints for enhanced security
