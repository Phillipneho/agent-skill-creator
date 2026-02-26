# SC-019: Security Scan Detects .env File in Skill Directory

> Covers: FR-013 — Security scan MUST check for .env files
> Type: Failure

## Given
- A generated skill directory `env-skill/` contains a `.env` file with:
  ```
  DATABASE_URL=postgres://user:password@host:5432/db
  SECRET_KEY=supersecretvalue123
  ```

## When
- The security scan is run on `env-skill/`

## Then
- The security scan reports a finding about the `.env` file
- The `security` list contains a warning that `.env` files should not be included in skills

## Verification Method

**Method**: Automated test

**Steps**:
1. Create `env-skill/` with a valid SKILL.md and a `.env` file containing secrets
2. Run the security scan
3. Assert security findings reference the `.env` file

**Expected evidence**: Security finding like `"Sensitive file detected: .env should not be included in skill directory"`.
