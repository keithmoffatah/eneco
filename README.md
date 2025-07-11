# 🚀 Databricks Workspace IaC for Multi-Team Collaboration

This repository provisions a secure, modular Databricks environment for a large energy company.
Teams can run workloads, share data and models, and follow RBAC best practices — all automated with **Terraform** and **GitHub Actions**.

---

## 📌 Infrastructure Overview

**What’s included:**

- ✅ **Databricks Workspace** — Premium SKU workspace for multiple teams
- ✅ **Storage Account** — Azure Data Lake Storage Gen2 for shared data/models
- ✅ **RBAC** — Databricks user groups, memberships, and cluster permissions
- ✅ **CI/CD** — Automated deploys with Terraform CI/CD workflow

---

## 🗂️ Modules

| Module                  | Description                                                   |
|-------------------------|---------------------------------------------------------------|
| `databricks_workspace/` | Creates Azure resource group, Databricks workspace, shared cluster |
| `storage_account/`      | Provisions ADLS Gen2 for team data & model sharing            |
| `rbac/`                 | Defines Databricks groups, adds users, and sets cluster permissions |

---

## ⚙️ How to Use

**Note:**
- If you want to add an external user (e.g., a Gmail address) to Databricks, you must first be invited as a guest user in the Azure Active Directory tenant. Send me your email and I will go to the Azure Portal → Azure Active Directory → Users → New guest user, enter your email, and send the invitation. You must accept the invitation before you can sign in to Databricks.
- After the invitation is accepted, add your email to the appropriate group (e.g., `admin_users`, `data_engineer_users`, or `data_scientist_users`) in the `terraform.tfvars` file. This ensures they are assigned to the correct Databricks group on the next Terraform apply.

---
### 2️⃣ Add email to tfvars & run Pipeline

Add your email to the appropriate group in terraform.tfvars
Commit changes
Navigate to https://github.com/keithmoffatah/eneco/actions/
Go to the "Terraform Apply (RBAC/SPN)" Step
Look for the workspace_url output and go to https://adb-xxxxxx.xx.azuredatabricks.net


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
   - Separate plan and apply jobs for better control
   - Add notifications (Slack, Teams) for pipeline status
3. Security & Compliance Enhancements:
   - Add private networking and secure workspace access (private endpoints, firewall rules for Databricks and storage). If cost is an issue for private endpoints, use service endpoints with whitelisting
   - Add automated infrastructure security scanning and compliance checks (For ex: SonarQube, Checkov, tfsec)

---
