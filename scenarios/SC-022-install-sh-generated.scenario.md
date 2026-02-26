# SC-022: Generated Skills Include install.sh

> Covers: FR-015 — Generated skills MUST include an `install.sh` script that auto-detects the platform
> Type: Happy Path

## Given
- The meta-skill is invoked with: "Create a skill for log analysis"

## When
- Phase 5 generates the complete skill directory

## Then
- An `install.sh` file exists in the root of the generated skill directory
- The file is executable (`chmod +x`)
- The script contains platform auto-detection logic (checks for `~/.claude/`, `~/.github/`, etc.)
- Running `./install.sh --dry-run` shows what would happen without making changes

## Verification Method

**Method**: CLI command

**Steps**:
1. Run the meta-skill to generate the skill
2. Run: `test -f log-analysis/install.sh && echo "EXISTS" || echo "MISSING"`
3. Run: `test -x log-analysis/install.sh && echo "EXECUTABLE" || echo "NOT EXECUTABLE"`
4. Run: `grep -c "auto-detect\|platform\|claude\|copilot\|cursor" log-analysis/install.sh`
5. Run: `./log-analysis/install.sh --dry-run`

**Expected evidence**: File exists and is executable. Script contains platform detection strings. Dry run outputs detected platform and intended installation path without making changes.
