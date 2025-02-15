locals {
  dapr_components = var.dapr != null && var.dapr.dapr_components != null ? var.dapr.components : []
}