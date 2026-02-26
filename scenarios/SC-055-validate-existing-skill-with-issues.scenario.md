# SC-055: Validate Existing Skill Reports Specific Issues

> Covers: FR-011, FR-012, Section 2.2 — Secondary flow: Validate existing skill with issues
> Type: Failure

## Given
- An existing skill directory `broken-tool/` with:
  - SKILL.md with `name: Broken_Tool` (invalid format)
  - Description of 1500 characters (exceeds 1024 limit)
  - `scripts/main.py` containing `API_KEY = "sk-secret123"`
  - A `.env` file with database credentials

## When
- The user invokes: "Validate this skill: broken-tool/"

## Then
- Spec validation fails with specific errors:
  - Invalid name format (uppercase, underscore)
  - Description exceeds 1024 characters
  - Name does not match directory name
- Security scan reports findings:
  - Hardcoded API key in scripts/main.py
  - .env file with credentials
- Fix suggestions are provided for each issue

## Verification Method

**Method**: Automated test

**Steps**:
1. Create `broken-tool/` with the described invalid files
2. Call `validate_skill("broken-tool/")`
3. Assert `result.valid is False`
4. Assert `result.errors` has >=3 entries (name format, description length, directory mismatch)
5. Assert `result.security` has >=2 entries (hardcoded key, .env file)

**Expected evidence**: `valid: False`. Errors list includes name format, description length, and directory mismatch issues. Security list includes hardcoded key and .env file findings. Each finding includes a fix suggestion.
