# Naming Conventions

## Overview

All skills created by Agent-Skill-Creator follow standard kebab-case naming per the Agent Skills Open Standard. The `name` field in SKILL.md frontmatter must match the parent directory name exactly.

## Rules

### Required Format

```
{descriptive-name}/
```

### Character Rules

- **Allowed**: Lowercase letters (`a-z`), numbers (`0-9`), hyphens (`-`)
- **Length**: 1-64 characters
- Must **not** start or end with a hyphen
- Must **not** contain consecutive hyphens (`--`)
- Must match the parent directory name exactly

### Examples

**Simple Skills:**
- `pdf-text-extractor/`
- `csv-data-cleaner/`
- `weekly-report-generator/`
- `stock-analyzer/`

**Complex Suites:**
- `financial-analysis-suite/`
- `e-commerce-automation/`
- `research-workflow/`

**Component Skills (within suites):**
- `data-acquisition/`
- `technical-analysis/`
- `reporting-generator/`

## Name Generation

When creating a skill name from user input:

1. **Extract key concepts** from the user's description
2. **Build descriptive name** using `{action}-{object}` or `{domain}-{purpose}` pattern
3. **Sanitize**: lowercase, replace spaces/underscores with hyphens, strip special characters
4. **Validate**: check length (1-64), no leading/trailing hyphens, no consecutive hyphens

```python
import re

def generate_skill_name(user_input: str) -> str:
    """Generate a valid skill name from user input."""
    name = user_input.lower()
    name = re.sub(r'[\s_]+', '-', name)
    name = re.sub(r'[^a-z0-9-]', '', name)
    name = re.sub(r'-+', '-', name)
    name = name.strip('-')
    return name[:64]
```

## Validation

```python
import re

def validate_skill_name(name: str) -> tuple[bool, str]:
    """Validate a skill name against the Agent Skills Open Standard."""
    if not name:
        return False, "Name cannot be empty"
    if len(name) > 64:
        return False, f"Name too long: {len(name)} chars (max 64)"
    if not re.match(r'^[a-z0-9]([a-z0-9-]*[a-z0-9])?$', name):
        return False, "Must be lowercase alphanumeric with hyphens, no leading/trailing hyphens"
    if '--' in name:
        return False, "Must not contain consecutive hyphens"
    return True, "Valid"
```

## Migration from v3.x

Skills created with v3.x used a `-cskill` suffix (e.g., `stock-analyzer-cskill/`). This suffix has been removed in v4.0 to comply with the Agent Skills Open Standard.

To migrate:

```bash
# Rename directory
mv stock-analyzer-cskill stock-analyzer

# Update SKILL.md frontmatter name field
# name: stock-analyzer

# Update marketplace.json name field (if present)
```

See `MIGRATION.md` for full migration instructions.
