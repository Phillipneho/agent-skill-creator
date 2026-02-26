# SC-003: Validation Fails When Frontmatter Missing Description

> Covers: FR-001, FR-011, FR-012 — Generated SKILL.md MUST have valid frontmatter; Validation MUST check description length
> Type: Failure

## Given
- A skill directory `test-skill/` exists with a SKILL.md that has frontmatter missing the `description` field:
  ```yaml
  ---
  name: test-skill
  ---
  ```

## When
- The validation function `validate_skill("test-skill/")` is invoked

## Then
- The validation result `valid` is `False`
- The `errors` list contains a message indicating the `description` field is missing

## Verification Method

**Method**: Automated test

**Steps**:
1. Create a temporary directory `test-skill/` with a SKILL.md containing only a `name` field in frontmatter
2. Call `validate_skill("test-skill/")`
3. Assert `result.valid is False`
4. Assert any item in `result.errors` contains the substring `description`

**Expected evidence**: `valid: False`, `errors` list includes an entry like `"Missing required field: description"`.
