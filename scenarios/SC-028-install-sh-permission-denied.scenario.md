# SC-028: install.sh Exits 3 on Permission Denied

> Covers: FR-015 — install.sh exit code 3: Permission denied
> Type: Failure

## Given
- A valid skill directory with `install.sh`
- The target directory `/root/protected/skills/` exists but is not writable by the current user

## When
- `./install.sh --path /root/protected/skills/` is run

## Then
- The install script detects the permission issue
- The script exits with code 3
- An error message about insufficient permissions is displayed

## Verification Method

**Method**: CLI command

**Steps**:
1. Run: `./install.sh --path /root/protected/skills/`
2. Check exit code: `echo $?`

**Expected evidence**: Exit code 3. Output includes "Permission denied" or "Cannot write to target directory".
