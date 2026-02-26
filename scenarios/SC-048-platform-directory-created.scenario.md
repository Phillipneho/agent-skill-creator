# SC-048: Platform Directory Created When Missing

> Covers: Edge case 2.3 — Platform directory doesn't exist (e.g., no .claude/): create it or inform user
> Type: Edge Case

## Given
- A valid skill `log-analysis/` with `install.sh`
- The target directory `~/.claude/skills/` does NOT exist

## When
- `./install.sh --platform claude-code` is run

## Then
- The `~/.claude/skills/` directory is created automatically
- The skill is installed to `~/.claude/skills/log-analysis/`
- Exit code is 0
- The user is informed that the directory was created

## Verification Method

**Method**: CLI command

**Steps**:
1. Ensure `~/.claude/skills/` does not exist: `rm -rf ~/.claude/skills/`
2. Run: `./log-analysis/install.sh --platform claude-code`
3. Assert `~/.claude/skills/log-analysis/SKILL.md` exists
4. Check exit code is 0

**Expected evidence**: Exit code 0. `~/.claude/skills/log-analysis/SKILL.md` exists. Output includes "Created directory ~/.claude/skills/".
