param location string
param tags object
param clientName string
param storageConfig object
param slotsConfig object
param kvConfig object

module main '../../prod-main.bicep' = {
  params: {
    location: location
    tags: tags
    clientName: clientName
    storageConfig: storageConfig
    slotsConfig: slotsConfig
    kvConfig: kvConfig
  }
}

output storageAccountName string = main.outputs.storageAccountName
output storageAccountResourceGroup string = main.outputs.storageAccountResourceGroup
output storageAccountId string = main.outputs.storageAccountId
output primaryLocation string = main.outputs.primaryLocation

output kvName string = main.outputs.keyVaultName
output kvResourceGroup string = main.outputs.keyVaultResourceGroup
output kvId string = main.outputs.keyVaultId
