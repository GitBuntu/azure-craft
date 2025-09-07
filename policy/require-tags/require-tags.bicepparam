using './require-tags.bicep'

param policyName = 'require-resource-group-tags'
param displayName = 'Require Multiple Tags on Resource Groups'
param policyDescription = 'This policy ensures that all newly created or updated resource groups include a standardized set of governance tags. Specifically, it enforces the presence of the following tags: Compliance, CostCenter, DataSensitivity, Environment, Location, Owner, and Project. This helps maintain consistent tagging for cost management, security classification, accountability, and compliance tracking across the subscription.'
param version = '1.0.0'
