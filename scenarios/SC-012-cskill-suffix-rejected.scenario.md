# SC-012: User Requesting -cskill Suffix Gets Deprecation Notice

> Covers: FR-007 — Edge case from Section 2.3: User requests -cskill suffix
> Type: Edge Case

## Given
- The meta-skill is invoked with: "Create a skill called my-tool-cskill for file conversion"

## When
- The meta-skill processes the name and enters Phase 3 (Architecture)

## Then
- The user is informed that the `-cskill` suffix is deprecated and will not be used
- The generated directory and `name` field use `my-tool` or `file-conversion` (without `-cskill`)
- A warning message is displayed to the user about the deprecation

## Verification Method

**Method**: Manual test

**Steps**:
1. Invoke the meta-skill with: "Create a skill called my-tool-cskill for file conversion"
2. Observe the meta-skill's output during Phase 3
3. Verify a deprecation notice is displayed
4. Check the generated directory name does not end in `-cskill`

**Expected evidence**: Output contains a message like "The -cskill suffix is deprecated" or "Generating without -cskill suffix". Generated directory is `my-tool/` or `file-conversion/`, not `my-tool-cskill/`.
