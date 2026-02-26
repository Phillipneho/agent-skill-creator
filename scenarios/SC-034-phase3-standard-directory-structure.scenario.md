# SC-034: Phase 3 Generates Standard-Compliant Directory Structure

> Covers: FR-022 — Phase 3 (Architecture) MUST generate standard-compliant directory structures (no -cskill suffix)
> Type: Happy Path

## Given
- The meta-skill is invoked with: "Create a skill for API rate limiting management"

## When
- Phase 3 (Architecture) completes and proposes the directory structure

## Then
- The proposed directory name is `api-rate-limiter/` (or similar, without `-cskill`)
- The structure includes: `SKILL.md`, `scripts/`, `references/`, `install.sh`, `README.md`
- No `.claude-plugin/` directory is proposed for a simple skill
- The structure matches the Agent Skills Open Standard layout

## Verification Method

**Method**: Manual test

**Steps**:
1. Run the meta-skill and observe Phase 3 output
2. Verify the directory name does not contain `-cskill`
3. Verify the proposed structure includes all standard files: SKILL.md, install.sh, README.md
4. Verify scripts/ and references/ directories are proposed

**Expected evidence**: Phase 3 output shows a directory like:
```
api-rate-limiter/
  SKILL.md
  scripts/
  references/
  install.sh
  README.md
```
No `-cskill` suffix. No `marketplace.json`.
