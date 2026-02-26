# SC-062: Example Skill Renamed from -cskill to Standard

> Covers: FR-007, Migration Requirements — article-to-prototype-cskill must be renamed and updated
> Type: Happy Path

## Given
- The v3.x repository had `article-to-prototype-cskill/` as an example skill
- The repository has been updated to v4.0

## When
- The repository file structure is inspected

## Then
- `article-to-prototype-cskill/` no longer exists
- `article-to-prototype/` exists as the renamed example
- The SKILL.md inside has `name: article-to-prototype` (no -cskill)
- The example follows v4.0 conventions (install.sh, README.md with cross-platform instructions)

## Verification Method

**Method**: CLI command

**Steps**:
1. Run: `test -d /Users/francylisboacharuto/agent-skill-creator/article-to-prototype-cskill && echo "OLD EXISTS" || echo "OLD REMOVED"`
2. Run: `test -d /Users/francylisboacharuto/agent-skill-creator/article-to-prototype && echo "NEW EXISTS" || echo "NEW MISSING"`
3. If new exists, grep for name field: `grep "^name:" article-to-prototype/SKILL.md`

**Expected evidence**: `article-to-prototype-cskill/` does not exist. `article-to-prototype/` exists. SKILL.md contains `name: article-to-prototype`.
