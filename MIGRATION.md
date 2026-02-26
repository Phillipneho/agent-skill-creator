# Migration Guide: v3.x to v4.0

## Overview

Agent-skill-creator v4.0 brings full compliance with the **Agent Skills Open Standard**, cross-platform support for 8+ platforms, and several breaking changes from v3.x.

## Breaking Changes

### 1. `-cskill` Suffix Removed

**Before (v3.x):**
```
pdf-text-extractor-cskill/
financial-analysis-suite-cskill/
```

**After (v4.0):**
```
pdf-text-extractor/
financial-analysis-suite/
```

**Migration:**
```bash
# Rename directory
mv my-skill-cskill my-skill

# Update SKILL.md frontmatter
# Change: name: my-skill-cskill
# To:     name: my-skill

# Update marketplace.json (if present)
# Change: "name": "my-skill-cskill"
# To:     "name": "my-skill"
```

### 2. marketplace.json Simplified

Non-standard fields have been removed. Simple skills no longer need marketplace.json at all.

**Before (v3.x):**
```json
{
  "name": "my-skill-cskill",
  "owner": { ... },
  "metadata": { ... },
  "plugins": [{ ... }],
  "compatibility": { ... },
  "templates": { ... },
  "capabilities": { ... },
  "activation": { ... },
  "usage": { ... },
  "test_queries": [...]
}
```

**After (v4.0):**
```json
{
  "name": "my-skill",
  "plugins": [{
    "name": "my-skill-plugin",
    "description": "...",
    "source": "./",
    "skills": ["./"]
  }]
}
```

**Migration:**
- For simple skills: Delete `.claude-plugin/marketplace.json` entirely
- For complex suites: Strip to only `name` and `plugins` fields

### 3. SKILL.md Frontmatter Updated

**Before (v3.x):** Only `name` and `description` required.

**After (v4.0):** Additional recommended fields:
```yaml
---
name: my-skill
description: >-
  Description here (<=1024 chars)
license: MIT
metadata:
  author: Your Name
  version: 1.0.0
---
```

### 4. SKILL.md Body Size Limit

Generated SKILL.md files must now be **under 500 lines**. Move detailed content to `references/` files.

### 5. install.sh Added

Generated skills now include an `install.sh` cross-platform installer script.

## How to Migrate Existing Skills

### Automated Migration

Ask the agent-skill-creator to migrate:

```
"Migrate this skill to the new standard"
"Update my-skill to v4 format"
```

### Manual Migration Steps

1. **Rename directory** (remove `-cskill` suffix)
2. **Update SKILL.md frontmatter**:
   - Remove `-cskill` from `name` field
   - Add `license`, `metadata` fields
   - Ensure `description` is <=1024 characters
3. **Simplify marketplace.json** (or delete for simple skills)
4. **Add install.sh** (copy from `scripts/install-template.sh` and customize)
5. **Update README.md** with multi-platform install instructions
6. **Validate**: Run `python3 scripts/validate.py ./my-skill/`
7. **Security scan**: Run `python3 scripts/security_scan.py ./my-skill/`

## Updating the Meta-Skill

If you have agent-skill-creator installed:

```bash
cd agent-skill-creator
git pull
```

The meta-skill will work immediately. No reinstallation required. The same trigger phrases and workflows still work.

## What Didn't Change

- The 5-phase pipeline (Discovery, Design, Architecture, Detection, Implementation)
- AgentDB integration (still optional)
- Support for both simple skills and complex suites
- Desktop/Web .zip export and Claude API export
- All activation trigger phrases

## New Features in v4.0

- **Cross-platform support**: Skills work on Claude Code, Copilot, Cursor, Windsurf, Cline, Codex CLI, Gemini CLI
- **install.sh**: Auto-detect platform and install to the correct location
- **Spec validation**: `scripts/validate.py` checks compliance with the Agent Skills Open Standard
- **Security scanning**: `scripts/security_scan.py` detects hardcoded keys and injection patterns
- **Lean SKILL.md**: Under 500 lines with progressive disclosure via references/
