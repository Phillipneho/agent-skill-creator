# SC-059: install.sh Installs to GitHub Copilot Path

> Covers: FR-016 — install.sh MUST support ~/.github/skills/ and .github/skills/
> Type: Happy Path

## Given
- A generated skill `code-review/` with a valid `install.sh`
- The user wants to install for GitHub Copilot

## When
- `./install.sh --platform copilot` is run

## Then
- The skill is copied to `.github/skills/code-review/` (project level) or `~/.github/skills/code-review/` (user level)
- All skill files are present in the destination
- Exit code is 0

## Verification Method

**Method**: CLI command

**Steps**:
1. Run: `./code-review/install.sh --platform copilot`
2. Verify the skill files exist at the Copilot path
3. Check exit code is 0

**Expected evidence**: Exit code 0. Skill files exist at `.github/skills/code-review/` or `~/.github/skills/code-review/`. SKILL.md is present.
