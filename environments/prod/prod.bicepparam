using 'prod.bicep'

param location = 'eastus'
param clientName = 'alien'

param slotsConfig = {}
param storageConfig = {}

param kvConfig = {
  objectId: '06fec986-a2d5-4b17-92f1-5197146c9f29' // Managed Identity Object ID
  keysPermissions: [
    'list'
  ]
  secretsPermissions: [
    'get'
    'set'
    'list'
  ]
  skuName: 'standard'
  enabledForDeployment: false
  enabledForDiskEncryption: false
  enabledForTemplateDeployment: false
}

param tags = {
  Compliance: 'ISO27001'
  CostCenter: 'FIN-Azure-Learning'
  DataSensitivity: 'Low'
  Environment: 'Production'
  Location: 'eastus'
  Owner: 'Azure Learning Team'
  Project: 'Azure-Learning'
}
