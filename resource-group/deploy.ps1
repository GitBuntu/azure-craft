param (
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $true)] #cgk-rg-kv-dev-westus
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$Location,

    [Parameter(Mandatory = $true)]
    [string]$Environment,

    [Parameter(Mandatory = $true)]
    [string]$Owner,

    [string]$Compliance = "ISO27001",
    [string]$CostCenter = "FIN-Azure-Learning",
    [string]$DataSensitivity = "Confidential",
    [string]$Project = "Azure-Learning"
)

# Set subscription context
az account set --subscription $SubscriptionId

# Build tag arguments
$tagArgs = @(
    "Compliance=$Compliance"
    "CostCenter=$CostCenter"
    "DataSensitivity=$DataSensitivity"
    "Environment=$Environment"
    "Location=$Location"
    "Owner=$Owner"
    "Project=$Project"
)

# Create resource group
Write-Host "Creating resource group '$ResourceGroupName' in '$Location'..."
az group create `
    --name $ResourceGroupName `
    --location $Location `
    --tags $tagArgs
