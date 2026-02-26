# SC-004: Generated SKILL.md Name Matches Parent Directory

> Covers: FR-002 — Generated SKILL.md `name` field MUST match the parent directory name
> Type: Happy Path

## Given
- The meta-skill is invoked with: "Create a skill for weather alerts"
- Phase 3 creates a directory named `weather-alerts/`

## When
- Phase 5 generates the SKILL.md inside `weather-alerts/`

## Then
- The `name` field in SKILL.md frontmatter is exactly `weather-alerts`
- The directory name and the `name` field are identical strings

## Verification Method

**Method**: Automated test

**Steps**:
1. Run the meta-skill to generate a skill
2. Read the parent directory name of the generated SKILL.md
3. Parse the YAML frontmatter and extract the `name` field
4. Assert `name == parent_directory_name`

**Expected evidence**: `name: weather-alerts` in frontmatter, parent directory is `weather-alerts/`. Both strings are identical.
