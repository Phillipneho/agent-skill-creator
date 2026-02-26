# SC-044: Consecutive Hyphens in Name Are Collapsed

> Covers: FR-001, Edge case 2.3 — Name has consecutive hyphens: collapse to single hyphen, warn user
> Type: Edge Case

## Given
- The name normalization process produces `my---awesome--skill` (consecutive hyphens)

## When
- The validation/normalization step processes the name

## Then
- Consecutive hyphens are collapsed to a single hyphen: `my-awesome-skill`
- The user is warned about the automatic collapse
- The final `name` field is `my-awesome-skill`

## Verification Method

**Method**: Automated test

**Steps**:
1. Construct a scenario where name normalization produces `my---awesome--skill`
2. Verify the final `name` in frontmatter is `my-awesome-skill`
3. Assert `--` does not appear in the name

**Expected evidence**: `name: my-awesome-skill`. No consecutive hyphens. Warning message like "Collapsed consecutive hyphens in name".
