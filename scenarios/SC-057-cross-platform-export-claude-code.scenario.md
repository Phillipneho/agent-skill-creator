# SC-057: Cross-Platform Export for Claude Code

> Covers: FR-019, Section 2.2 — Export flow: Claude Code standard directory
> Type: Happy Path

## Given
- A valid skill directory `data-processor/` exists
- The user wants to export for Claude Code

## When
- The user invokes: "Export this skill for Claude Code"

## Then
- The export generates a standard directory output (ready to copy to `~/.claude/skills/` or `.claude/skills/`)
- The output includes all necessary files (SKILL.md, scripts, references, install.sh, README.md)
- A platform-specific installation guide is provided

## Verification Method

**Method**: Manual test

**Steps**:
1. Create a valid skill `data-processor/`
2. Invoke: "Export this skill for Claude Code"
3. Verify the output is a directory (not .zip) with all standard files
4. Verify installation instructions reference `~/.claude/skills/` and `.claude/skills/`

**Expected evidence**: Output is a standard skill directory. Contains SKILL.md, install.sh, README.md. Installation guide references Claude Code paths.
