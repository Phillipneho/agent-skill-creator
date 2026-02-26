# SC-013: Generated Skills Include License Field

> Covers: FR-008 — Generated skills MUST include `license` field in frontmatter
> Type: Happy Path

## Given
- The meta-skill is invoked to create a skill
- Input: "Create a skill for API health monitoring"

## When
- Phase 5 generates the SKILL.md

## Then
- The SKILL.md frontmatter includes a `license` field
- The license value is a recognized SPDX identifier (e.g., `MIT`, `Apache-2.0`, `ISC`)

## Verification Method

**Method**: Automated test

**Steps**:
1. Run the meta-skill to generate the skill
2. Parse the YAML frontmatter of the generated SKILL.md
3. Assert `license` key is present in frontmatter
4. Assert value is a non-empty string

**Expected evidence**: Frontmatter contains `license: MIT` (or another valid SPDX identifier).
