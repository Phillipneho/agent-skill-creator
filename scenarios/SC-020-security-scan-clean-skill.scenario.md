# SC-020: Security Scan Passes on Clean Skill

> Covers: FR-013 — Security scan MUST check for hardcoded secrets (negative case: no findings)
> Type: Happy Path

## Given
- A generated skill directory `clean-skill/` contains:
  - SKILL.md with valid frontmatter
  - `scripts/main.py` using environment variables: `os.environ.get("API_KEY")`
  - No `.env` files
  - No hardcoded secrets

## When
- The security scan is run on `clean-skill/`

## Then
- The security scan passes with no findings
- The `security` list in the validation result is empty

## Verification Method

**Method**: Automated test

**Steps**:
1. Create `clean-skill/` with SKILL.md and scripts using `os.environ.get()` for all secrets
2. Run the security scan
3. Assert `result.security` is empty or `len(result.security) == 0`

**Expected evidence**: `security: []` -- no security issues found.
