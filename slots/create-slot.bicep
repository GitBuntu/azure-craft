@description('Name of the existing Web App')
param webAppName string = 'staticeffect'

@description('Name of the deployment slot')
param slotName string = 'dev'

@description('Location for resources')
param location string = resourceGroup().location

@description('Required tag for Compliance')
param complianceTag string = 'ISO27001'

@description('Required tag for Cost Center')
param costCenterTag string = 'FIN-Azure-Learning'

@description('Required tag for Data Sensitivity')
param dataSensitivityTag string = 'High'

@description('Required tag for Environment')
param environmentTag string = 'Development'

@description('Required tag for Location')
param locationTag string = 'Canada Central'

@description('Required tag for Owner')
param ownerTag string = '[email]'

@description('Required tag for Project')
param projectTag string = 'Azure-Learning'

// Reference to existing web app
resource webApp 'Microsoft.Web/sites@2022-03-01' existing = {
  name: webAppName
}

// Create deployment slot
resource slot 'Microsoft.Web/sites/slots@2022-03-01' = {
  parent: webApp
  name: slotName
  location: location
  tags: {
    Compliance: complianceTag
    CostCenter: costCenterTag
    DataSensitivity: dataSensitivityTag
    Environment: environmentTag
    Location: locationTag
    Owner: ownerTag
    Project: projectTag
  }
  properties: {
    serverFarmId: webApp.properties.serverFarmId
    siteConfig: {
      // Specify only allowed properties for slot configuration, e.g.:
      alwaysOn: true
      http20Enabled: true
      // Add other permitted properties as needed
    }
  }
}
