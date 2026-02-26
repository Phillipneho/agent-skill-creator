# SC-030: Generated README.md Includes Multi-Platform Installation

> Covers: FR-018, FR-026 — README MUST include installation instructions for at least 5 platforms with copy-paste commands
> Type: Happy Path

## Given
- The meta-skill is invoked with: "Create a skill for git commit message generation"

## When
- Phase 5 generates the README.md

## Then
- The generated README.md contains a "Cross-Platform Installation" section (or equivalent)
- The section includes copy-paste commands for at least 5 platforms:
  - Claude Code
  - GitHub Copilot
  - Cursor
  - Windsurf
  - Cline (or Codex CLI, or Gemini CLI)
- Each platform section includes the exact shell command to install

## Verification Method

**Method**: CLI command

**Steps**:
1. Run the meta-skill to generate the skill
2. Run: `grep -i "claude code\|copilot\|cursor\|windsurf\|cline\|codex\|gemini" git-commit-generator/README.md | wc -l`
3. Assert count >= 5
4. Run: `grep -c "install\|cp\|copy\|mkdir" git-commit-generator/README.md`
5. Assert count >= 5 (at least one command per platform)

**Expected evidence**: README.md contains a "Cross-Platform Installation" section. At least 5 distinct platforms are listed with shell commands like `cp -r` or `./install.sh --platform`.
