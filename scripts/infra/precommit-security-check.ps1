#!/usr/bin/env pwsh
# Security review pre-commit check script

$securityReviewPrompt = "./prompts/security/security-review.prompt.md"

if (!(Test-Path $securityReviewPrompt)) {
    Write-Error "Security review prompt not found: $securityReviewPrompt"
    exit 1
}

$content = Get-Content $securityReviewPrompt -Raw
if ($content -match '\[ \]') {
    Write-Error "Security review prompt contains incomplete checklist items. Please complete all security checks before commit."
    exit 1
}

Write-Host "Security review prompt is complete."
