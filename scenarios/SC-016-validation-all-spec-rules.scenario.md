# SC-016: Validation Checks All Official Spec Rules

> Covers: FR-011, FR-012, NFR-003 — Validation MUST check every generated skill against official spec rules
> Type: Happy Path

## Given
- A fully valid skill directory `valid-skill/` exists with:
  - `name: valid-skill` (matches directory)
  - `description: "A valid test skill for verification"` (<=1024 chars)
  - Valid YAML frontmatter structure
  - SKILL.md body <500 lines

## When
- The validation function `validate_skill("valid-skill/")` is invoked

## Then
- The validation result `valid` is `True`
- The `errors` list is empty
- The `warnings` list may contain non-blocking suggestions
- All spec rules have been checked (name format, description length, frontmatter structure, directory name match)

## Verification Method

**Method**: Automated test

**Steps**:
1. Create a fully compliant skill directory `valid-skill/` with correct frontmatter
2. Call `validate_skill("valid-skill/")`
3. Assert `result.valid is True`
4. Assert `len(result.errors) == 0`
5. Verify the function checks at minimum: name format, description length, frontmatter structure, directory match

**Expected evidence**: `valid: True`, `errors: []`. Function returns a ValidationResult with all four required check categories evaluated.
