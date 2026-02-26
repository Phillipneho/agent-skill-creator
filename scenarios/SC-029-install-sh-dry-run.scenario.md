# SC-029: install.sh Dry Run Shows Actions Without Executing

> Covers: FR-015 — install.sh --dry-run support
> Type: Happy Path

## Given
- A valid skill directory `log-analysis/` with `install.sh`
- `~/.claude/` directory exists

## When
- `./install.sh --dry-run` is run

## Then
- The script outputs what it would do (detected platform, source path, destination path)
- No files are actually copied
- Exit code is 0

## Verification Method

**Method**: CLI command

**Steps**:
1. Run: `./log-analysis/install.sh --dry-run`
2. Capture output
3. Verify no files were created: `test -d ~/.claude/skills/log-analysis/ && echo "EXISTS" || echo "NOT CREATED"`

**Expected evidence**: Output shows "Would install to ~/.claude/skills/log-analysis/" (or similar). Destination directory does not exist after dry run. Exit code 0.
