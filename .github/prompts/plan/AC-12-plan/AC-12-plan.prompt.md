# Project Plan for AC-12
# Plan: AC-12 - Implement Azure Key Vault with Bicep

## Azure DevOps Task
- **ID**: AC-12
- **Summary**: Deploy a secure Azure Key Vault using Bicep, following best practices and project standards.
- **Assignee**: Christopher Govender
- **Status**: To Do
- **Due Date**: [YYYY-MM-DD]

---

## Requirements
- [x] Deploy a secure Azure Key Vault using Bicep
- [x] Ensure secrets, keys, and certificates can be managed securely
- [x] Integrate with managed identities for access control
- [x] Enforce RBAC and access policies as per project standards
- [x] Enable diagnostic logging and monitoring

---

## Acceptance Criteria
- [x] Key Vault is deployed and accessible in the target environment
- [x] RBAC or access policies are enforced (not both at once)
- [x] Soft-delete and purge protection are enabled
- [x] Diagnostic logging is enabled and sent to Log Analytics or Storage
- [x] Public network access is restricted (private endpoints preferred)
- [x] ISO27001 and DataSensitivity tags are applied

---

## Technical Notes
- **Bicep Modules**: `key-vault.bicep` (or AVM Key Vault module)
- **Parameter Files**: `dev.bicepparam`, `prod.bicepparam`
- **Parameter JSON Files**: `dev.parameters.json`, `prod.parameters.json`
- **Infra Dependencies**:
  - Azure Active Directory for identity
  - Managed identities for access
  - Diagnostic settings to Log Analytics/Storage
  - Network rules (private endpoints, firewall)

---

## Security & Compliance
- [x] No hardcoded secrets or credentials
- [x] Use Key Vault for sensitive values
- [x] Enforce RBAC least privilege or access policies
- [x] Comply with tagging policy (ISO27001, DataSensitivity)
- [x] Enable soft-delete and purge protection

---

## Monitoring & Logging
- [x] Set up diagnostic logging for Key Vault
- [x] Integrate with Log Analytics or Storage for audit

---

## Integration Points
- **APIs**: N/A (Key Vault management via Azure Portal/CLI)
- **Services**: Azure Active Directory, Log Analytics, Managed Identities
- **Modules**: `key-vault.bicep` or AVM Key Vault module

---

## Test Strategy
- [x] Validate Key Vault deployment with `bicep build` and `az deployment group what-if`
- [x] Test access with managed identity
- [x] Verify diagnostic logs are being sent
- [x] Confirm RBAC/access policies are enforced

---

## Engineering Notes
- **Estimated Effort**: 1 day
- **Dependencies**: Awaiting confirmation of required access policies and integration points
- **Risks**: Misconfiguration of access policies, missing diagnostic settings
- **Mitigations**: Use AVM module defaults, review with security team

---

## Attachments
- [Link to AC-12 Research](../../research/AC-12-research/AC-12-research.prompt.md)

---

## Status Updates
- **2025-09-28**: Initial plan created by Christopher Govender

---

## Ready for Dev?
- [ ] Yes
- [x] No (awaiting answers to open questions in research)

---

> _This Plan file is the single source of truth for this feature. All updates should be reflected here before code is committed._
