# SC-015: Compatibility Field Included When Platform-Specific Features Used

> Covers: FR-010 — Generated skills SHOULD include `compatibility` field when platform-specific features are used
> Type: Happy Path

## Given
- The meta-skill is invoked to create a skill that uses platform-specific features
- Input: "Create a skill that uses Claude Code's allowed-tools feature to restrict tool access to only Bash and Read"

## When
- Phase 5 generates the SKILL.md

## Then
- The SKILL.md frontmatter includes a `compatibility` field
- The `compatibility` value describes which platforms or features are required (<=500 chars)
- The `allowed-tools` experimental field is also present in frontmatter

## Verification Method

**Method**: Automated test

**Steps**:
1. Run the meta-skill with the platform-specific input
2. Parse the YAML frontmatter
3. Assert `compatibility` key is present
4. Assert `len(compatibility) <= 500`
5. Assert the value references the platform-specific constraint

**Expected evidence**: Frontmatter contains `compatibility: "Requires Claude Code for allowed-tools support"` (or similar). Length is <=500 chars.
