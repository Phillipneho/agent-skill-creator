# SC-010: Complex Skill Suite May Include Standard marketplace.json

> Covers: FR-006 — Generated skills for complex suites MAY include a marketplace.json with ONLY official Claude Code fields
> Type: Happy Path

## Given
- The meta-skill is invoked to create a complex skill suite with multiple sub-skills
- Input: "Create a skill suite for full-stack web development with separate skills for frontend, backend, and deployment"

## When
- Phase 5 generates the complete skill suite directory

## Then
- If a `.claude-plugin/marketplace.json` is generated, it contains ONLY official fields: `name`, `plugins[].name`, `plugins[].description`, `plugins[].source`, `plugins[].skills`
- No non-standard fields are present (no `version`, no `author`, no `repository`, no `tags`)
- The JSON is valid and parseable

## Verification Method

**Method**: Automated test

**Steps**:
1. Run the meta-skill with the complex suite input
2. If `.claude-plugin/marketplace.json` exists, parse it with `json.load()`
3. Assert all keys are in the official set: `{"name", "plugins"}`
4. For each plugin, assert keys are subset of: `{"name", "description", "source", "skills"}`
5. Assert no extra keys exist at any level

**Expected evidence**: JSON parses cleanly. Only official fields present. No non-standard fields like `version`, `author`, `repository`, or `tags`.
