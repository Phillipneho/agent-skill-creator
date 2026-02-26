# SC-021: Security Scan Detects Shell Injection Patterns

> Covers: FR-014 — Security scan SHOULD check for shell injection patterns in generated scripts
> Type: Happy Path

## Given
- A generated skill directory `unsafe-skill/` contains `scripts/runner.py` with:
  ```python
  import subprocess
  user_input = input("Enter filename: ")
  subprocess.call(f"cat {user_input}", shell=True)
  ```

## When
- The security scan is run on `unsafe-skill/`

## Then
- The security scan identifies a shell injection risk
- The `security` list contains a finding about `subprocess.call` with `shell=True` and unsanitized input

## Verification Method

**Method**: Automated test

**Steps**:
1. Create `unsafe-skill/scripts/runner.py` with `subprocess.call(..., shell=True)` using f-string interpolation
2. Run the security scan
3. Assert security findings reference shell injection or `shell=True`

**Expected evidence**: Security finding like `"Potential shell injection in scripts/runner.py: subprocess.call with shell=True and string interpolation"`.
