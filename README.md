# 🚀 Databricks Workspace IaC for Multi-Team Collaboration

This repository provisions a secure, modular Databricks environment for a large energy company.
Teams can run workloads, share data and models, and follow RBAC best practices — all automated with **Terraform** and **GitHub Actions**.

---

## 📌 Infrastructure Overview

**What’s included:**

✅ **Databricks Workspace** — Premium SKU workspace for multiple teams
✅ **Storage Account** — Azure Data Lake Storage Gen2 for shared data/models
✅ **RBAC** — Databricks user groups, memberships, and cluster permissions
✅ **CI/CD** — Automated deploys with `terraform plan` and `apply` on `main` branch

---

## 🗂️ Modules

| Module                  | Description                                                   |
|-------------------------|---------------------------------------------------------------|
| `databricks_workspace/` | Creates Azure resource group, Databricks workspace, shared cluster |
| `storage_account/`      | Provisions ADLS Gen2 for team data & model sharing            |
| `rbac/`                 | Defines Databricks groups, adds users, and sets cluster permissions |

---

## ⚙️ How to Use

### 1️⃣ Pre-requisites

- Terraform >= 1.5.0
- Azure subscription (`az login` configured)
- GitHub repository with encrypted secrets:
  - `ARM_CLIENT_ID`
  - `ARM_CLIENT_SECRET`
  - `ARM_SUBSCRIPTION_ID`
  - `ARM_TENANT_ID`

**Note:**
- If you want to add an external user (e.g., a Gmail address) to Databricks, you must first invite them as a guest user in your Azure Active Directory tenant. Go to Azure Portal → Azure Active Directory → Users → New guest user, enter their email, and send the invitation. The user must accept the invitation before they can sign in to Databricks.
- Databricks Personal Access Token (PAT) and Azure Key Vault are not required for authentication; OIDC (federated credentials) is used for secure automation.

---

### 2️⃣ Run Locally

```bash
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

### 🗒️ Assumptions

One shared cluster for multiple teams — scale out with job clusters as needed.
Unity Catalog not yet included — add it for table-level governance later.
Each user must exist in Azure Active Directory before being assigned to a group.
🚧 Challenges

Chaining outputs between modules for workspace URL and cluster IDs.
Managing provider auth for Databricks API via OIDC securely.
Secrets management for CI/CD to avoid accidental leaks.

### 🔭 Future Improvements

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
