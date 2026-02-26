# SC-002: Validation Fails When Frontmatter Missing Name

> Covers: FR-001, FR-011, FR-012 — Generated SKILL.md MUST have valid frontmatter; Validation MUST check name format
> Type: Failure

## Given
- A skill directory `test-skill/` exists with a SKILL.md that has frontmatter missing the `name` field:
  ```yaml
  ---
  description: "A test skill"
  ---
  ```

## When
- The validation function `validate_skill("test-skill/")` is invoked

## Then
- The validation result `valid` is `False`
- The `errors` list contains a message indicating the `name` field is missing
- The validation does NOT pass silently

## Verification Method

**Method**: Automated test

**Steps**:
1. Create a temporary directory `test-skill/` with a SKILL.md containing only a `description` field in frontmatter
2. Call `validate_skill("test-skill/")`
3. Assert `result.valid is False`
4. Assert any item in `result.errors` contains the substring `name`

**Expected evidence**: `valid: False`, `errors` list includes an entry like `"Missing required field: name"`.
