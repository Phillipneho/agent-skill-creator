# SC-011: Generated Skill Names Do Not Use -cskill Suffix

> Covers: FR-007 — The `-cskill` naming suffix MUST be removed from all generated skill names
> Type: Happy Path

## Given
- The meta-skill is invoked with: "Create a skill for code review automation"

## When
- Phase 3 (Architecture) generates the directory structure
- Phase 5 (Implementation) generates all files

## Then
- The generated directory name does NOT end with `-cskill` (e.g., `code-review-automation/` not `code-review-automation-cskill/`)
- The `name` field in SKILL.md frontmatter does NOT contain `-cskill`
- No file content references the `-cskill` suffix as a naming convention

## Verification Method

**Method**: CLI command

**Steps**:
1. Run the meta-skill to generate the skill
2. Run: `ls -d */` to see generated directory name
3. Assert directory name does not end with `-cskill`
4. Run: `grep -r "cskill" code-review-automation/ | wc -l`
5. Assert count is 0

**Expected evidence**: Directory is named `code-review-automation/` (not `code-review-automation-cskill/`). Grep for "cskill" returns 0 matches.
