using 'prod.bicep'

param location = 'eastus'
param clientName = 'fabrikam'

param slotsConfig = {}
param storageConfig = {
  skuName: 'Standard_LRS'
  accessTier: 'Hot'
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
