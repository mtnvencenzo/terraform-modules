# 🔧 Terraform Commands Guide

This document provides examples and explanations for commonly used Terraform commands when working with this repository's modules.

## 📦 Installation

### Windows (Chocolatey)
```bash
# Install Chocolatey from: https://chocolatey.org/install
choco install terraform
```

### macOS (Homebrew)
```bash
brew install terraform
```

### Linux (Package Manager)
```bash
# Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# CentOS/RHEL/Fedora
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf install terraform
```

### Verify Installation
```bash
terraform version
```

## 🚀 Basic Commands

### Initialize Terraform
```bash
# Basic initialization
terraform init

# Initialize with backend configuration for Azure Storage
terraform init -backend-config="storage_account_name=myterraformstate" \
               -backend-config="container_name=tfstate" \
               -backend-config="key=myproject.tfstate" \
               -backend-config="resource_group_name=terraform-state-rg"

# Initialize with upgrade to latest provider versions
terraform init -upgrade

# Initialize with plugin directory (for air-gapped environments)
terraform init -plugin-dir="./terraform.d/plugins"
```

### Validate Terraform Configuration
```bash
# Basic validation (recommended before any operation)
terraform validate

# Validate with JSON output for automation
terraform validate -json
```

### Format Terraform Files
```bash
# Format all .tf files in current directory
terraform fmt

# Format all .tf files recursively (recommended for modules)
terraform fmt -recursive

# Check if files are formatted without making changes
terraform fmt -check

# Show diff of formatting changes
terraform fmt -diff
```

### Plan Infrastructure Changes
```bash
# Basic plan
terraform plan

# Plan with variables file
terraform plan -var-file="environments/dev.tfvars"

# Plan with specific variables
terraform plan -var="environment=dev" -var="location=eastus"

# Save plan to file for review
terraform plan -out=tfplan

# Plan targeting specific module
terraform plan -target="module.storage_account"

# Destroy plan
terraform plan -destroy
```

### Apply Infrastructure Changes
```bash
# Apply with confirmation prompt
terraform apply

# Apply saved plan file
terraform apply tfplan

# Apply with auto-approve (use with caution)
terraform apply -auto-approve

# Apply with variables file
terraform apply -var-file="environments/prod.tfvars"

# Apply targeting specific module
terraform apply -target="module.storage_account"

# Apply with parallel operations limit
terraform apply -parallelism=10
```

## 🔍 State Management Commands

### Show Current State
```bash
# Show current state in human-readable format
terraform show

# Show state in JSON format
terraform show -json

# Show specific resource
terraform show 'module.storage_account.azurerm_storage_account.main'

# Show state file from specific path
terraform show terraform.tfstate
```

### State Operations
```bash
# List all resources in state
terraform state list

# Show specific resource details
terraform state show 'module.storage_account.azurerm_storage_account.main'

# Move resource in state (useful for refactoring)
terraform state mv 'azurerm_storage_account.old' 'module.storage_account.azurerm_storage_account.main'

# Remove resource from state (without destroying)
terraform state rm 'module.storage_account.azurerm_storage_account.main'

# Pull remote state to local file
terraform state pull > terraform.tfstate.backup

# Push local state to remote backend
terraform state push terraform.tfstate
```

### Import Existing Resources
```bash
# Import Azure Storage Account
terraform import 'module.storage_account.azurerm_storage_account.main' \
  '/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.Storage/storageAccounts/{storage-account-name}'

# Import Resource Group
terraform import 'azurerm_resource_group.main' \
  '/subscriptions/{subscription-id}/resourceGroups/{rg-name}'

# Import Key Vault
terraform import 'module.key_vault.azurerm_key_vault.main' \
  '/subscriptions/{subscription-id}/resourceGroups/{rg-name}/providers/Microsoft.KeyVault/vaults/{vault-name}'
```

## 🚀 Advanced Operations


### Output Management
```bash
# Show all outputs
terraform output

# Show specific output
terraform output storage_account_name

# Show outputs in JSON format
terraform output -json

# Show raw output value (useful for scripts)
terraform output -raw storage_account_primary_key
```

### Graph and Dependencies
```bash
# Generate dependency graph
terraform graph

# Generate graph in DOT format and convert to PNG
terraform graph | dot -Tpng > graph.png

# Show provider requirements
terraform providers

# Show provider schemas
terraform providers schema -json
```

## 🛠️ Best Practices

### 1. Development Workflow
```bash
# Recommended development workflow
terraform fmt -recursive          # Format code
terraform validate                # Validate syntax
terraform plan -out=tfplan       # Review changes
terraform apply tfplan            # Apply reviewed plan
```

### 2. Code Quality
- **Always run `terraform fmt -recursive`** before committing changes
  - Ensures consistent formatting across the codebase
  - Makes code reviews easier
  - Prevents formatting-related merge conflicts

- **Always run `terraform validate`** before planning or applying
  - Catches syntax errors early
  - Validates variable types and constraints
  - Ensures resource references are valid

### 3. Variable Management
- **Use `.tfvars` files for environment-specific variables**
  ```bash
  # Directory structure
  environments/
  ├── dev.tfvars
  ├── staging.tfvars
  └── prod.tfvars
  
  # Usage
  terraform plan -var-file="environments/prod.tfvars"
  ```

- **Never commit sensitive values to version control**
  - Use environment variables for secrets
  - Use Azure Key Vault references
  - Use `.gitignore` to exclude `.tfvars` files with secrets

### 4. State Management
- **Use remote state for team collaboration**
  ```hcl
  terraform {
    backend "azurerm" {
      resource_group_name  = "terraform-state-rg"
      storage_account_name = "terraformstatesa"
      container_name       = "tfstate"
      key                  = "project.tfstate"
    }
  }
  ```

- **Always backup state before major operations**
  ```bash
  terraform state pull > backup-$(date +%Y%m%d-%H%M%S).tfstate
  ```

### 5. Module Usage
- **Pin module versions in production**
  ```hcl
  module "storage_account" {
    source = "git::ssh://git@github.com/mtnvencenzo/terraform-modules.git//modules/storage-account?ref=v1.0.0"
    # variables...
  }
  ```

- **Test modules in development first**
  ```hcl
  module "storage_account" {
    source = "git::ssh://git@github.com/mtnvencenzo/terraform-modules.git//modules/storage-account?ref=main"
    # variables...
  }
  ```

## 📚 Additional Resources

### Official Documentation
- [Terraform CLI Documentation](https://www.terraform.io/docs/cli/index.html)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Best Practices](https://www.terraform.io/docs/extend/best-practices/index.html)

### Module Development
- [Module Documentation](../README.md)
- [Contributing Guidelines](../.github/CONTRIBUTING.md)
- [Security Policy](../.github/SECURITY.md)


**For additional help, see our [Support Guide](../.github/SUPPORT.md) or create an issue in the repository.** 