param (
    [Parameter(Mandatory = $true)]
    [string]$PolicyName,

    [Parameter(Mandatory = $true)]
    [string]$DisplayName,

    [Parameter(Mandatory = $true)]
    [string]$PolicyDescription,

    [Parameter(Mandatory = $true)]
    [string]$Version,

    [Parameter(Mandatory = $false)]
    [string]$Location = "westeurope"  # Required for sub-level deployments
)

# Set deployment name
$timestamp = Get-Date -Format 'yyyyMMddHHmmss'
$deploymentName = "policy-$PolicyName-$timestamp"

# Template and parameters
$templateFile = "./require-tags/require-tags.bicep"
$parametersFile = "./require-tags/require-tags.parameters.json"

Write-Host "Deploying policy '$PolicyName' to subscription scope..."

az deployment sub create `
    --name $deploymentName `
    --location $Location `
    --template-file $templateFile `
    --parameters "@$parametersFile" `
    --query "properties.outputs"

if ($LASTEXITCODE -ne 0) {
    Write-Error "Policy deployment failed."
    exit 1
}

Write-Host "Policy '$PolicyName' deployed successfully."
