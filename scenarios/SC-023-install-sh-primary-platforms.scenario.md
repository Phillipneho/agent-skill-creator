# SC-023: install.sh Supports Primary Platform Paths

> Covers: FR-016 — install.sh MUST support ~/.claude/skills/, ~/.github/skills/, .claude/skills/, .github/skills/
> Type: Happy Path

## Given
- A generated skill `log-analysis/` with a valid `install.sh`
- The test environment has `~/.claude/` directory present

## When
- `./install.sh --platform claude-code` is run

## Then
- The skill is copied to `~/.claude/skills/log-analysis/`
- The SKILL.md and all supporting files are present in the destination
- Exit code is 0

## Verification Method

**Method**: CLI command

**Steps**:
1. Run: `./log-analysis/install.sh --platform claude-code`
2. Run: `test -f ~/.claude/skills/log-analysis/SKILL.md && echo "INSTALLED" || echo "FAILED"`
3. Run: `echo $?` after install to check exit code

**Expected evidence**: Exit code 0. File `~/.claude/skills/log-analysis/SKILL.md` exists. All skill files are present in the destination.
