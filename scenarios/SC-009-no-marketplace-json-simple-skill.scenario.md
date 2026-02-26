# SC-009: Simple Generated Skills Do Not Include marketplace.json

> Covers: FR-005 — Generated skills MUST NOT include `.claude-plugin/marketplace.json` for simple skills
> Type: Happy Path

## Given
- The meta-skill is invoked to create a simple (single-skill) skill
- Input: "Create a skill for formatting markdown tables"

## When
- Phase 5 generates the complete skill directory

## Then
- The generated skill directory does NOT contain a `.claude-plugin/` subdirectory
- The generated skill directory does NOT contain a `marketplace.json` file at any level
- The skill activates solely via its SKILL.md file

## Verification Method

**Method**: CLI command

**Steps**:
1. Run the meta-skill to generate a simple skill
2. Run: `find markdown-table-formatter/ -name "marketplace.json" -o -name ".claude-plugin" | wc -l`
3. Verify the count is 0

**Expected evidence**: `find` returns 0 results. No `.claude-plugin/` directory or `marketplace.json` file exists anywhere in the generated skill directory.
