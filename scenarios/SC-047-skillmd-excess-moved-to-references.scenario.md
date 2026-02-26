# SC-047: Excess SKILL.md Content Moved to References

> Covers: FR-003, Edge case 2.3 — SKILL.md body exceeds 500 lines: move excess to references, add cross-references
> Type: Edge Case

## Given
- During Phase 5, the initial SKILL.md draft has 750 lines of body content

## When
- The line-count check runs and detects the excess

## Then
- The SKILL.md is trimmed to <500 lines
- The excess content is extracted and saved to one or more files in `references/`
- The SKILL.md body contains cross-reference links like `See references/detailed-guide.md for full documentation`
- No content is lost -- it is all preserved in `references/`

## Verification Method

**Method**: Automated test

**Steps**:
1. Generate a skill with a very complex workflow that produces extensive documentation
2. Count lines in SKILL.md: `wc -l SKILL.md`
3. Assert line count <500
4. List files in `references/`: `ls references/`
5. Assert at least one reference file contains content from the original SKILL.md draft
6. Grep SKILL.md for cross-references: `grep 'references/' SKILL.md`

**Expected evidence**: SKILL.md is <500 lines. `references/` contains extracted detail files. SKILL.md body contains at least one `references/` cross-reference.
