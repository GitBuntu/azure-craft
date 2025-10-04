param location string = resourceGroup().location
param tags object
param clientName string

@description('Optional storage configuration')
param storageConfig object

@description('Optional function configuration')
param slotsConfig object

param kvConfig object

var storageAccountName = toLower('${clientName}${uniqueString(resourceGroup().id)}')
var keyVaultName = toLower('${clientName}-kv-${uniqueString(resourceGroup().id)}')

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
module functionApp './modules/slot/slot.bicep' = if (!empty(slotsConfig)) {
  name: 'functionApp-${uniqueString(resourceGroup().id)}'
  params: {
    location: location
  }
}

module kv 'modules/key-vault/key-vault.bicep' = if (!empty(kvConfig)) {
  name: 'keyVault-${uniqueString(resourceGroup().id)}'
  params: {
    keyVaultName: keyVaultName
    location: location
    objectId: kvConfig.objectId
    keysPermissions: kvConfig.keysPermissions
    secretsPermissions: kvConfig.secretsPermissions
    skuName: kvConfig.skuName
    enabledForDeployment: kvConfig.enabledForDeployment
    enabledForDiskEncryption: kvConfig.enabledForDiskEncryption
    enabledForTemplateDeployment: kvConfig.enabledForTemplateDeployment
    tags: tags
  }
}

output keyVaultName string = empty(kvConfig) ? '' : kv!.outputs.name
output keyVaultResourceGroup string = empty(kvConfig) ? '' : kv!.outputs.resourceGroupName
output keyVaultId string = empty(kvConfig) ? '' : kv!.outputs.resourceId
