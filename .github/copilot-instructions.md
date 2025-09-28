# Copilot Instructions for `azure-craft`

Welcome, AI coding agents! This guide summarizes the essential knowledge and conventions for being productive in the `azure-craft` codebase. Follow these project-specific instructions to maximize your effectiveness.

---

## 1. Architecture Overview

- **Modular Bicep IaC**: Infrastructure is defined using Bicep modules under `/modules/` (e.g., `function/`, `key-vault/`, `sql/`, `storage-account/`). Each module encapsulates a specific Azure resource or pattern.
- **Environment Separation**: Deployments are environment-specific, with `/environments/dev/` and `/environments/prod/` containing main Bicep entrypoints and parameter files. Use these to manage configuration drift and promote changes safely.
- **Policy as Code**: Azure Policy definitions are managed in `/policy/`, with reusable modules (e.g., `require-tags/`) and a dedicated deployment script. Policies enforce tagging and compliance across resources.
- **Pipelines**: CI/CD is orchestrated via Azure Pipelines (`/pipelines/azure-pipelines.yml`), supporting multi-stage deployments and infra validation.

---

## 2. Developer Workflows

- **Infra Deployment**: Use `scripts/infra/deploy.ps1` for deploying Bicep templates. Pass environment and parameter file as arguments.
  - Example: `pwsh ./scripts/infra/deploy.ps1 -Environment dev`
- **Policy Deployment**: Deploy policies with `policy/deploy.ps1`.
- **Resource Group Management**: Use `resource-group/deploy.ps1` for provisioning resource groups before infra deployment.
- **Service Principals**: Scripts in `scripts/security/` automate creation and secure storage of service principals.
- **Audit**: Use `scripts/audit/audit-service-principal.ps1` to review service principal permissions.

---

## 3. Project Conventions

- **Bicep Module Naming**: Modules are named by resource type (e.g., `create-function-app.bicep`, `key-vault.bicep`). Parameters and outputs are explicitly defined for composability.
- **Parameterization**: All environment-specific values are passed via `.bicepparam` or `.parameters.json` files in `/environments/`.
- **No Hardcoded Secrets**: Secrets are referenced from Azure Key Vault, never stored in code or parameters.
- **Tagging**: All resources must comply with tag policies enforced by `/policy/require-tags/`.
- **Pipelines**: Only modify `/pipelines/azure-pipelines.yml` for CI/CD changes; do not duplicate pipeline logic elsewhere.

---

## 4. Integration Points

- **Azure Services**: The codebase provisions and configures Azure Functions, SQL, Storage, and Key Vault.
- **Cross-Module Communication**: Outputs from one module (e.g., storage account connection string) are passed as parameters to dependent modules.
- **External Scripts**: PowerShell scripts in `/scripts/` are the canonical way to interact with Azure resources outside of Bicep.

---

## 5. Key Files & Directories

- `/modules/` — All reusable Bicep modules
- `/environments/` — Environment-specific deployment entrypoints and parameters
- `/policy/` — Policy definitions and deployment scripts
- `/scripts/` — Automation scripts for infra, security, and auditing
- `/pipelines/azure-pipelines.yml` — Main CI/CD pipeline definition
- `README.md` — High-level project overview and getting started instructions

---

## 6. Examples

- **Adding a New Resource**: Create a new Bicep module in `/modules/`, reference it in the appropriate environment main Bicep file, and update parameters as needed.
- **Updating a Policy**: Modify the relevant Bicep in `/policy/require-tags/`, then redeploy using `policy/deploy.ps1`.

---

## 7. AI Agent Guidance

- Always reference existing modules and scripts before introducing new patterns.
- When in doubt, prefer parameterization and modularity.
- Document any new conventions in `README.md` and update this file as needed.

---

## 8. Documentation & Feedback

### AC-12 Documentation Template

For new infrastructure modules, follow the AC-12 Key Vault documentation template for DevOps Wiki and internal docs. This template demonstrates:
- Clear parameter and output documentation using simple lists and bold/monospace formatting for readability.
- Usage examples with Bicep module syntax.
- Best practices, security, compliance, and troubleshooting guidance.
- Reference links to Bicep, policy, and project instructions.

**Template location:** `.github/prompts/documentation/AC-12-documentation/AC-12-documentation.md`

Use this template as a model for documenting future modules to ensure clarity and consistency across the engineering team.

If any section is unclear or missing critical information, please provide feedback so this guide can be improved!
