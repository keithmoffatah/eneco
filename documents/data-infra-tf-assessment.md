You are tasked with creating a Databricks workspace for a large energy company. The workspace will be used by multiple teams. The teams need to be able to run workloads and share data and models with each other. Implement infrastructure-as-code solution to provision and configure Databricks and related resources. Automate the infrastructure deployment, set up CI/CD and document your work. The assignment should take approximately 3 hours to complete.

## Infrastructure Requirements

- Databricks workspace with appropriate configuration
- Storage account for data lake integration
- Configuration and access control for appropriate resources

## Tasks

1. **Infrastructure Design**: Provision the Databricks infrastructure architecture using Terraform.
2. **Configuration Management**: Configure workspace settings, clusters, and access control.
3. **Data lake design**: Provision and configure a place for the teams to share data and models within their team and with other teams.
4. **Design RBAC**: Define user groups and identify what types of users are intended for each group.
5. **CI/CD**: Set up CI/CD to run tests and deploy the infrastructure code.
6. **Documentation**: Create a README with setup instructions, approach, assumptions, challenges and improvement ideas. Specify if any LLMs were used in the process.

## Deliverables

- All infrastructure provisioning and configuration must be automated through Terraform.
- Git repository containing the code, CI/CD pipeline, README file. Archive and send it over email.
