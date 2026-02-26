# SC-018: Security Scan Detects Hardcoded API Key

> Covers: FR-013 — Security scan MUST check for hardcoded API keys, secrets, and .env files
> Type: Happy Path

## Given
- A generated skill directory `leaky-skill/` contains a script `scripts/main.py` with:
  ```python
  API_KEY = "sk-proj-abc123def456ghi789jkl012mno345pqr678stu901vwx234"
  ```

## When
- The security scan is run as part of validation (or independently)

## Then
- The security scan fails
- The `security` list in the validation result contains a finding about the hardcoded API key
- The finding identifies the file (`scripts/main.py`) and the pattern matched

## Verification Method

**Method**: Automated test

**Steps**:
1. Create `leaky-skill/scripts/main.py` with a hardcoded API key string
2. Call `validate_skill("leaky-skill/")` or the dedicated security scan function
3. Assert `result.security` is non-empty
4. Assert a security finding references `scripts/main.py` and mentions "hardcoded" or "API key" or "secret"

**Expected evidence**: Security findings list includes an entry like `"Hardcoded secret detected in scripts/main.py: possible API key on line 1"`.
