# Azure Terraform Modules

A comprehensive collection of reusable Terraform modules for Azure cloud infrastructure deployment. This repository contains modular, production-ready infrastructure components that follow Azure best practices and security standards.

## 🚀 Overview

This repository provides a set of Terraform modules for deploying and managing Azure resources in a consistent, secure, and maintainable way. The modules are designed to be reusable, configurable, and follow infrastructure-as-code best practices.

## 🛠️ Setup

To get started with these Terraform modules, you'll need to:

1. Install [Terraform](https://www.terraform.io/downloads.html) (>= 1.0.0)
2. Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
3. Configure your Azure credentials
4. Clone this repository

For detailed information about using Terraform with these modules, including common commands and best practices, see our [Terraform Commands Guide](.readme/terraform-commands.md).

## 🏗️ Available Modules

### API Management
- `apim-api` - Azure API Management API configuration
- `apim-simple-api` - Simplified API Management setup

### Compute & Containers
- `container-app` - Azure Container Apps deployment
- `container-app-custom-domain` - Custom domain configuration for Container Apps

### Databases
- `cosmos-db-account` - Cosmos DB account setup
- `cosmos-db-sql-db` - Cosmos DB SQL database configuration
- `postgresql-flex-server` - PostgreSQL Flexible Server deployment

### AI & Search
- `ai-search` - Azure AI Search service setup
- `ai-search-cosmos-index-simple` - Simplified Cosmos DB index configuration for Azure AI Search

### Messaging & Event Processing
- `eventhub-namespace` - Event Hub Namespace configuration
- `servicebus-namespace` - Service Bus Namespace setup
- `servicebus-queue` - Service Bus Queue configuration
- `servicebus-topic` - Service Bus Topic setup
- `servicebus-subscription` - Service Bus Subscription configuration
- `servicebus-subscription-rule` - Service Bus Subscription Rules

### Storage
- `storage-account` - Azure Storage Account configuration
- `storage-container` - Storage Container setup

### Networking & CDN
- `frontdoor-cdn-endpoint-with-origin` - Azure Front Door CDN configuration
- `dns-apex-domain-record` - DNS Apex Domain Record setup
- `dns-mx-record` - DNS MX Record configuration
- `dns-sub-domain-record` - DNS Subdomain Record setup
- `dns-txt-record` - DNS TXT Record configuration

### Security & Monitoring
- `key-vault` - Azure Key Vault setup
- `appinsights-availability-test` - Application Insights availability testing

### Communication Services
- `communication-service` - Azure Communication Services setup
- `email-communication-service` - Email Communication Service configuration

## 🛠️ Technologies Used

- **Terraform** - Infrastructure as Code (IaC) tool
- **Azure Cloud Services**:
  - Azure API Management
  - Azure Container Apps
  - Azure Cosmos DB
  - Azure Event Hub
  - Azure Service Bus
  - Azure Storage
  - Azure Front Door
  - Azure Key Vault
  - Azure Application Insights
  - Azure Communication Services
  - Azure DNS
  - Azure PostgreSQL Flexible Server

## 🔒 Security Features

- TLS 1.2 enforcement
- Private endpoints where applicable
- Network security rules
- Role-based access control (RBAC)
- Key Vault integration
- Secure secret management

## 🚦 Prerequisites

- Terraform >= 1.0.0
- Azure CLI
- Azure subscription
- Appropriate Azure permissions

## 📦 Usage

Each module can be used independently. Here's a basic example of how to use a module:

```hcl
module "storage_account" {
  source = "git::ssh://git@github.com/mtnvencenzo/Terraform-Modules.git//modules/storage-account"

  resource_group_name = "my-resource-group"
  location           = "eastus"
  environment        = "prod"
  domain            = "myapp"
  name_discriminator = "storage"
}
```

### GitHub Workflow Access

To access these modules from a GitHub workflow, you'll need to set up SSH authentication. Here's an example workflow configuration:

```yaml
jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Add ssh key to ssh-agent
        uses: webfactory/ssh-agent@v0.7.0
        with:
          ssh-private-key: ${{ secrets.terraform_module_repo_access_key_secret }}

      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: "1.0.0"

      - name: Terraform Init
        run: terraform init
```

Make sure to:
1. Add your SSH private key as a repository secret named `terraform_module_repo_access_key_secret`.  This should match the corresponding public key in the repository.
2. Ensure the workflow has the necessary permissions to access the secrets

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## ⚠️ Disclaimer

These modules are provided as-is, without warranty of any kind. Always review the configuration before deploying to production environments.
