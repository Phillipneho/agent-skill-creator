# SC-056: Migrate Legacy Skill with -cskill Suffix and marketplace.json

> Covers: FR-007, FR-005, Section 2.2 — Secondary flow: Migrate legacy skill
> Type: Happy Path

## Given
- A legacy skill directory `my-tool-cskill/` exists with:
  - SKILL.md with `name: my-tool-cskill`
  - `.claude-plugin/marketplace.json` with non-standard fields (`version`, `author`, `tags`)
  - Scripts and references from v3.x

## When
- The user invokes: "Migrate this skill to the new standard"

## Then
- The directory is renamed from `my-tool-cskill/` to `my-tool/`
- The `name` field in SKILL.md is updated to `my-tool`
- The `.claude-plugin/marketplace.json` is removed (simple skill) or stripped to official fields only
- An `install.sh` is generated
- A README.md with cross-platform instructions is generated
- Validation passes on the migrated skill

## Verification Method

**Method**: Manual test

**Steps**:
1. Create `my-tool-cskill/` with legacy structure
2. Invoke: "Migrate this skill to the new standard"
3. Verify `my-tool-cskill/` no longer exists
4. Verify `my-tool/` exists with updated files
5. Verify `name: my-tool` in SKILL.md
6. Verify `.claude-plugin/` is removed
7. Verify `install.sh` and `README.md` exist
8. Run validation on `my-tool/`

**Expected evidence**: Directory renamed. Frontmatter updated. marketplace.json removed. install.sh and README.md present. Validation passes.
