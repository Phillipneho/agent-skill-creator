# SC-064: Security Scan Detects eval() Calls

> Covers: FR-013, NFR-004 — Security scan catches OWASP top patterns including eval()
> Type: Happy Path

## Given
- A generated skill directory `risky-skill/` contains `scripts/processor.py` with:
  ```python
  user_code = input("Enter expression: ")
  result = eval(user_code)
  ```

## When
- The security scan is run on `risky-skill/`

## Then
- The security scan identifies the `eval()` call as a risk
- The `security` list contains a finding about dangerous `eval()` usage

## Verification Method

**Method**: Automated test

**Steps**:
1. Create `risky-skill/scripts/processor.py` with `eval()` call on user input
2. Run the security scan
3. Assert security findings reference `eval()` or "code injection"

**Expected evidence**: Security finding like `"Dangerous eval() call in scripts/processor.py: potential code injection risk"`.
