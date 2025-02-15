resource "azurerm_container_app" "aca" {
  name                            = "aca-${var.sub}-${var.region}-${var.environment}-${var.domain}${var.name_discriminator}-${var.sequence}"
  resource_group_name             = var.resource_group_name
  container_app_environment_id    = var.container_app_environment_id
  revision_mode                   = var.revision_mode
  workload_profile_name           = var.workload_profile_name
  max_inactive_revisions          = var.max_inactive_revisions

  ingress {
    allow_insecure_connections = var.ingress_allow_insecure_connections
    external_enabled           = var.ingress_external_enabled
    target_port                = var.ingress_target_port
    
    dynamic "traffic_weight" {
      for_each = toset(var.ingress_traffic_weights)

      content {
        latest_revision = traffic_weight.value["latest_revision"]
        percentage      = traffic_weight.value["percentage"]
      }
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aca_user_identity.id]
  }

  registry {
    server   = var.container_registry.login_server
    identity = azurerm_user_assigned_identity.aca_user_identity.id
  }

  dynamic "secret" {
    for_each = toset(var.secrets)

    content {
      name                = secret.value["name"]
      identity            = azurerm_user_assigned_identity.aca_user_identity.id
      key_vault_secret_id = "https://${var.key_vault.name}.vault.azure.net/secrets/${secret.value["key_vault_secret_name"]}"
    }
  }
  
  dynamic "dapr" {
    for_each = var.dapr != null ? [0] : []

    content {
      app_id = var.dapr.app_id
      app_port = var.ingress_target_port
      app_protocol = var.dapr.app_protocol != null ? var.dapr.app_protocol : "http"
    }
  }

  template {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    container {
      name   = var.container.name
      image  = "${var.container_registry.login_server}/${var.container.image_name}:${var.container.image_tag}"
      cpu    = var.container.cpu
      memory = var.container.memory

      startup_probe {
        transport = "HTTP"
        port      = var.ingress_target_port
        path      = "${var.startup_probe_relative_url}?type=startup_probe"
        timeout = 10
      }

      dynamic "env" {
        for_each = toset(var.env_vars)

        content {
          name    = env.value["name"]
          value   = env.value["value"]
        }
      }

      dynamic "env" {
        for_each = toset(var.env_secret_vars)

        content {
          name          = env.value["name"]
          secret_name   = env.value["secret_name"]
        }
      }
    }
  }
}