# SC-017: Validation Fails on Invalid Name Format

> Covers: FR-012 — Validation MUST check name format (lowercase+hyphens only)
> Type: Failure

## Given
- A skill directory `My_Skill/` exists with SKILL.md containing:
  ```yaml
  ---
  name: My_Skill
  description: "A skill with invalid name format"
  ---
  ```

## When
- The validation function `validate_skill("My_Skill/")` is invoked

## Then
- The validation result `valid` is `False`
- The `errors` list contains a message about invalid name format (uppercase letters and underscores not allowed)

## Verification Method

**Method**: Automated test

**Steps**:
1. Create directory `My_Skill/` with SKILL.md containing `name: My_Skill`
2. Call `validate_skill("My_Skill/")`
3. Assert `result.valid is False`
4. Assert `result.errors` contains a message about name format violation

**Expected evidence**: `valid: False`, error message like `"name 'My_Skill' contains invalid characters. Must be lowercase alphanumeric and hyphens only."`.
