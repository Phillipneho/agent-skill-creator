# SC-042: Uppercase Name Auto-Converts to Lowercase Kebab-Case

> Covers: FR-001, Edge case 2.3 — Name contains uppercase or special chars: auto-convert to lowercase kebab-case
> Type: Edge Case

## Given
- The meta-skill is processing a skill where the derived name would be "MyAwesome_DataProcessor"

## When
- The name normalization step runs

## Then
- The name is auto-converted to `my-awesome-data-processor` (lowercase kebab-case)
- Underscores are replaced with hyphens
- Uppercase letters are lowered
- The user is informed of the conversion

## Verification Method

**Method**: Automated test

**Steps**:
1. Generate a skill where the initial name would contain uppercase/special chars
2. Parse the final SKILL.md frontmatter `name` field
3. Assert `name` matches regex `^[a-z][a-z0-9-]*[a-z0-9]$`
4. Assert no uppercase letters, underscores, or special chars remain

**Expected evidence**: `name: my-awesome-data-processor`. All lowercase. Hyphens as separators. No underscores or special characters.
