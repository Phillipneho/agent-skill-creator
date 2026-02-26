# SC-036: Phase 5 Runs Validation After Generating All Files

> Covers: FR-024 — Phase 5 MUST run validation after generating all files
> Type: Happy Path

## Given
- The meta-skill has completed Phases 1-4
- Phase 5 has generated all files (SKILL.md, scripts, references, install.sh, README.md)

## When
- Phase 5 reaches the validation step (step h in the pipeline)

## Then
- The validation function is invoked automatically on the generated skill directory
- The validation result is reported to the user
- If validation passes, Phase 5 continues to the security scan
- If validation fails, the user is informed of the specific errors

## Verification Method

**Method**: Manual test

**Steps**:
1. Run the meta-skill to completion
2. Observe Phase 5 output for validation step
3. Verify a validation report is shown (pass/fail with details)

**Expected evidence**: Phase 5 output includes a validation report section, such as:
```
Validation: PASSED
  - name format: OK
  - description length: OK
  - directory match: OK
  - line count: OK
```
