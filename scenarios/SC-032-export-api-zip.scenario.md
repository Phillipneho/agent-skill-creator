# SC-032: Export System Produces API .zip Package Under 8MB

> Covers: FR-019 — Export system MUST continue to support API .zip variant
> Type: Happy Path

## Given
- A valid skill directory `log-analysis/` exists with all required files
- The export system (`scripts/export_utils.py`) is available

## When
- `export_skill("log-analysis/", variants=["api"])` is called

## Then
- A `.zip` file is generated for the API variant
- The zip file size is less than 8MB
- The zip contains an optimized subset of files suitable for API consumption

## Verification Method

**Method**: Automated test

**Steps**:
1. Call `export_skill("log-analysis/", variants=["api"])`
2. Assert the returned dict contains a path to a `.zip` file
3. Check file size: `os.path.getsize(zip_path) < 8 * 1024 * 1024`
4. Run: `unzip -t <output.zip>` to verify integrity

**Expected evidence**: A `.zip` file is produced. File size is less than 8,388,608 bytes (8MB). `unzip -t` reports no errors.
