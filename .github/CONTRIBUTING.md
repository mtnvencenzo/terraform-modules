# 🏗️ Contributing to Terraform Modules

Thank you for your interest in contributing to our Terraform Modules collection! We welcome contributions that help improve our reusable Azure infrastructure modules and expand our module catalog.

## 📋 Table of Contents

- [Getting Started](#-getting-started)
- [Development Setup](#-development-setup)
- [Contributing Process](#-contributing-process)
- [Module Standards](#-module-standards)
- [Testing](#-testing)
- [Getting Help](#-getting-help)

## 🚀 Getting Started

### 🧰 Prerequisites

Before you begin, ensure you have the following installed:
- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) (for testing)
- Git
- Azure subscription (for testing modules)

### 🗂️ Project Structure

```
├── modules/                # Terraform modules
│   ├── resource-group/     # Resource group module
│   ├── storage-account/    # Storage account module
│   ├── virtual-network/    # Virtual network module
│   └── ...                 # Other modules
├── examples/               # Usage examples for modules
├── .github/                # GitHub workflows and templates
└── README.md               # Project overview and module catalog
```

### 📐 Module Structure

Each module should follow this standard structure:
```
modules/module-name/
├── README.md               # Module documentation
├── main.tf                 # Main resource definitions
├── variables.tf            # Input variables
├── outputs.tf              # Output values
├── versions.tf             # Provider requirements
└── examples/               # Usage examples (optional)
    └── basic/
        ├── main.tf
        ├── variables.tf
        └── README.md
```

## 💻 Development Setup

1. **Fork and Clone the Repository**
   ```bash
   git clone https://github.com/mtnvencenzo/terraform-modules.git
   cd terraform-modules
   ```

2. **Configure Azure Authentication**
   ```bash
   # Login to Azure
   az login
   
   # Set your subscription
   az account set --subscription "your-subscription-id"
   ```

3. **Test Existing Modules**
   ```bash
   cd modules/resource-group
   terraform init
   terraform validate
   terraform fmt -check
   ```

## 🔄 Contributing Process

### 1. 📝 Before You Start

- **Check for existing modules** to avoid duplicate work
- **Create or comment on an issue** to discuss your proposed module or changes
- **Wait for approval** from maintainers before starting work (required for this repository)

### 2. 🛠️ Making Changes

1. **Create a feature branch**
   ```bash
   git checkout -b feature/new-module-name
   # or
   git checkout -b fix/module-name-issue
   ```

2. **Create or modify modules** following our [module standards](#-module-standards)

3. **Test your module**
   ```bash
   cd modules/your-module
   
   # Validate Terraform syntax
   terraform validate
   
   # Format code
   terraform fmt
   
   # Test with example (if available)
   cd examples/basic
   terraform init
   terraform plan
   ```

4. **Update documentation**
   - Module README with usage examples
   - Root README if adding new module
   - Variable and output descriptions

5. **Commit your changes**
### 3. 📬 Submitting Changes

1. **Push your branch**
   ```bash
   git push origin feature/new-module-name
   ```

2. **Create a Pull Request**
   - Use our [PR template](pull_request_template.md)
   - Fill out all sections completely
   - Link related issues using `Closes #123` or `Fixes #456`
   - Request review from maintainers

## 📏 Module Standards

### 🏗️ Module Best Practices

- **Single Responsibility**: Each module should manage one type of Azure resource or related group
- **Resource Naming**: Use descriptive names with consistent naming conventions
- **Variable Validation**: Include validation rules for input variables
- **Secure Defaults**: Configure resources with security best practices by default
- **Documentation**: Comprehensive README with examples and variable descriptions

### 🧪 Code Quality

```bash
# Format Terraform code
terraform fmt -recursive

# Validate configuration
terraform validate

# Check for security issues (if tfsec is installed)
tfsec modules/

# Validate examples
cd modules/module-name/examples/basic
terraform init && terraform validate
### 📂 File Requirements

#### `versions.tf`
```hcl
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}
```

#### `variables.tf`
```hcl
variable "name" {
  description = "The name of the resource"
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "Name cannot be empty."
  }
}
```

#### `outputs.tf`
```hcl
output "id" {
  description = "The ID of the created resource"
  value       = azurerm_resource.example.id
}
```

### � Module Documentation

Each module must include:

- **README.md** with:
  - Description and purpose
  - Usage examples
  - Requirements (Terraform version, providers)
  - Inputs table (generated from variables)
  - Outputs table (generated from outputs)
  - Resources created
  - Examples link

## 🧪 Testing

### 🔍 Validation Tests
```bash
# Module validation
cd modules/your-module
terraform validate
terraform fmt -check

# Example validation
cd examples/basic
terraform init
terraform validate
terraform plan
```

### � Test Requirements

- **Validation**: All modules must pass `terraform validate`
- **Formatting**: Code must be properly formatted with `terraform fmt`
- **Examples**: Include at least one working example
- **Documentation**: Complete README with usage examples
- **Security**: Pass security scanning (tfsec or similar)

### 🏷️ Version Testing

Test your module with:
- Minimum supported Terraform version
- Latest Terraform version
- Minimum supported provider version
- Latest provider version

## 🆘 Getting Help

### 📡 Communication Channels

- **Issues**: Use GitHub issues for bugs and feature requests
- **Discussions**: Use GitHub Discussions for questions and ideas
- **Email**: Contact maintainers directly for sensitive issues

### 📄 Issue Templates

Use our issue templates for:
- New module requests
- Bug reports
- Feature enhancements

## 📜 License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project (see [LICENSE](../LICENSE)).

---

**Happy Module Building! 🏗️**

For any questions about this contributing guide, please open an issue or contact the maintainers.

### 📄 Issue Templates

Use our issue templates for:
- [Task Stories](./ISSUE_TEMPLATE/task-template.md)
- [User Stories](./ISSUE_TEMPLATE/user-story-template.md)

## 📜 License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project (see [LICENSE](../LICENSE)).

---

**Happy Infrastructure Building! �️**

For any questions about this contributing guide, please open an issue or contact the maintainers.
