# SC-006: Generated SKILL.md Is Under 500 Lines

> Covers: FR-003 — Generated SKILL.md body MUST be <500 lines, with detailed content in `references/`
> Type: Happy Path

## Given
- The meta-skill is invoked with a complex workflow description that would produce substantial documentation
- Input: "Create a skill for managing a full CI/CD pipeline with build, test, deploy stages, rollback procedures, monitoring integration, and multi-environment support"

## When
- Phase 5 generates the SKILL.md and all supporting files

## Then
- The generated SKILL.md file has fewer than 500 lines total
- A `references/` directory exists alongside SKILL.md containing detailed documentation
- The SKILL.md body contains cross-reference pointers (e.g., `See references/deployment-guide.md`) to the detailed content

## Verification Method

**Method**: Automated test

**Steps**:
1. Run the meta-skill with the complex workflow description
2. Count the lines in the generated SKILL.md: `wc -l skill-name/SKILL.md`
3. Verify `references/` directory exists and contains at least one file
4. Grep for cross-reference patterns in SKILL.md: `grep -c 'references/' skill-name/SKILL.md`

**Expected evidence**: SKILL.md line count is less than 500. `references/` directory contains one or more `.md` files. SKILL.md body contains at least one reference to `references/`.
