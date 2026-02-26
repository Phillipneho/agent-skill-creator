# SC-014: Generated Skills Include Metadata with Author and Version

> Covers: FR-009 — Generated skills MUST include `metadata` field with `author` and `version`
> Type: Happy Path

## Given
- The meta-skill is invoked to create a skill
- Input: "Create a skill for database migration management"

## When
- Phase 5 generates the SKILL.md

## Then
- The SKILL.md frontmatter includes a `metadata` mapping
- The `metadata` contains an `author` field with a non-empty string
- The `metadata` contains a `version` field (e.g., `1.0.0`)

## Verification Method

**Method**: Automated test

**Steps**:
1. Run the meta-skill to generate the skill
2. Parse the YAML frontmatter of the generated SKILL.md
3. Assert `metadata` key is present and is a dict
4. Assert `metadata.author` is a non-empty string
5. Assert `metadata.version` is a non-empty string matching semver pattern `^\d+\.\d+\.\d+`

**Expected evidence**: Frontmatter contains:
```yaml
metadata:
  author: "Some Author"
  version: "1.0.0"
```
