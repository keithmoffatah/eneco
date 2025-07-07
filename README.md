# 🚀 Databricks Workspace IaC for Multi-Team Collaboration

This repository provisions a secure, modular Databricks environment for a large energy company. Teams can run workloads, share data and models, and follow RBAC best practices — all automated with **Terraform** and **GitHub Actions**.

---

## ⚡ Quickstart

1. **Clone the repo:**
   ```bash
   git clone <repo-url>
   cd <repo-folder>
   ```
2. **Set up GitHub secrets** (see Security & Secrets Management below).
3. **Run locally:**
   ```bash
   terraform init
   terraform plan -var-file="terraform.tfvars"
   terraform apply -var-file="terraform.tfvars"
   ```

---

## 📚 Table of Contents

- [Infrastructure Overview](#infrastructure-overview)
- [Project Structure](#project-structure)
- [Modules](#modules)
- [How to Use](#how-to-use)
- [Security & Secrets Management](#security--secrets-management)
- [Future Improvements](#future-improvements)
- [Assumptions & Challenges](#assumptions--challenges)

---

## 📌 Infrastructure Overview

- **Databricks Workspace:** Premium SKU workspace for multiple teams
- **Storage Account:** Azure Data Lake Storage Gen2 for shared data/models
- **RBAC:** Databricks user groups, memberships, and cluster permissions
- **CI/CD:** Automated deploys with `terraform plan` and `apply` on `main` branch

---

## 🗂️ Project Structure

```
modules/
  databricks_workspace/   # Databricks workspace and cluster
  storage_account/        # ADLS Gen2 for data/model sharing
  rbac/                   # Databricks groups, users, permissions
  key_vault/              # Azure Key Vault for secrets
main.tf                   # Root module wiring
variables.tf              # Input variables
outputs.tf                # Root outputs
provider.tf               # Provider configuration
environments/             # Example tfvars for dev/prod
```

---

## 🗂️ Modules

| Module                  | Description                                                   |
|-------------------------|---------------------------------------------------------------|
| `databricks_workspace/` | Creates Azure resource group, Databricks workspace, shared cluster |
| `storage_account/`      | Provisions ADLS Gen2 for team data & model sharing            |
| `rbac/`                 | Defines Databricks groups, adds users, and sets cluster permissions |
| `key_vault/`            | Provisions Azure Key Vault and stores Databricks PAT securely |

---

## ⚙️ How to Use

### Pre-requisites

- Terraform >= 1.5.0
- Azure subscription (`az login` configured)
- Databricks Personal Access Token (PAT)
- GitHub repository with encrypted secrets:
  - `ARM_CLIENT_ID`
  - `ARM_CLIENT_SECRET`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`
  - `DATABRICKS_TOKEN`
  - `KEY_VAULT_NAME`

### Running Locally

```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

---

## 🔐 Security & Secrets Management

### Key Vault Integration

- A Key Vault is provisioned automatically via the `key_vault` module.
- The Databricks PAT is stored as a secret named `databricks-pat` in the Key Vault.
- The CI/CD pipeline fetches the PAT from Key Vault at runtime and injects it into Terraform as an environment variable.

### Required GitHub Secrets

- `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`: Azure service principal credentials
- `KEY_VAULT_NAME`: The name of the Key Vault created by this project

### Rotating the Databricks PAT in Key Vault

For security, rotate the Databricks PAT in Azure Key Vault every 45 days:
1. Generate a new PAT in Databricks.
2. Update the secret in Key Vault:
   ```sh
   az keyvault secret set \
     --vault-name <KEY_VAULT_NAME> \
     --name databricks-pat \
     --value <NEW_PAT_VALUE>
   ```
3. The next pipeline run will use the new PAT automatically.
4. Remove old/expired PATs in Databricks.

---

## 🔭 Future Improvements

1. Integrate Unity Catalog + table-level ACLs:
   - Unity Catalog is Databricks’ unified governance solution for all data assets, enabling fine-grained access control at the table, view, and column level across workspaces.
   - Centrally manage data permissions using Entra ID (Azure AD) groups.
   - Enforce data access policies at the catalog, schema, table, and view level.
   - Audit data access and changes for compliance.
   - Example (Terraform):
     ```hcl
     resource "databricks_grants" "table_access" {
       table = "catalog.schema.table"
       grant {
         principal  = "data_engineers"
         privileges = ["SELECT"]
       }
       grant {
         principal  = "data_scientists"
         privileges = ["SELECT"]
       }
     }
     ```
   - Benefits: Centralized, scalable data governance; least-privilege access for sensitive data; easier compliance with regulatory requirements.
2. CI/CD Enhancements:
   - Add a manual approval step before terraform apply in production
   - Separate plan and apply jobs for better control
   - Add notifications (Slack, Teams) for pipeline status
3. Security & Compliance Enhancements:
   - Add private networking and secure workspace access (private endpoints, firewall rules for Databricks and storage). If cost is an issue for private endpoints, use service endpoints with whitelisting
   - Integrate with Entra ID for federated identity and RBAC (use Entra ID groups for access, federated credentials for automation)
   - Add automated infrastructure security scanning and compliance checks (For ex: SonarQube, Checkov, tfsec)

---

## 🗒️ Assumptions & Challenges

- One shared cluster for multiple teams — scale out with job clusters as needed.
- Unity Catalog not yet included — add it for table-level governance later.
- Each user must exist in Azure Active Directory before being assigned to a group.
- Chaining outputs between modules for workspace URL and cluster IDs.
- Managing provider auth for Databricks API via PAT securely.
- Secrets management for CI/CD to avoid accidental leaks.

---
