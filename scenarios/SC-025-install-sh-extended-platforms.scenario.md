# SC-025: install.sh Supports Extended Platforms and Custom Path

> Covers: FR-017 — install.sh SHOULD support .cursor/rules/, .codex/skills/, and custom paths via --path
> Type: Happy Path

## Given
- A generated skill `log-analysis/` with a valid `install.sh`

## When
- `./install.sh --platform cursor` is run
- Alternatively, `./install.sh --path /custom/skills/path/` is run

## Then
- For `--platform cursor`: skill is copied to `.cursor/rules/log-analysis/`
- For `--path /custom/skills/path/`: skill is copied to `/custom/skills/path/log-analysis/`
- Exit code is 0 in both cases

## Verification Method

**Method**: CLI command

**Steps**:
1. Run: `./log-analysis/install.sh --path /tmp/custom-skills/`
2. Run: `test -f /tmp/custom-skills/log-analysis/SKILL.md && echo "INSTALLED" || echo "FAILED"`
3. Verify exit code is 0

**Expected evidence**: Exit code 0. Skill files exist at the custom path. SKILL.md is present.
