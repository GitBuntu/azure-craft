# Azure Deployment Best Practices

This repository contains Azure Infrastructure as Code (IaC) templates following these critical deployment principles:

## 1. Security First
- TLS 1.2 or higher enforcement
- HTTPS-only access where applicable
- Secure network access controls (IP restrictions, VNet integration)
- Managed Identities over connection strings/keys
- Encryption at rest and in transit
- Minimum privilege principle
- Key Vault integration for secrets

## 2. Resource Naming & Organization
- Consistent naming conventions
- Resource grouping strategy
- Region selection strategy
- Resource dependencies management
- Unique name generation for global resources

## 3. Configuration Management
- Environment-specific settings
- Parameterization of all variable values
- Default values for optional parameters
- Parameter validation and constraints
- Configuration inheritance between environments

## 4. Monitoring & Observability
- Diagnostic settings enabled
- Log Analytics integration
- Metrics collection
- Alert rules configuration
- Audit logging

## 5. Compliance & Governance
- Resource tagging strategy
- Cost center attribution
- Environment designation
- Owner assignment
- Data classification
- Compliance standards tracking

## 6. Disaster Recovery
- Backup configuration
- Retention policies
- Soft delete enablement
- Cross-region redundancy options
- Recovery point objectives (RPO)

## 7. Performance & Scalability
- SKU selection strategy
- Auto-scaling rules
- Performance tier configuration
- Resource limits and quotas
- Geographic distribution

## 8. Operational Excellence
- Resource locks
- Health checks
- Deployment validation
- Rollback procedures
- Maintenance windows

## 9. Cost Optimization
- Resource right-sizing
- Auto-shutdown for non-production
- Cost allocation tags
- Budget alerts
- Reserved instances strategy

## 10. Documentation & Outputs
- Resource dependencies documentation
- Configuration values documentation
- Output critical resource identifiers
- Connection details
- Post-deployment instructions

## 11. Deployment Validation
- Pre-deployment checks
- Post-deployment validation
- Health probes
- Resource consistency checks
- Configuration verification

## 12. Lifecycle Management
- Version control strategy
- Update management
- Deprecation handling
- Resource cleanup
- State management

Each deployment script in this repository implements these principles to ensure secure, maintainable, and production-ready infrastructure.

Azure CLI conceptual article list
https://learn.microsoft.com/en-us/cli/azure/reference-docs-index?view=azure-cli-latest

# MCP DevOps Toolset

This repo launches MCP servers for DevOps demos and Azure workflows.

## Usage

1. Open in VS Code
2. Run the task: `Launch MCP Servers`
3. Provide inputs when prompted (e.g. Azure DevOps org name)

## Servers

- Sequential Thinking
- Memory
- Context7
- AzureMCP
- Azure DevOps MCP
