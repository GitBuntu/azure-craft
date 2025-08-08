@description('The name of the storage account')
@minLength(3)
@maxLength(24)
param storageAccountName string

@description('The location where the storage account will be deployed')
param location string = resourceGroup().location

@description('The SKU name for the storage account')
@allowed([
  'Standard_LRS' // Locally redundant storage
  'Standard_GRS' // Geo-redundant storage
  'Standard_RAGRS' // Read-access geo-redundant storage
  'Standard_ZRS' // Zone-redundant storage
  'Premium_LRS' // Premium locally redundant storage
  'Premium_ZRS' // Premium zone-redundant storage
])
param skuName string = 'Standard_LRS'

@description('The access tier for the storage account')
@allowed([
  'Hot'
  'Cool'
])
param accessTier string = 'Hot'

@description('The environment this storage account is for')
@allowed([
  'Development'
  'Staging'
  'Production'
])
param environment string = 'Production'

@description('The owner of this resource')
param owner string = ''

@description('The cost center for billing')
param costCenter string = 'FIN-Azure-Learning'

@description('The data sensitivity level')
@allowed([
  'Low'
  'Medium'
  'High'
  'Critical'
])
param dataSensitivity string = 'High'

// Variables
var defaultOwner = empty(owner) ? 'default-owner' : owner
var tags = {
  Compliance: 'ISO27001'
  CostCenter: costCenter
  DataSensitivity: dataSensitivity
  Environment: environment
  Location: location
  Owner: defaultOwner
  Project: 'Azure-Learning'
}

// Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: accessTier
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
    encryption: {
      services: {
        blob: { enabled: true }
        file: { enabled: true }
        queue: { enabled: true }
        table: { enabled: true }
      }
      keySource: 'Microsoft.Storage'
    }
  }
  tags: tags
}

// Blob Service configuration
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: true
  }
}

// Default container
resource defaultContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'data'
  properties: {
    publicAccess: 'None'
    metadata: {}
  }
}

@description('The name of the storage account')
output storageAccountName string = storageAccount.name

@description('The ID of the storage account')
output storageAccountId string = storageAccount.id

@description('The primary blob endpoint')
output blobEndpoint string = storageAccount.properties.primaryEndpoints.blob

@description('The primary file endpoint')
output fileEndpoint string = storageAccount.properties.primaryEndpoints.file

@description('Resource group where the storage account was deployed')
output resourceGroupName string = resourceGroup().name
