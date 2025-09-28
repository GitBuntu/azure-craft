# AC-12: Azure Key Vault Bicep Module Documentation

## Overview
This document provides guidance for engineers on deploying and managing Azure Key Vault using the reusable Bicep module in the `azure-craft` repository. It is intended for inclusion in the DevOps Wiki to ensure consistent, secure, and compliant Key Vault deployments across all environments.

---

## Module Location
- **Path:** `modules/key-vault/key-vault.bicep`

## Purpose
- Provision a secure, policy-compliant Azure Key Vault.
- Parameterize all critical settings for flexibility and reusability.
- Enforce tagging and access policy standards.

---

## Parameters

**keyVaultName** (`string`, *required*)
> Name of the Key Vault.

**location** (`string`, default: resource group location)
> Azure region for deployment.

**enabledForDeployment** (`bool`, default: `false`)
> Allow VMs to retrieve certificates as secrets.

**enabledForDiskEncryption** (`bool`, default: `false`)
> Allow Disk Encryption to retrieve secrets/unwrap keys.

**enabledForTemplateDeployment** (`bool`, default: `false`)
> Allow ARM to retrieve secrets.

**tenantId** (`string`, default: subscription tenant)
> Azure AD tenant ID for authentication.

**objectId** (`string`, *required*)
> Object ID for access policy (user, SPN, or group).

**keysPermissions** (`array`, default: `[ 'list' ]`)
> Permissions to keys.

**secretsPermissions** (`array`, default: `[ 'get', 'set', 'list' ]`)
> Permissions to secrets.

**skuName** (`string`, default: `standard`)
> SKU: `standard` or `premium`.

**tags** (`object`, default: `{}`)
> Resource tags (must comply with policy).

---

## Outputs

- **location**: Key Vault location
- **name**: Key Vault name
- **resourceGroupName**: Resource group name
- **resourceId**: Key Vault resource ID

---

## Usage Example

```
module keyVault 'modules/key-vault/key-vault.bicep' = {
  name: 'keyVault'
  params: {
    keyVaultName: 'my-app-kv'
    location: 'eastus'
    objectId: '<object-id>'
    tags: {
      environment: 'dev'
      owner: 'team@example.com'
    }
  }
}
```

---

## Best Practices
- **Parameterize** all values in environment files (`.bicepparam` or `.parameters.json`).
- **Never hardcode secrets**; use Key Vault references for all sensitive data.
- **Comply with tagging policy** by providing required tags.
- **Review access policies** to grant least-privilege permissions.
- **Enable soft delete** (default: 90 days) for recovery and compliance.
- **Update environment files** to reference the module and set parameters.

---

## Security & Compliance
- Access policies must use valid Azure AD object IDs.
- All resources must be tagged per policy (`/policy/require-tags/`).
- Soft delete is enabled by default for data protection.
- Network ACLs default to allow Azure services; review if stricter controls are needed.

---

## Troubleshooting
- **Deployment Fails:** Check required parameters (`keyVaultName`, `objectId`) and tag compliance.
- **Access Issues:** Ensure correct `objectId` and permissions are set.
- **Policy Violations:** Review tags and access policies for compliance.

---

## References
- [Key Vault Bicep Reference](https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults)
- [azure-craft Copilot Instructions](../.github/copilot-instructions.md)
- [Tag Policy Module](../../policy/require-tags/require-tags.bicep)

---

*For questions or improvements, update this documentation and notify the DevOps team.*
