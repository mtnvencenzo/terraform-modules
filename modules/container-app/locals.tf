locals {
  dapr_components = var.dapr != null && var.dapr.components != null ? var.dapr.components : []
}