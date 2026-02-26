# SC-008: Meta-Skill's Own SKILL.md Is Under 500 Lines

> Covers: FR-004, FR-021 — The meta-skill's own SKILL.md MUST be <500 lines
> Type: Happy Path

## Given
- The agent-skill-creator repository has been updated to v4.0
- The meta-skill's own SKILL.md exists at `agent-skill-creator/SKILL.md`

## When
- The file is inspected for line count

## Then
- The meta-skill's SKILL.md has fewer than 500 lines
- Detailed content that was previously in the monolithic SKILL.md (4,116 lines) has been moved to `references/`
- The SKILL.md body contains cross-references to files in `references/`

## Verification Method

**Method**: CLI command

**Steps**:
1. Run: `wc -l /Users/francylisboacharuto/agent-skill-creator/SKILL.md`
2. Run: `ls /Users/francylisboacharuto/agent-skill-creator/references/`
3. Run: `grep -c 'references/' /Users/francylisboacharuto/agent-skill-creator/SKILL.md`

**Expected evidence**: Line count output is less than 500. `references/` contains multiple files. Grep shows at least 3 cross-references.
