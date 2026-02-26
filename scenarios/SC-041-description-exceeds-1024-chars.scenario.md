# SC-041: Description Exceeds 1024 Characters Is Summarized

> Covers: FR-001, Edge case 2.3 — Description exceeds 1024 chars: summarize, move detail to body, warn user
> Type: Edge Case

## Given
- The meta-skill is invoked with an extremely detailed workflow description that would produce a description >1024 chars
- The Phase 4 (Detection) output initially generates a description of 1500 characters

## When
- Phase 5 generates the SKILL.md frontmatter

## Then
- The `description` field in frontmatter is <=1024 characters
- The excess detail is moved into the SKILL.md body (not lost)
- The user receives a warning that the description was summarized

## Verification Method

**Method**: Automated test

**Steps**:
1. Run the meta-skill with a very detailed workflow
2. Parse the generated SKILL.md frontmatter
3. Assert `len(description) <= 1024`
4. Verify SKILL.md body contains additional context that supplements the shortened description
5. Verify meta-skill output mentions description truncation

**Expected evidence**: `description` is <=1024 chars. SKILL.md body starts with expanded context. Warning message present.
