targetScope = 'subscription'

@description('The name of the policy definition')
param policyName string = 'require-resource-group-tags'

@description('The display name of the policy')
param displayName string = 'Require Multiple Tags on Resource Groups'

@description('The description of the policy')
param policyDescription string = 'This policy ensures that all newly created or updated resource groups include a standardized set of governance tags. Specifically, it enforces the presence of the following tags: Compliance, CostCenter, DataSensitivity, Environment, Location, Owner, and Project. This helps maintain consistent tagging for cost management, security classification, accountability, and compliance tracking across the subscription.'

resource policyDefinition 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    displayName: displayName
    description: policyDescription
    policyType: 'Custom'
    mode: 'All'
    metadata: {
      category: 'Tags'
      version: '1.0.0'
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
