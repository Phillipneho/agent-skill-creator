# SC-040: Skill Name Exceeds 64 Characters Is Truncated

> Covers: FR-001, Edge case 2.3 — Skill name exceeds 64 chars: truncate intelligently, warn user, suggest alternative
> Type: Edge Case

## Given
- The meta-skill is invoked with a very long workflow name
- Input: "Create a skill for automatically processing and analyzing extremely long complex multi-step data transformation pipelines with validation"

## When
- Phase 3 derives the skill name from the description

## Then
- The generated `name` field is <=64 characters
- The name is truncated at a word boundary (not mid-word)
- The user receives a warning that the name was truncated
- An alternative shorter name is suggested

## Verification Method

**Method**: Automated test

**Steps**:
1. Run the meta-skill with the long workflow description
2. Parse the generated SKILL.md frontmatter
3. Assert `len(name) <= 64`
4. Assert the name does not end with a partial word fragment
5. Verify meta-skill output contains a truncation warning

**Expected evidence**: `name` is <=64 chars. Output includes a message like "Name truncated from 78 to 64 characters" and suggests an alternative. Name ends at a clean word boundary.
