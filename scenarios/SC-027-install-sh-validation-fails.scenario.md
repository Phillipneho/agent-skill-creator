# SC-027: install.sh Exits 1 When SKILL.md Is Invalid

> Covers: FR-015 — install.sh exit code 1: Validation failed (SKILL.md invalid)
> Type: Failure

## Given
- A skill directory with an invalid SKILL.md (missing required `name` field)
- The `install.sh` script exists in the directory

## When
- `./install.sh --platform claude-code` is run

## Then
- The install script detects the invalid SKILL.md before copying
- The script exits with code 1
- An error message about SKILL.md validation failure is displayed
- No files are copied to the destination

## Verification Method

**Method**: CLI command

**Steps**:
1. Create a skill directory with an invalid SKILL.md (missing `name`)
2. Run: `./install.sh --platform claude-code`
3. Check exit code: `echo $?`
4. Verify destination directory does not exist

**Expected evidence**: Exit code 1. Output includes "Validation failed" or "Invalid SKILL.md". No files copied to `~/.claude/skills/`.
