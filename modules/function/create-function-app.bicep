@description('The name of the function app that you wish to create')
@minLength(2)
@maxLength(60)
param functionAppName string

@description('The location for all resources')
param location string = resourceGroup().location

@description('The SKU for the hosting plan')
@allowed([
  'Y1' // Consumption
  'B1' // Basic
  'S1' // Standard
  'P1V2' // Premium V2
  'EP1' // Premium V3
])
param planSku string = 'Y1'

@description('The runtime stack for the function app')
@allowed([
  'dotnet-isolated|8.0'
  'dotnet-isolated|7.0'
  'node|18'
  'node|16'
  'python|3.11'
  'python|3.10'
  'java|17'
  'java|11'
])
param runtimeStack string = 'dotnet-isolated|8.0'

@description('The environment this function app is for')
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

var storageAccountName = 'st${uniqueString(resourceGroup().id, functionAppName)}'
var hostingPlanName = 'plan-${functionAppName}'
var appInsightsName = '${functionAppName}-insights'
var logAnalyticsName = take('log-${functionAppName}', 63)
var functionRuntime = split(runtimeStack, '|')[0]

// Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow' // Allow by default for function apps
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

// Log Analytics Workspace
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
  tags: tags
}

// Application Insights
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalytics.id
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
  tags: tags
}

// Hosting Plan (App Service Plan)
resource hostingPlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: hostingPlanName
  location: location
  sku: {
    name: planSku
    tier: planSku == 'Y1' ? 'Dynamic' : 'Standard'
  }
  kind: 'functionapp'
  properties: {
    reserved: true // Linux
    targetWorkerCount: 1
    targetWorkerSizeId: 1
  }
  tags: tags
}

// Function App
resource functionApp 'Microsoft.Web/sites@2023-01-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp,linux'
  properties: {
    serverFarmId: hostingPlan.id
    httpsOnly: true
    clientAffinityEnabled: false
    siteConfig: {
      linuxFxVersion: runtimeStack
      use32BitWorkerProcess: false
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${az.environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};EndpointSuffix=${az.environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(functionAppName)
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: functionRuntime
        }
        {
          name: 'WEBSITE_RUN_FROM_PACKAGE'
          value: '1'
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
        {
          name: 'WEBSITE_USE_PLACEHOLDER_DOTNETISOLATED'
          value: '1'
        }
      ]
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
  tags: tags
}

// Diagnostic settings for the function app
resource functionAppDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${functionAppName}-diagnostics'
  scope: functionApp
  properties: {
    workspaceId: logAnalytics.id
    logs: [
      {
        category: 'FunctionAppLogs'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

@description('The principal ID of the function app\'s managed identity')
output functionAppPrincipalId string = functionApp.identity.principalId

@description('The URL of the function app')
output functionAppUrl string = 'https://${functionApp.properties.defaultHostName}'

@description('The name of the function app')
output functionAppName string = functionApp.name

@description('The instrumentation key for Application Insights')
output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey

@description('The connection string for Application Insights')
output appInsightsConnectionString string = appInsights.properties.ConnectionString

@description('The resource group where the function app was deployed')
output resourceGroupName string = resourceGroup().name
