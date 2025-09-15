param (
    [Parameter(Mandatory = $true)]
    [string]$Name,                # e.g. cgk-infra-prod-sp

    [Parameter(Mandatory = $true)]
    [string]$Role,                # e.g. Contributor, Reader, Owner

    [Parameter(Mandatory = $true)]
    [string]$Scope,               # e.g. /subscriptions/000/resourceGroups/rg-storage-dev-westus-001


    [int]$CredentialExpiryDays = 180
)

Write-Host "Creating service principal: $Name" -ForegroundColor Cyan

# Convert expiry days to years for az CLI
$years = [math]::Round($CredentialExpiryDays / 365, 0)
if ($years -lt 1) { $years = 1 } # Azure CLI minimum is 1 year

# Create the service principal with role assignment
$sp = az ad sp create-for-rbac `
    --name $Name `
    --role $Role `
    --scopes $Scope `
    --years $years `
    --query "{appId: appId, password: password, tenant: tenant}" `
    --only-show-errors | ConvertFrom-Json

if (-not $sp) {
    Write-Error "Failed to create service principal."
    exit 1
}

Write-Host "`nService Principal created successfully!" -ForegroundColor Green
Write-Host "----------------------------------------"
Write-Host "Name:        $Name"
Write-Host "App ID:      $($sp.appId)"
Write-Host "Tenant ID:   $($sp.tenant)"
Write-Host "Password:    $($sp.password)" -ForegroundColor Yellow
Write-Host "----------------------------------------"
Write-Host "Store the password securely (e.g., Azure Key Vault). It will not be retrievable"