param location string
param tags object
param clientName string
param storageConfig object
param slotsConfig object

module main '../../dev-main.bicep' = {
  params: {
    location: location
    tags: tags
    clientName: clientName
    storageConfig: storageConfig
    slotsConfig: slotsConfig
  }
}

output storageAccountName string = main.outputs.storageAccountName
output storageAccountResourceGroup string = main.outputs.storageAccountResourceGroup
output storageAccountId string = main.outputs.storageAccountId
output primaryLocation string = main.outputs.primaryLocation
