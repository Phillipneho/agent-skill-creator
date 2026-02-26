# SC-053: Backwards Compatibility with v3.x Workflows

> Covers: NFR-007 — Users can git pull and use immediately; no breaking changes to user-facing invocation
> Type: Happy Path

## Given
- A user has the v3.x version of agent-skill-creator installed via `/plugin marketplace add ./`
- The user runs `git pull` to update to v4.0

## When
- The user invokes the meta-skill with: "Create a skill for data validation"

## Then
- The meta-skill works without errors
- The 5-phase pipeline executes as before
- The trigger phrases that worked in v3.x still work
- The output is now v4.0 compliant (standard naming, no -cskill suffix) but the invocation did not break

## Verification Method

**Method**: Manual test

**Steps**:
1. From an existing v3.x installation, run: `git pull`
2. Invoke the meta-skill with a standard trigger: "Create a skill for data validation"
3. Verify the pipeline completes without errors
4. Verify the generated output is v4.0 compliant

**Expected evidence**: No errors during or after `git pull`. The meta-skill activates with the same trigger phrases. The 5 phases complete. Generated skill is v4.0 compliant (no -cskill, <500 line SKILL.md, includes install.sh).
