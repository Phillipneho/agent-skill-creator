# SC-033: Export System Supports --platform Flag for Cursor

> Covers: FR-020 — Export system SHOULD add a --platform flag to generate platform-specific output
> Type: Happy Path

## Given
- A valid skill directory `log-analysis/` exists
- The export system supports the `platform` parameter

## When
- `export_skill("log-analysis/", platform="cursor")` is called

## Then
- The export generates a Cursor-compatible output (e.g., an `.mdc` file or Cursor-formatted directory)
- The output contains the SKILL.md content adapted for Cursor's rule format

## Verification Method

**Method**: Automated test

**Steps**:
1. Call `export_skill("log-analysis/", platform="cursor")`
2. Check that the output contains a `.mdc` file or Cursor-specific format
3. Verify the content includes the original skill instructions

**Expected evidence**: An `.mdc` file or Cursor-compatible output is produced. Content preserves the skill's instructions.
