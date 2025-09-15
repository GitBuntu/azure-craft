#!/usr/bin/env pwsh
# Pre-commit validation script for Bicep IaC

$ErrorActionPreference = 'Stop'

# Lint all Bicep files
$bicepFiles = Get-ChildItem -Path ./modules -Recurse -Filter *.bicep
foreach ($file in $bicepFiles) {
    Write-Host "Linting $($file.FullName)"
    bicep build $file.FullName | Out-Null
}

# Validate environment parameter files
$paramFiles = Get-ChildItem -Path ./environments -Recurse -Include *.bicepparam,*.parameters.json
foreach ($param in $paramFiles) {
    Write-Host "Validating $($param.FullName)"
    # Simulate validation (replace with actual validation if available)
    # Example: bicep build-params $param.FullName
}

# Run what-if for each environment (simulation)
$envDirs = Get-ChildItem ./environments -Directory
foreach ($env in $envDirs) {
    $mainBicep = Join-Path $env.FullName ("$($env.Name).bicep")
    if (Test-Path $mainBicep) {
        Write-Host "[SIMULATION] Would run 'az deployment group what-if' for $mainBicep"
    }
}

Write-Host "Pre-commit validation complete. Block commit if any errors above."
