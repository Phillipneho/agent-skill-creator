# SC-045: Directory Renamed When It Doesn't Match Name Field

> Covers: FR-002, Edge case 2.3 — Directory name doesn't match name field: rename directory to match, warn user
> Type: Edge Case

## Given
- During migration or manual editing, a skill directory is named `old-name/`
- The SKILL.md inside has `name: new-name` in frontmatter

## When
- The "Migrate Legacy Skill" flow is invoked on `old-name/`

## Then
- The directory is renamed from `old-name/` to `new-name/`
- The user is warned about the rename
- All files inside are preserved after the rename
- Validation passes after the rename

## Verification Method

**Method**: CLI command

**Steps**:
1. Create `old-name/` with SKILL.md containing `name: new-name`
2. Run the migration flow on `old-name/`
3. Assert `old-name/` no longer exists
4. Assert `new-name/` exists with all original files
5. Run validation on `new-name/` and assert it passes

**Expected evidence**: `old-name/` is gone. `new-name/` exists with intact files. Validation passes. Output includes "Renamed directory from 'old-name' to 'new-name'".
