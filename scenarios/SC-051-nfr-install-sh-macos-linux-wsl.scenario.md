# SC-051: install.sh Works on macOS, Linux, and WSL

> Covers: NFR-005 — install.sh must work on macOS, Linux, and WSL (3 OS families)
> Type: Performance

## Given
- A generated skill with an `install.sh` script
- The script uses only POSIX-compatible bash constructs

## When
- The script is analyzed for POSIX compatibility

## Then
- The shebang is `#!/usr/bin/env bash` or `#!/bin/bash`
- No macOS-only (`gstat`, `pbcopy`) or Linux-only (`apt`, `systemctl`) commands are used
- Path handling uses `$HOME` instead of hardcoded paths
- The script uses portable constructs (`[` not `[[` where possible, `printf` not `echo -e`)

## Verification Method

**Method**: CLI command

**Steps**:
1. Run: `head -1 install.sh` to check shebang
2. Run: `shellcheck install.sh` (if available) to check for portability issues
3. Grep for non-portable constructs: `grep -n "gstat\|pbcopy\|apt-get\|systemctl\|echo -e" install.sh`
4. Verify `$HOME` is used instead of `/Users/` or `/home/`

**Expected evidence**: Shebang is `#!/usr/bin/env bash`. `shellcheck` reports no portability errors. No platform-specific commands found. `$HOME` used for home directory references.
