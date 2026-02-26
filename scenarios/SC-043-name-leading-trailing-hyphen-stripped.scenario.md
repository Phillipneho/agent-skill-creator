# SC-043: Name Starting/Ending with Hyphen Is Auto-Stripped

> Covers: FR-001, Edge case 2.3 — Name starts/ends with hyphen: auto-strip, warn user
> Type: Edge Case

## Given
- The name normalization process produces `-my-skill-` (leading and trailing hyphens)

## When
- The validation/normalization step processes the name

## Then
- Leading and trailing hyphens are stripped, resulting in `my-skill`
- The user is warned about the automatic stripping
- The final `name` field is `my-skill`

## Verification Method

**Method**: Automated test

**Steps**:
1. Construct a scenario where name normalization would produce `-my-skill-`
2. Verify the final `name` in frontmatter is `my-skill`
3. Verify the name does not start or end with a hyphen

**Expected evidence**: `name: my-skill`. No leading or trailing hyphens. Warning message like "Stripped leading/trailing hyphens from name".
