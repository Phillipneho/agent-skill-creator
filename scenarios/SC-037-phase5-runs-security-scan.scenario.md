# SC-037: Phase 5 Runs Security Scan After Generating All Files

> Covers: FR-025 — Phase 5 SHOULD run security scan after generating all files
> Type: Happy Path

## Given
- The meta-skill has completed Phases 1-4
- Phase 5 has generated all files and passed validation

## When
- Phase 5 reaches the security scan step (step i in the pipeline)

## Then
- The security scan function is invoked automatically on the generated skill directory
- The security scan result is reported to the user
- Any security findings are listed with file locations and descriptions

## Verification Method

**Method**: Manual test

**Steps**:
1. Run the meta-skill to completion
2. Observe Phase 5 output for security scan step
3. Verify a security report is shown

**Expected evidence**: Phase 5 output includes a security scan report section, such as:
```
Security Scan: PASSED
  - No hardcoded secrets found
  - No .env files detected
  - No shell injection patterns found
```
