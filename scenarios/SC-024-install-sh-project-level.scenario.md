# SC-024: install.sh Supports Project-Level Installation

> Covers: FR-016 — install.sh MUST support .claude/skills/ (project) and .github/skills/ (project)
> Type: Happy Path

## Given
- A generated skill `log-analysis/` with a valid `install.sh`
- The current directory is a project root (e.g., `/tmp/my-project/`)

## When
- `./install.sh --project` is run from `/tmp/my-project/`

## Then
- The skill is copied to `.claude/skills/log-analysis/` relative to the current directory
- If `.claude/` does not exist, it is created
- Exit code is 0

## Verification Method

**Method**: CLI command

**Steps**:
1. Create a temp project directory: `mkdir -p /tmp/my-project && cd /tmp/my-project`
2. Run: `path/to/log-analysis/install.sh --project`
3. Run: `test -f /tmp/my-project/.claude/skills/log-analysis/SKILL.md && echo "INSTALLED" || echo "FAILED"`

**Expected evidence**: Exit code 0. `.claude/skills/log-analysis/SKILL.md` exists relative to the project root.
