# SC-007: Validation Fails When SKILL.md Exceeds 500 Lines

> Covers: FR-003, FR-011 — Validation MUST check generated SKILL.md is <500 lines
> Type: Failure

## Given
- A skill directory `verbose-skill/` exists
- The SKILL.md inside contains 650 lines (valid frontmatter but excessive body content)

## When
- The validation function `validate_skill("verbose-skill/")` is invoked

## Then
- The validation result reports a warning or error about SKILL.md exceeding 500 lines
- The `errors` or `warnings` list contains a message about line count

## Verification Method

**Method**: Automated test

**Steps**:
1. Create directory `verbose-skill/` with a SKILL.md that has valid frontmatter and 650 lines of body content
2. Call `validate_skill("verbose-skill/")`
3. Assert that `result.errors` or `result.warnings` contains a message about exceeding 500 lines

**Expected evidence**: Validation output includes a message like `"SKILL.md exceeds 500 lines (650 lines found)"`.
