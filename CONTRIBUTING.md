# Pre-commit Hook Setup for Azure-Craft

To enforce validation and security checks before pushing code to DevOps, add the following to your `.git/hooks/pre-commit` file (or use a tool like Husky for cross-platform support):

```sh
#!/usr/bin/env pwsh

# Run Bicep validation
pwsh ./scripts/infra/precommit-validate.ps1
if ($LASTEXITCODE -ne 0) { exit 1 }

# Run security review check
pwsh ./scripts/infra/precommit-security-check.ps1
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Pre-commit checks passed."
```

Make sure the script is executable:

```sh
chmod +x .git/hooks/pre-commit
```

---

# How to Use the Plan-to-Module Automation

1. After creating or updating a plan prompt in `/prompts/plan/`, run:
   ```sh
   pwsh ./scripts/infra/plan-to-module.ps1
   ```
2. Review the simulated output and make any necessary manual adjustments.
3. Commit the generated/updated modules and environment files.

---

# Parameter Manifest Usage

- Update `environments/parameters.manifest.json` whenever you add or change a module's parameters or outputs.
- Use this manifest as the source of truth for generating/updating all environment parameter files.
- (Optional) Automate parameter file generation with a script that reads this manifest.

---

# Security Review Prompt

- Before committing, ensure `/prompts/security/security-review.prompt.md` is present and all checklist items are complete.
- The pre-commit hook will block commits if this file is missing or incomplete.

---

For more details, see `/scripts/infra/` and `/environments/parameters.manifest.json`.
