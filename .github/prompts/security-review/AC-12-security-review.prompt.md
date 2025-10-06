
# Security Review: AC-12 - Implement Azure Key Vault with Bicep

## Summary Verdict
- [ ] **Approved**
- [ ] **Changes Requested**
- [ ] **Blocked (Security Risk)**


## Metadata
- **Work Item ID**: AC-12
- **Feature**: Implement Azure Key Vault with Bicep
- **Reviewer**: Christopher Govender
- **Review Date**: 2025-09-28
- **Related Plan File**: [`../plan/AC-12-plan/AC-12-plan.prompt.md`](../plan/AC-12-plan/AC-12-plan.prompt.md)

---

## Threat Modeling Summary
- **Assets**: [e.g., "User data, Application secrets"]
- **Threats Identified**: [e.g., "Unauthorized access, Data leakage"]
- **Mitigations in Place**: [e.g., "RBAC, Key Vault"]
- **Residual Risks**: [e.g., "Potential misconfiguration of access policies"]

---

## Identity & Access Control
- [ ] Managed identity used for service access
- [ ] RBAC scoped to least privilege
- [ ] Key Vault access policies defined
- [ ] No hardcoded credentials or secrets

- [ ] Role assignments are automated (Bicep/ARM)
- [ ] No excessive permissions granted

**Notes**:
> [e.g., “Function App uses system-assigned identity to access Blob Storage”]

---

## Secret Management
- [ ] Secrets stored in Key Vault
- [ ] Access policies scoped to specific identities
- [ ] No secrets in config files or environment variables
- [ ] Secret rotation strategy defined

- [ ] No secrets exposed in Bicep outputs

**Notes**:
> [e.g., “SP credentials stored as `sp-client-id` and `sp-secret` in Key Vault”]

---

## Network Security
- [ ] Private endpoints used where applicable
- [ ] NSGs or firewall rules restrict access
- [ ] Public access disabled for storage
- [ ] TLS enforced on all endpoints

- [ ] No public IPs unless justified
- [ ] Firewall/NSG rules are least privilege

**Notes**:
> [e.g., “Blob container `uploads` is private with firewall rules enabled”]

---

## Monitoring & Logging
- [ ] Diagnostic settings enabled
- [ ] Security logs sent to Log Analytics
- [ ] Alerts configured for suspicious activity
- [ ] Audit trail for sensitive operations

- [ ] Diagnostic settings are defined in Bicep

**Notes**:
> [e.g., “Key Vault access events logged and retained for 90 days”]

---

## Compliance Alignment
- [ ] ISO27001 tags applied
- [ ] Data sensitivity classified
- [ ] Retention policies defined
- [ ] GDPR/HIPAA considerations documented

- [ ] Tagging enforced via policy/Bicep

**Notes**:
> [e.g., “DataSensitivity tag set to `Confidential`”]

---

## Bicep Module Security & Quality
- [ ] No hardcoded values in Bicep
- [ ] All sensitive values parameterized
- [ ] Outputs do not leak secrets or sensitive data
- [ ] Module is reusable and composable
- [ ] Parameter validation (allowed values, secure defaults)
- [ ] No deprecated or insecure resource types

**Notes**:
> [e.g., “Storage account name is parameterized and unique per environment”]

---

## Automation & Drift Detection
- [ ] Automated validation/linting in place
- [ ] Drift detection configured (e.g., what-if, policy compliance)
- [ ] Security review checklist completed before PR

**Notes**:
> [e.g., “Bicep linter and what-if run in pre-commit hook”]

---

## Recommendations
- [ ] [e.g., “Add alert for >5 failed secret access attempts”]
- [ ] [e.g., “Use private endpoint for Function App”]
- [ ] [e.g., “Rotate SP secret every 90 days”]
- [ ] [e.g., “Parameterize all resource names in Bicep”]
- [ ] [e.g., “Add allowed values for SKU parameters”]

---

## Risk Scoring

| Category             | Risk Level | Notes |
|----------------------|------------|-------|
| Identity & Access    | Low        | Managed identity used |
| Secret Management    | Medium     | Rotation not automated |
| Network Exposure     | Low        | Private endpoint enabled |
| Monitoring & Logging | Medium     | Alerts not yet configured |

---

## Plan File Alignment
- [ ] Implements all requirements from plan file
- [ ] No scope creep or undocumented changes
- [ ] Linked to correct plan file and DevOps task

---

---

**Reviewer**: Christopher Govender  
**Signature**: _Reviewed on 2025-09-28_

---

> _This file documents the security posture of the feature and serves as a traceable artifact for compliance and architecture reviews._
