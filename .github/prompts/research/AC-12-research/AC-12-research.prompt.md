---
mode: 'research'
description: 'Research best practise for implementing Key Vault with Bicep.'
tools: ['codebase', 'changes', 'fetch', 'searchResults', 'edit', 'search', 'runCommands', 'bicepschema']
---

# Research Key Vault Implementation with Bicep

# Research Notes for Azure Key Vault Bicep Module

## Research Summary
- **Resource/Feature**: Azure Key Vault (Bicep Module)
- **Engineer**: Christopher Govender
- **Date**: 2025-09-28

---

## Requirements & Use Cases
- [x] Deploy a secure Azure Key Vault using Bicep
- [x] Ensure secrets, keys, and certificates can be managed securely
- [x] Integrate with managed identities for access control
- [x] Enforce RBAC and access policies as per project standards
- [x] Enable diagnostic logging and monitoring

---

## Best Practices & References
- [x] [Azure Docs: Key Vault Security](https://learn.microsoft.com/en-us/azure/key-vault/general/security-features)
- [x] [Bicep Module Reference: Microsoft.KeyVault/vaults](https://learn.microsoft.com/en-us/azure/templates/microsoft.keyvault/vaults)
- [x] [Azure Verified Module: Key Vault](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/keyvault/vault)

---

## Dependencies & Integration Points
- [x] Azure Active Directory for identity and access management
- [x] Managed identities for applications/functions accessing Key Vault
- [x] Diagnostic settings to Log Analytics or Storage Account
- [x] Network rules (private endpoints, firewall) if required

---

## Compliance & Security Considerations
- [x] Enforce soft-delete and purge protection
- [x] Enable RBAC or access policies (not both at once)
- [x] Restrict public network access (prefer private endpoints)
- [x] Apply ISO27001 and DataSensitivity tags
- [x] Enable logging for audit and compliance

---

## Open Questions & Risks
- [ ] What applications/services will require access to Key Vault?
- [ ] Are private endpoints required for all environments?
- [ ] What is the expected volume of secrets/keys/certificates?
- [ ] Should access be managed via RBAC or explicit access policies?
- [ ] Are there any region-specific compliance requirements?

---

## Research Log
- **2025-09-28**: Initial research by Christopher Govender, best practices and module references collected.

---

> _This Research file is the single source of truth for discovery and requirements. All updates should be reflected here before planning begins._