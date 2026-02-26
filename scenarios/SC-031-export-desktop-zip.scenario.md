# SC-031: Export System Produces Desktop/Web .zip Package

> Covers: FR-019 — Export system MUST continue to support Desktop/Web .zip variant
> Type: Happy Path

## Given
- A valid skill directory `log-analysis/` exists with all required files
- The export system (`scripts/export_utils.py`) is available

## When
- `export_skill("log-analysis/", variants=["desktop"])` is called

## Then
- A `.zip` file is generated for the Desktop/Web variant
- The zip contains the SKILL.md and all supporting files
- The zip is a valid archive that can be extracted

## Verification Method

**Method**: Automated test

**Steps**:
1. Call `export_skill("log-analysis/", variants=["desktop"])`
2. Assert the returned dict contains a path to a `.zip` file
3. Run: `unzip -t <output.zip>` to verify archive integrity
4. Assert SKILL.md is present in the archive listing

**Expected evidence**: A `.zip` file is produced. `unzip -t` reports "No errors detected". Archive contains `SKILL.md`.
