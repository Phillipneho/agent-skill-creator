# SC-060: Validation Checks Frontmatter Structure Completeness

> Covers: FR-012 — Validation MUST check frontmatter structure
> Type: Failure

## Given
- A skill directory `bad-frontmatter/` with SKILL.md that has malformed YAML:
  ```
  ---
  name: bad-frontmatter
  description "missing colon after description"
  ---
  ```

## When
- The validation function `validate_skill("bad-frontmatter/")` is invoked

## Then
- The validation result `valid` is `False`
- The `errors` list contains a message about invalid YAML frontmatter structure
- The error is specific enough to help the user fix it

## Verification Method

**Method**: Automated test

**Steps**:
1. Create `bad-frontmatter/` with malformed YAML in SKILL.md
2. Call `validate_skill("bad-frontmatter/")`
3. Assert `result.valid is False`
4. Assert `result.errors` contains a message about YAML parsing failure

**Expected evidence**: `valid: False`. Error message like `"Invalid YAML frontmatter: could not parse frontmatter block"`.
