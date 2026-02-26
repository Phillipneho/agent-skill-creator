# SC-049: Complex Suite marketplace.json Contains Only Official Fields

> Covers: FR-006, Edge case 2.3 — Complex skill suite marketplace.json has ONLY official fields
> Type: Edge Case

## Given
- The meta-skill generates a complex multi-skill suite
- A `.claude-plugin/marketplace.json` is created

## When
- The validation runs on the suite

## Then
- The marketplace.json contains ONLY the following fields:
  - Top level: `name`, `plugins`
  - Per plugin: `name`, `description`, `source`, `skills`
- No non-standard fields exist (no `version`, `author`, `repository`, `tags`, `icon`, etc.)
- The JSON is valid

## Verification Method

**Method**: Automated test

**Steps**:
1. Generate a complex skill suite
2. Parse `.claude-plugin/marketplace.json` with `json.load()`
3. Assert top-level keys are exactly `{"name", "plugins"}`
4. For each plugin in `plugins`, assert keys are a subset of `{"name", "description", "source", "skills"}`
5. Fail if any extra keys are found at any level

**Expected evidence**: JSON contains only `name` and `plugins` at top level. Each plugin entry has only `name`, `description`, `source`, `skills`. No extra fields like `version` or `author`.
