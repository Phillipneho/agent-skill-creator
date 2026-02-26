# SC-001: Valid SKILL.md Frontmatter Generation

> Covers: FR-001 — Generated SKILL.md files MUST have valid frontmatter per the Agent Skills spec (name <=64 chars lowercase+hyphens, description <=1024 chars, both required)
> Type: Happy Path

## Given
- The meta-skill is invoked with a workflow description: "Create a skill for processing daily CSV files"
- The pipeline completes all 5 phases successfully

## When
- Phase 5 (Implementation) generates the SKILL.md file

## Then
- The generated SKILL.md begins with a YAML frontmatter block delimited by `---`
- The `name` field is present, lowercase, uses only hyphens as separators, and is <=64 characters (e.g., `csv-daily-processor`)
- The `description` field is present and is between 1 and 1024 characters
- The frontmatter block is valid YAML that can be parsed without errors

## Verification Method

**Method**: Automated test

**Steps**:
1. Run the meta-skill with input: "Create a skill for processing daily CSV files"
2. Read the generated `SKILL.md` file
3. Parse the YAML frontmatter between the `---` delimiters using Python `yaml.safe_load()`
4. Assert `name` is present, matches regex `^[a-z][a-z0-9-]*[a-z0-9]$`, and `len(name) <= 64`
5. Assert `description` is present and `1 <= len(description) <= 1024`

**Expected evidence**: YAML frontmatter parses successfully. `name` is a valid lowercase-kebab string <=64 chars. `description` is a non-empty string <=1024 chars. No YAML parsing errors.
