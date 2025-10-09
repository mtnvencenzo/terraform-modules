# resource "azurerm_dns_txt_record" "custom_domain_txt_record" {
#   name                = var.sub_domain == "" ? "asuid" : "asuid.${var.sub_domain}"
#   resource_group_name = var.dns_resource_group_name
#   zone_name           = var.dns_zone_name
#   ttl                 = 300

#   record {
#     value = var.custom_domain_verification_id
#   }
# }

# resource "azurerm_dns_cname_record" "custom_domain_cname_record" {
#   name                = var.sub_domain
#   resource_group_name = var.dns_resource_group_name
#   zone_name           = var.dns_zone_name
#   ttl                 = 3600

#   record = var.container_app_ingress_fqdn
# }

# # Setup the custom domain for the container app with Azure issued certificate
# # https:github.com/hashicorp/terraform-provider-azurerm/issues/21866
# resource "azapi_resource_action" "container_app_hostname" {
#   type        = "Microsoft.App/containerApps@2024-03-01"
#   resource_id = var.container_app_id
#   method      = "PATCH"
#   body = jsonencode({
#     properties = {
#       configuration = {
#         ingress = {
#           customDomains = [{
#             name        = var.sub_domain
#             bindingType = "Disabled"
#           }]
#         }
#       }
#     }
#   })
#   depends_on = [
#     azurerm_dns_txt_record.custom_domain_txt_record
#   ]
# }

# resource "azapi_resource" "container_app_certificate" {
#   type      = "Microsoft.App/managedEnvironments/managedCertificate@2023-05-02-preview"
#   name      = var.sub_domain
#   location  = var.container_app_resource_group_location
#   parent_id = var.container_app_environment_id
#   tags      = local.tags

#   body = jsonencode({
#     properties = {
#       comainControlValidation = "CNAME"
#       subjectName             = var.sub_domain
#     }
#   })

#   depends_on = [
#     azapi_resource_action.container_app_hostname,
#     azurerm_dns_txt_record.custom_domain_txt_record,
#     azurerm_dns_cname_record.custom_domain_cname_record,
#   ]
# }

# resource "azapi_resource_action" "container_app_custom_domain" {
#   type        = "Microsoft.App/containerApps@2024-03-01"
#   resource_id = var.container_app_id
#   method      = "PATCH"
#   body = jsonencode({
#     properties = {
#       configuration = {
#         ingress = {
#           customDomains = [{
#             name          = var.sub_domain
#             bindingType   = "SniEnabled"
#             certificateId = azapi_resource.container_app_certificate.id
#           }]
#         }
#       }
#     }
#   })

#   depends_on = [
#     azapi_resource.container_app_certificate
#   ]

#   provisioner "local-exec" {
#     /*
#         Need custom provisioner to remove custom domain
#         */
#     when    = destroy
#     command = "echo 'Removing custom domain'"
#   }
# }

# resource "azapi_resource_action" "container_app_delete_custom_domain" {
#   type        = "Microsoft.App/containerApps@2024-03-01"
#   resource_id = var.container_app_id
#   when        = "destroy"
#   method      = "PATCH"
#   body = jsonencode({
#     properties = {
#       configuration = {
#         ingress = {
#           customDomains = []
#         }
#       }
#     }
#   })
#   depends_on = [azapi_resource.container_app_certificate]
# }