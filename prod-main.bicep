param location string = resourceGroup().location
param tags object
param clientName string

@description('Optional storage configuration')
param storageConfig object

@description('Optional function configuration')
param slotsConfig object

var storageAccountName = toLower('${clientName}${uniqueString(resourceGroup().id)}')

// Conditionally deploy the storage account module
module storageAccount './modules/storage-account/storage.bicep' = if (!empty(storageConfig)) {
  name: 'storageAccount-${uniqueString(resourceGroup().id)}'
  params: {
    location: location
    skuName: storageConfig.skuName
    accessTier: storageConfig.accessTier
    tags: tags
    storageAccountName: storageAccountName
  }
}

// Declare outputs once, and use conditional access
output storageAccountName string = empty(storageConfig) ? '' : storageAccount!.outputs.storageAccountName
output storageAccountResourceGroup string = empty(storageConfig)
  ? ''
  : storageAccount!.outputs.storageAccountResourceGroup
output storageAccountId string = empty(storageConfig) ? '' : storageAccount!.outputs.storageAccountId
output primaryLocation string = empty(storageConfig) ? '' : storageAccount!.outputs.primaryLocation

// other modules here
module functionApp './modules/slots/slot.bicep' = if (!empty(slotsConfig)) {
  name: 'functionApp-${uniqueString(resourceGroup().id)}'
  params: {
    location: location
  }
}
