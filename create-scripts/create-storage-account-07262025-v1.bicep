param storageAccountName string
param location string = 'eastus'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
  tags: {
    Compliance: 'ISO27001'
    CostCenter: 'FIN-Azure-Learning'
    DataSensitivity: 'High'
    Environment: 'Production'
    Location: 'East US'
    Owner: '[owner]'
    Project: 'Azure-Learning'
  }
}
