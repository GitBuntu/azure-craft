using 'dev.bicep'

param location = 'eastus'
param clientName = 'alfredo'
param slotsConfig = {}
param storageConfig = {
  skuName: 'Standard_LRS'
  accessTier: 'Hot'
}

param tags = {
  Compliance: 'ISO27001'
  CostCenter: 'FIN-Azure-Learning'
  DataSensitivity: 'Low'
  Environment: 'Development'
  Location: 'eastus'
  Owner: 'Azure Learning Team'
  Project: 'Azure-Learning'
}
