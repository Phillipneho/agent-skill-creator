# SC-005: Validation Fails When Name Does Not Match Directory

> Covers: FR-002, FR-012 — Validation MUST check directory name match
> Type: Failure

## Given
- A skill directory named `my-skill/` exists
- The SKILL.md inside has `name: different-skill` in frontmatter

## When
- The validation function `validate_skill("my-skill/")` is invoked

## Then
- The validation result `valid` is `False`
- The `errors` list contains a message about name/directory mismatch

## Verification Method

**Method**: Automated test

**Steps**:
1. Create directory `my-skill/` with SKILL.md containing `name: different-skill`
2. Call `validate_skill("my-skill/")`
3. Assert `result.valid is False`
4. Assert `result.errors` contains a message referencing directory name mismatch

**Expected evidence**: `valid: False`, error message like `"name 'different-skill' does not match directory name 'my-skill'"`.
