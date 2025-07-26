param location string = 'eastus'
param functionAppName string = 'GlobalHttpResponder'
param storageAccountName string = 'ckgstorageprodeastus'
param planName string = 'ASP-cgkrgfuncprodeastus-8738'

var commonTags = {
  Compliance: 'ISO27001'
  CostCenter: 'FIN-Azure-Learning'
  DataSensitivity: 'Confidential'
  Environment: 'Production'
  Location: 'EastUS'
  Owner: '[owner]'
  Project: 'Azure-Learning'
}

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: storageAccountName
}

resource hostingPlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: planName
  location: location
  sku: {
    name: 'Y1' // Flex Consumption
    tier: 'Dynamic'
  }
  kind: 'functionapp'
  properties: {
    reserved: true // Linux
    targetWorkerCount: 1
    targetWorkerSizeId: 1 // 2048 MB (1 = 2GB for Linux Consumption)
  }
  tags: commonTags
}

resource functionApp 'Microsoft.Web/sites@2022-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp,linux'
  properties: {
    serverFarmId: hostingPlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNET-ISOLATED|8.0'
      use32BitWorkerProcess: false
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: storage.properties.primaryEndpoints.blob
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet-isolated'
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
      ]
    }
    httpsOnly: true
    clientAffinityEnabled: false
    enabled: true
    hostNamesDisabled: false // Secure unique default hostname (preview) enabled
  }
  identity: {
    type: 'SystemAssigned'
  }
  tags: commonTags
}
