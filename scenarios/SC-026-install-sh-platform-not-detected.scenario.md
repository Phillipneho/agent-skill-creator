# SC-026: install.sh Falls Back When No Platform Detected

> Covers: FR-015, Edge case from 2.3 — install.sh target platform not detected: fall back to interactive prompt
> Type: Edge Case

## Given
- A generated skill with a valid `install.sh`
- The system has NONE of the standard platform directories (`~/.claude/`, `~/.github/`, `.cursor/`, etc.)

## When
- `./install.sh` is run without `--platform` or `--path` flags

## Then
- The script does NOT silently fail
- The script outputs a message listing available platforms and asks the user to specify one
- Exit code is 2 (Platform not detected)

## Verification Method

**Method**: CLI command

**Steps**:
1. In a clean environment without any platform directories, run: `./install.sh`
2. Check the output for a prompt or platform list
3. Check exit code: `echo $?`

**Expected evidence**: Exit code 2. Output contains a message like "No supported platform detected. Please specify with --platform or --path." Lists available platform options.
