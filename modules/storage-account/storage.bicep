@description('The location where the storage account will be deployed')
param location string

@description('The name of the storage account')
@minLength(3)
@maxLength(24)
param storageAccountName string

@description('The SKU name for the storage account')
param skuName string = 'Standard_LRS'

@description('The access tier for the storage account')
param accessTier string

@description('Resource tags')
param tags object

// Storage Account resource definition
resource sa 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: accessTier
    allowSharedKeyAccess: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
    encryption: {
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
        table: {
          enabled: true
        }
        queue: {
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
  tags: tags
}

output storageAccountName string = sa.name
output storageAccountResourceGroup string = resourceGroup().name
output storageAccountId string = sa.id
output primaryLocation string = sa.location
