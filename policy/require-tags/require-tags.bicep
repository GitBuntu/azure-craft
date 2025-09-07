targetScope = 'subscription'

param policyName string
param displayName string
param policyDescription string = 'This policy ensures that all newly created or updated resource groups include a standardized set of governance tags. Specifically, it enforces the presence of the following tags: Compliance, CostCenter, DataSensitivity, Environment, Location, Owner, and Project. This helps maintain consistent tagging for cost management, security classification, accountability, and compliance tracking across the subscription.'
param version string

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2025-03-01' = {
  name: policyName
  properties: {
    displayName: displayName
    description: policyDescription
    policyType: 'Custom'
    mode: 'All'
    metadata: {
      category: 'Tags'
      version: version
    }
    policyRule: {
      if: {
        anyOf: [
          {
            field: 'tags[\'Compliance\']'
            exists: false
          }
          {
            field: 'tags[\'CostCenter\']'
            exists: false
          }
          {
            field: 'tags[\'DataSensitivity\']'
            exists: false
          }
          {
            field: 'tags[\'Environment\']'
            exists: false
          }
          {
            field: 'tags[\'Location\']'
            exists: false
          }
          {
            field: 'tags[\'Owner\']'
            exists: false
          }
          {
            field: 'tags[\'Project\']'
            exists: false
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

output policyId string = policyDefinition.id
output policyName string = policyDefinition.name
