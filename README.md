# Azure Terraform Modules

A comprehensive collection of reusable Terraform modules for Azure cloud infrastructure deployment. This repository contains modular, production-ready infrastructure components that follow Azure best practices and security standards.

## 🚀 Overview

This repository provides a set of Terraform modules for deploying and managing Azure resources in a consistent, secure, and maintainable way. The modules are designed to be reusable, configurable, and follow infrastructure-as-code best practices.

## 🛠️ Setup

To get started with these Terraform modules, you'll need to:

1. Install [Terraform](https://www.terraform.io/downloads.html) (>= 1.5.0)
2. Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (>= 2.50.0)
3. Configure your Azure credentials (`az login`)
4. Clone this repository or reference modules directly from Git

For detailed information about using Terraform with these modules, including common commands and best practices, see our [Terraform Commands Guide](.readme/terraform-commands.md).

## 🔧 Terraform Commands

New to Terraform or need a quick reference? Check out our comprehensive [Terraform Commands Guide](.readme/terraform-commands.md) which includes:

- **Basic Commands**: `init`, `plan`, `apply`, `fmt`, `validate`
- **Advanced Operations**: State management, importing resources, troubleshooting
- **Best Practices**: Formatting, validation, environment management
- **Common Issues**: Solutions for state locks, plugin issues, and more
- **Team Workflows**: Remote state, workspaces, and collaboration tips

The guide provides practical examples and explanations for all the Terraform commands you'll need when working with these modules.

## 🏗️ Available Modules

### API Management
- `apim-api` - Azure API Management API configuration
- `apim-cors-policy-fragment` - CORS policy fragment for API Management
- `apim-jwtvalidate-policy-fragment` - JWT validation policy fragment for API Management

### Compute & Containers
- `container-app` - Azure Container Apps deployment
- `container-app-custom-domain` - Custom domain configuration for Container Apps
- `container-app-custom-domain-complete` - Complete custom domain setup for Container Apps
- `container-registry` - Azure Container Registry deployment

### Databases
- `cosmos-db-account` - Cosmos DB account setup
- `cosmos-db-sql-db` - Cosmos DB SQL database configuration
- `postgresql-flex-server` - PostgreSQL Flexible Server deployment

### AI & Cognitive Services
- `ai-search` - Azure AI Search service setup
- `ai-search-cosmos-index-simple` - Simplified Cosmos DB index configuration for Azure AI Search
- `cognitive-deployment` - Azure OpenAI and Cognitive Services deployment

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
  - Azure Container Registry
  - Azure Cosmos DB
  - Azure Cognitive Services
  - Azure Event Hub
  - Azure Service Bus
  - Azure Storage
  - Azure Front Door
  - Azure Key Vault
  - Azure Application Insights
  - Azure Communication Services
  - Azure DNS
  - Azure PostgreSQL Flexible Server
  - Azure AI Search

## 🔒 Security Features

- TLS 1.2 enforcement
- Private endpoints where applicable
- Network security rules
- Role-based access control (RBAC)
- Key Vault integration
- Secure secret management

## 🚦 Prerequisites

- Terraform >= 1.5.0
- Azure CLI >= 2.50.0
- Azure subscription
- Appropriate Azure permissions

## 📦 Usage

Each module can be used independently. Here's a basic example of how to use a module:

```hcl
module "storage_account" {
  source = "git::ssh://git@github.com/mtnvencenzo/terraform-modules.git//modules/storage-account"

  sub                = "vec"
  region            = "eus"
  environment       = "prod"
  domain            = "myapp"
  name_discriminator = "storage"
  sequence          = "001"
  resource_group_name = "my-resource-group"
  resource_group_location = "East US"
}
```

### 🏷️ Naming Convention

All modules follow a consistent naming convention for Azure resources:
- **Format**: `{service}-{sub}-{region}-{environment}-{domain}-{name_discriminator}-{sequence}`
- **Example**: `st-vec-eus-prod-myapp-storage-001`

**Common Variables:**
- `sub` - Subscription identifier (default: "vec")
- `region` - Azure region abbreviation (default: "eus" for East US)
- `environment` - Environment name (dev, test, prod)
- `domain` - Application or project domain
- `name_discriminator` - Resource-specific identifier
- `sequence` - Sequential number for uniqueness

### 🏷️ Version Pinning

For production use, it's recommended to pin modules to specific versions or tags:

```hcl
module "storage_account" {
  source = "git::ssh://git@github.com/mtnvencenzo/terraform-modules.git//modules/storage-account?ref=v1.0.0"
  # module variables...
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
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: "1.5.0"

      - name: Terraform Init
        run: terraform init
```

Make sure to:
1. Add your SSH private key as a repository secret named `terraform_module_repo_access_key_secret`.  This should match the corresponding public key in the repository.
2. Ensure the workflow has the necessary permissions to access the secrets

## 🌐 Community & Support

- 🤝 **Contributing Guide** – review expectations and workflow in [CONTRIBUTING.md](./.github/CONTRIBUTING.md)  
- 🤗 **Code of Conduct** – help us keep the community welcoming by reading [CODE_OF_CONDUCT.md](./.github/CODE_OF_CONDUCT.md)  
- 🆘 **Support Guide** – find help channels in [SUPPORT.md](./.github/SUPPORT.md)  
- 🔒 **Security Policy** – report vulnerabilities responsibly via [SECURITY.md](./.github/SECURITY.md) 


## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Disclaimer

These modules are provided as-is, without warranty of any kind. Always review the configuration before deploying to production environments.
