# SC-066: Meta-Skill Activates on Standard Trigger Phrases

> Covers: Section 5.1 — Activation interface trigger phrases
> Type: Happy Path

## Given
- The meta-skill is installed and active in a Claude Code session

## When
- The user types one of the documented trigger phrases:
  - "Create a skill for file organization"
  - "Automate this workflow: daily report generation"
  - "Every day I copy CSV files manually, automate this"
  - "Create an agent for code formatting"
  - "Create a cross-platform skill for linting"
  - "Validate this skill: my-tool/"
  - "Export this skill for Cursor"

## Then
- Each trigger phrase activates the meta-skill
- The meta-skill begins the appropriate flow (creation, validation, export, or migration)

## Verification Method

**Method**: Manual test

**Steps**:
1. Start a Claude Code session with the meta-skill installed
2. Test each trigger phrase individually
3. Verify the meta-skill activates and begins the correct flow

**Expected evidence**: Each trigger phrase results in the meta-skill activating. "Create a skill" triggers the 5-phase pipeline. "Validate this skill" triggers the validation flow. "Export this skill" triggers the export flow.
