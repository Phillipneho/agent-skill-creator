# SC-067: Validation Returns Correct ValidationResult Structure

> Covers: FR-011, Section 5.3 — Validation interface returns ValidationResult with valid, errors, warnings, security
> Type: Happy Path

## Given
- The `validate_skill` function is available in `scripts/validate.py`
- A valid skill directory `test-skill/` exists

## When
- `result = validate_skill("test-skill/")` is called

## Then
- The result is a `ValidationResult` object (or dict) with the following fields:
  - `valid`: bool
  - `errors`: list of strings (spec violations)
  - `warnings`: list of strings (recommendations)
  - `security`: list of strings (security issues)
- All four fields are present regardless of pass/fail status

## Verification Method

**Method**: Automated test

**Steps**:
1. Call `validate_skill("test-skill/")`
2. Assert `hasattr(result, 'valid')` and `isinstance(result.valid, bool)`
3. Assert `hasattr(result, 'errors')` and `isinstance(result.errors, list)`
4. Assert `hasattr(result, 'warnings')` and `isinstance(result.warnings, list)`
5. Assert `hasattr(result, 'security')` and `isinstance(result.security, list)`

**Expected evidence**: Result object has all four fields: `valid` (bool), `errors` (list), `warnings` (list), `security` (list).
