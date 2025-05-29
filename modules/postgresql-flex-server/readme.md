# Azure PostgreSQL Flexible Server Module

This module creates and configures an Azure PostgreSQL Flexible Server with private networking, high availability, and automated backups. It follows Azure best practices for database deployment and security.

## 🚀 Overview

The PostgreSQL Flexible Server module provides a standardized way to deploy and manage PostgreSQL databases with:
- Private networking integration
- Automated backups
- High availability options
- Flexible scaling
- Zone redundancy
- Custom maintenance windows
- Point-in-time recovery

## 🛠️ Setup

Before using this module, ensure you have:
1. Terraform installed (see [Terraform Commands Guide](../../.readme/terraform-commands.md))
2. Azure credentials configured
3. Virtual network with delegated subnet
4. Private DNS zone for PostgreSQL
5. Appropriate permissions for database creation

## 📦 Usage

```hcl
module "postgresql_flex_server" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/postgresql-flex-server"

  # Required parameters
  resource_group_name    = "my-resource-group"
  location              = "eastus"
  environment           = "dev"
  domain                = "myapp"
  sequence              = "001"
  sub                   = "myapp"
  region                = "eastus"
  
  # Network configuration
  delegated_subnet_id   = "/subscriptions/.../subnets/postgresql-subnet"
  private_dns_zone_id   = "/subscriptions/.../privateDnsZones/postgres.database.azure.com"
  
  # Database configuration
  storage               = 32768  # 32GB
  sku                   = "B_Standard_B1ms"
  postgres_version      = "14"
  administrator_login   = "psqladmin"
  administrator_password = "your-secure-password"
  create_mode           = "Default"

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
| location | string | Azure region for the server |
| environment | string | Environment name (dev, staging, prod) |
| domain | string | Domain name for the server |
| sequence | string | Sequence number for the server |
| sub | string | Subscription identifier |
| region | string | Region identifier |
| delegated_subnet_id | string | ID of the delegated subnet |
| private_dns_zone_id | string | ID of the private DNS zone |
| storage | number | Storage size in MB |
| sku | string | SKU name for the server |
| postgres_version | string | PostgreSQL version |
| administrator_login | string | Administrator username |
| administrator_password | string | Administrator password |
| create_mode | string | Server creation mode |

## 🔧 Optional Parameters

| Name | Type | Default | Description |
|------|------|---------|-------------|
| tags | map(string) | {} | Tags to apply to the server |

## 📤 Outputs

| Name | Description |
|------|-------------|
| server_name | Name of the created PostgreSQL server |
| server_id | Resource ID of the server |
| server_fqdn | Fully qualified domain name of the server |

## 🔒 Security Features

- Private networking
- SSL enforcement
- Automated backups
- Point-in-time recovery
- High availability options
- Zone redundancy
- Network isolation

## 🔗 Related Resources

- [Main Module Documentation](../../README.md)
- [Terraform Commands Guide](../../.readme/terraform-commands.md)
- [Azure PostgreSQL Flexible Server Documentation](https://docs.microsoft.com/en-us/azure/postgresql/flexible-server/overview)

## ⚠️ Notes

- Server names must be globally unique
- Consider using Key Vault for storing administrator credentials
- Review backup retention settings for your needs
- Plan for maintenance windows
- Consider high availability for production workloads
- Monitor storage usage and plan for scaling
- Use private endpoints for enhanced security
- The module prevents accidental destruction of the server
