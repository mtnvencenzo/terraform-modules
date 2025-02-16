locals {
  dapr_components = var.dapr != null ? var.dapr.components : []
}