# SC-046: Hardcoded API Key Replaced with Environment Variable Reference

> Covers: FR-013, Edge case 2.3 — Generated script contains hardcoded API key: fail scan, replace with env var, warn user
> Type: Edge Case

## Given
- During Phase 5, the generated `scripts/main.py` contains:
  ```python
  API_KEY = "sk-abc123def456"
  headers = {"Authorization": f"Bearer {API_KEY}"}
  ```

## When
- The security scan runs on the generated skill

## Then
- The security scan fails and identifies the hardcoded key
- The script is updated to use an environment variable:
  ```python
  API_KEY = os.environ.get("API_KEY")
  headers = {"Authorization": f"Bearer {API_KEY}"}
  ```
- The user is warned about the replacement

## Verification Method

**Method**: Automated test

**Steps**:
1. Generate a skill where a script would contain a hardcoded API key
2. After Phase 5 completes, read `scripts/main.py`
3. Assert the hardcoded key string `sk-abc123def456` is NOT present
4. Assert `os.environ.get` or `os.getenv` is present
5. Verify security scan output mentions the replacement

**Expected evidence**: No hardcoded key in final script. `os.environ.get("API_KEY")` is used instead. Security warning present in output.
