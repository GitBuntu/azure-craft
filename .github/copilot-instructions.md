# AI Agent Instructions for Azure-Craft

This repository contains Infrastructure as Code (IaC) templates for Azure resources with an emphasis on security, compliance, and best practices. Here's what you need to know to work effectively with this codebase:

## Project Structure & Architecture
- `/functions/` - Azure Function App deployment templates
- `/storage/` - Storage Account deployment templates
- `/policy/` - Azure Policy definitions
- Each Bicep template is self-contained and follows consistent patterns

## Core Patterns & Conventions

### Resource Naming & Tagging
```bicep
var tags = {
  Compliance: 'ISO27001'
  CostCenter: costCenter
  DataSensitivity: dataSensitivity
  Environment: environment
  Location: location
  Owner: defaultOwner
  Project: 'Azure-Learning'
}
```
- All resources require these standardized tags
- Names follow `resource-type-name` pattern (e.g., `plan-functionappname`)
- Use `uniqueString()` for globally unique resources

### Security Standards
- TLS 1.2 minimum enforcement
- HTTPS-only access
- Disabled public blob access
- System-assigned managed identities preferred
- All storage encrypted at rest
- Network rules default to deny (except Function Apps)

### Parameter Validation
- Use `@allowed()` for enumerated values
- Provide descriptive `@description()` for all parameters
- Include min/max lengths for naming constraints
- Default to production-grade settings

### Monitoring Setup
Every deployable resource includes:
- Log Analytics integration
- Application Insights when applicable
- Diagnostic settings with metrics and logs
- Standard retention policies

## Common Operations

### Adding New Resources
1. Follow existing templates as reference implementations
2. Include all standard tags
3. Implement diagnostic settings
4. Define meaningful outputs
5. Add parameter validation

### Policy Management
See `policy/create-az-policy-definition-04082025-v1.bicep` for:
- Tag enforcement examples
- Policy rule structure
- Subscription-level deployment patterns

## Key Integration Points
- Storage accounts are configured for integration with Azure Services
- Function Apps connect to storage via connection strings
- Log Analytics serves as central logging
- Application Insights for application monitoring

## Best Practices Implementation
- See `functions/create-function-app.bicep` for comprehensive example
- See `storage/create-storage-account.bicep` for security baseline
- Reference `README.md` for full best practices checklist

## Resource Dependencies
Functions → Storage Account → Log Analytics
Storage → Log Analytics
Policies → Subscription Level
- Ensure dependencies are declared in Bicep files
