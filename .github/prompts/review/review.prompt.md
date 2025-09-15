
# PR Review Summary for [PR Title or ID]
# 🔍 Pull Request Review: [PR-ID] - [Feature Title]

## Quick Verdict
- [ ] **Approved**
- [ ] **Changes Requested**
- [ ] **Blocked (Security/Infra Issue)**

## 📌 Metadata
- **PR ID**: [PR-ID]
- **Branch**: [feature/xyz]
- **Author**: [GitHub username]
- **Review Date**: [YYYY-MM-DD]
- **Related Jira Task**: [DevOps-ID]
- **Related Plan File**: [`/prompts/plan/vm.prompt.md`](../plan/vm.prompt.md)

---

## Summary of Changes
- **Description**: [Brief summary of what the PR changes]
- **Files Changed**: [e.g., `function-app.bicep`, `upload-handler.cs`]
- **Lines Added**: [e.g., 150]

---

## Security Review
- [ ] Key Vault usage for secrets
- [ ] Managed identity for service access
- [ ] RBAC follows least privilege
- [ ] TLS enforced on all endpoints
- [ ] No hardcoded secrets or credentials

- [ ] No secrets in Bicep outputs
- [ ] Role assignments are automated (Bicep/ARM)

**Notes**:
> [e.g., “Blob access key stored securely in Key Vault”]

---

## Infrastructure Alignment
- [ ] Naming conventions followed
- [ ] Tagging policy applied (Environment, Owner, CostCenter)
- [ ] Diagnostic settings enabled
- [ ] Resource SKU and size appropriate for use case
- [ ] Modules reused from `/modules/` where applicable

- [ ] Tagging enforced via policy/Bicep

**Notes**:
> [e.g., “Storage account uses correct SKU and naming pattern”]

---

## Bicep/IaC Quality
- [ ] Module is reusable and composable
- [ ] All sensitive values parameterized
- [ ] No hardcoded values in Bicep
- [ ] Outputs are minimal and do not leak secrets
- [ ] Parameter validation (allowed values, secure defaults)
- [ ] No deprecated or insecure resource types

**Notes**:
> [e.g., “Storage account name is parameterized and unique per environment”]

---

## Drift Detection & Automation
- [ ] Automated validation/linting in place (pre-commit or CI)
- [ ] Drift detection configured (e.g., what-if, policy compliance)

**Notes**:
> [e.g., “Bicep linter and what-if run in pre-commit hook”]

---

## Plan File Alignment
- [ ] Implements all requirements from plan file
- [ ] No scope creep or undocumented changes
- [ ] Linked to correct plan file and DevOps task

---

## Code Quality
- [ ] Code is clear and maintainable
- [ ] Comments added for complex logic
- [ ] No duplication of logic
- [ ] Error handling implemented
- [ ] Follows project conventions

**Notes**:
> [e.g., “Upload handler has comprehensive error handling”]

---

## Monitoring & Logging
- [ ] Diagnostic settings configured
- [ ] Logs sent to Log Analytics

**Notes**:
> [e.g., “Function App logs to Log Analytics workspace”]

---

## Integration Validation
- [ ] End-to-end functionality verified
- [ ] Correct integration with Blob Storage
- [ ] Function triggers and bindings validated

**Notes**:
> [e.g., “Function App successfully writes to Blob container `uploads`”]

---

## Suggestions & Improvements
- [ ] Consider using module `xyz` for better reusability
- [ ] Add unit tests for edge cases
- [ ] Parameterize all resource names in Bicep
- [ ] Add allowed values for SKU parameters
- [ ] Improve output security (no secrets)

---


**Reviewer**: [Your Name]  
**Signature**: _Reviewed on [YYYY-MM-DD]_

---

> _This review file serves as a traceable artifact for engineering decisions, security validation, and infrastructure alignment. Link it in the PR comments for transparency._
