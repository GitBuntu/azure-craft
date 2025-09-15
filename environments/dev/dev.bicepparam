using 'dev.bicep'

param location = 'eastus'
param clientName = 'alfredo'

param slotsConfig = {}

param storageConfig = {}

param kvConfig = {
  objectId: ''
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
  Environment: 'Development'
  Location: 'westus'
  Owner: 'Azure Learning Team'
  Project: 'Azure-Learning'
}
