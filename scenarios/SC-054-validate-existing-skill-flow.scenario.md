# SC-054: Validate Existing Skill Flow

> Covers: FR-011, Section 2.2 — Secondary flow: Validate existing skill
> Type: Happy Path

## Given
- An existing skill directory `my-tool/` with:
  - Valid SKILL.md with proper frontmatter
  - `scripts/main.py` (clean, no secrets)
  - `references/guide.md`
  - No `.env` files

## When
- The user invokes: "Validate this skill: my-tool/"

## Then
- The meta-skill runs spec validation (frontmatter, naming, structure)
- The meta-skill runs security scan
- The meta-skill reports pass/fail with specific issues
- For this valid skill, both validation and security pass

## Verification Method

**Method**: Manual test

**Steps**:
1. Create a valid skill directory `my-tool/` with all proper files
2. Invoke the meta-skill with: "Validate this skill: my-tool/"
3. Observe the validation and security scan output

**Expected evidence**: Output shows:
```
Spec Validation: PASSED (0 errors, 0 warnings)
Security Scan: PASSED (0 findings)
```
