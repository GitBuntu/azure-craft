param (
    [Parameter(Mandatory = $true)]
    [string]$Environment,

    [Parameter(Mandatory = $true)]
    [string]$Resource,

    [Parameter(Mandatory = $true)]
    [string]$Location,

    [Parameter(Mandatory = $true)]
    [string]$ClientName
)


$timestamp = Get-Date -Format 'yyyyMMddHHmmss'
$deploymentName = "$Resource-$timestamp"
$resourceGroup = "rg-vm-prod-canadacentral-001"
$templateFile = "$PSScriptRoot/../../environments/$Environment/$Environment.bicep"
$parametersFile = "$PSScriptRoot/../../environments/$Environment/$Environment.parameters.json"

if (!(Test-Path $templateFile)) {
    Write-Error "Template file not found: $templateFile"
    exit 1
}

Write-Host "Running what-if for $Resource in $Environment..."
az deployment group what-if `
    --name $deploymentName `
    --resource-group $resourceGroup `
    --template-file $templateFile `
    --parameters "@$parametersFile" clientName=$ClientName

if ($LASTEXITCODE -ne 0) {
    Write-Error "What-if failed. Aborting deployment."
    exit 1
}

Write-Host "Validating deployment..."
az deployment group validate `
    --name $deploymentName `
    --resource-group $resourceGroup `
    --template-file $templateFile `
    --parameters "@$parametersFile" clientName=$ClientName

if ($LASTEXITCODE -ne 0) {
    Write-Error "Validation failed. Aborting deployment."
    exit 1
}   

Write-Host "Creating deployment..."
az deployment group create `
    --name $deploymentName `
    --resource-group $resourceGroup `
    --template-file $templateFile `
    --parameters "@$parametersFile" clientName=$ClientName `
    --query "properties.outputs"
    

if ($LASTEXITCODE -ne 0) {
    Write-Error "Deployment failed."
    exit 1
}

Write-Host "Deployment complete: $deploymentName"
