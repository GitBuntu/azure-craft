targetScope = 'subscription'

@description('The name prefix for all policy definitions')
param policyPrefix string = 'cgk-policy'

param version string = '1.0.0'

module requireTags './require-tags/require-tags.bicep' = {
  name: '${policyPrefix}-require-tags'
  params: {
    policyName: '${policyPrefix}-require-tags'
    displayName: 'Require Multiple Tags on Resource Groups'
    policyDescription: 'Ensures resource groups include tags: Compliance, CostCenter, DataSensitivity, Environment, Location, Owner, and Project.'
    version: version
  }
}
