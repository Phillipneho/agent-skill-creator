# Cross-Platform Compatibility Guide

**Version:** 4.0
**Purpose:** Complete compatibility matrix for Agent Skills across all platforms supporting the Agent Skills Open Standard

---

## Overview

Skills created by agent-skill-creator are compliant with the **Agent Skills Open Standard** and work across all platforms that support the SKILL.md format. As of v4.0, this includes 8+ major platforms.

### Supported Platforms

| Platform | Type | SKILL.md Location |
|----------|------|-------------------|
| **Claude Code** | CLI | `~/.claude/skills/` or `.claude/skills/` |
| **GitHub Copilot CLI** | CLI | `.github/skills/` |
| **VS Code Copilot** | IDE Extension | `.github/skills/` |
| **Cursor** | IDE | `.cursor/rules/` |
| **Windsurf** | IDE | `.windsurf/skills/` |
| **Cline** | VS Code Extension | `.clinerules/` |
| **OpenAI Codex CLI** | CLI | `.codex/skills/` |
| **Gemini CLI** | CLI | `.gemini/skills/` |
| **Claude Desktop** | Desktop App | .zip upload |
| **claude.ai** | Web | .zip upload |
| **Claude API** | API | Programmatic upload |

### The Unifying Standard

All these platforms read the same SKILL.md format:

```yaml
---
name: skill-name
description: What the skill does and when to activate it
license: MIT
metadata:
  author: Author Name
  version: 1.0.0
---
# Skill content here...
```

A skill created once works everywhere without modification.

---

## Installation by Platform

### Claude Code

```bash
# Using install.sh (recommended)
./install.sh

# Manual: User-level
cp -r skill-name/ ~/.claude/skills/skill-name/

# Manual: Project-level
cp -r skill-name/ .claude/skills/skill-name/
```

**Best for:** Developers, power users, teams with git workflows.

### GitHub Copilot

```bash
# Using install.sh
./install.sh --platform copilot

# Manual: Project-level
cp -r skill-name/ .github/skills/skill-name/
```

**Best for:** GitHub-integrated workflows, VS Code users.

### Cursor

```bash
# Using install.sh
./install.sh --platform cursor

# Manual
cp -r skill-name/ .cursor/rules/skill-name/
```

**Best for:** Cursor IDE users. Cursor reads SKILL.md natively alongside its `.mdc` rules.

### Windsurf

```bash
# Using install.sh
./install.sh --platform windsurf

# Manual
cp -r skill-name/ .windsurf/skills/skill-name/
```

**Best for:** Windsurf IDE users.

### Cline

```bash
# Using install.sh
./install.sh --platform cline

# Manual
cp -r skill-name/ .clinerules/skill-name/
```

**Best for:** Cline extension users in VS Code.

### OpenAI Codex CLI

```bash
# Using install.sh
./install.sh --platform codex

# Manual
cp -r skill-name/ .codex/skills/skill-name/
```

**Best for:** Codex CLI users.

### Gemini CLI

```bash
# Using install.sh
./install.sh --platform gemini

# Manual
cp -r skill-name/ .gemini/skills/skill-name/
```

**Best for:** Gemini CLI users.

### Claude Desktop / claude.ai (Web)

These platforms use .zip upload instead of directory copying:

1. Export: `python scripts/export_utils.py ./skill-name --variant desktop`
2. Open Claude Desktop or claude.ai
3. Go to Settings > Skills > Upload skill
4. Select the .zip file

### Claude API

```python
import anthropic

client = anthropic.Anthropic()

with open('skill-name-api-v1.0.0.zip', 'rb') as f:
    skill = client.skills.create(file=f, name="skill-name")

response = client.messages.create(
    model="claude-sonnet-4",
    messages=[{"role": "user", "content": "Your query here"}],
    container={"type": "custom_skill", "skill_id": skill.id},
    betas=["code-execution-2025-08-25", "skills-2025-10-02"]
)
```

---

## Compatibility Matrix

### Core Functionality

| Feature | CLI Platforms | Desktop/Web | Claude API |
|---------|-------------|-------------|------------|
| **SKILL.md support** | Full | Full | Full |
| **Python scripts** | Full | Full | Sandboxed* |
| **References/docs** | Full | Full | Full |
| **Assets/templates** | Full | Full | Full |
| **install.sh** | Full | N/A | N/A |

\* API: No network access, no pip install at runtime

### Technical Specifications

| Specification | CLI Platforms | Desktop/Web | Claude API |
|---------------|-------------|-------------|------------|
| **Max skill size** | No limit | ~10MB | 8MB hard limit |
| **Network access** | Yes | Yes | No |
| **Package install** | Yes | Yes | No |
| **File system** | Full | Full | Limited |
| **Updates** | git pull | Re-upload | API upload |

---

## Platform-Specific Notes

### marketplace.json

- **Required by**: Claude Code (for plugin marketplace distribution only)
- **Not needed by**: All other platforms
- **Recommendation**: For simple skills, do not include `marketplace.json`. Only add it for complex skill suites that need Claude Code plugin distribution.
- **Format**: If included, use ONLY official fields: `name`, `plugins[].name`, `plugins[].description`, `plugins[].source`, `plugins[].skills`

### Skill Activation

All platforms that support the SKILL.md standard use the `description` field in frontmatter as the primary activation mechanism. The description should contain:

- Clear explanation of when to use the skill
- Domain-specific keywords
- Example trigger phrases

No platform-specific activation configuration is needed.

### File Structure

The standard skill directory works on all platforms:

```
skill-name/
├── SKILL.md          # Required - primary skill definition
├── scripts/          # Optional - executable code
├── references/       # Optional - detailed documentation
├── assets/           # Optional - templates, schemas, data
├── install.sh        # Optional - cross-platform installer
└── README.md         # Recommended - install instructions
```

---

## Migration Between Platforms

### CLI Platform to CLI Platform

Skills are directly portable. Just copy the directory to the target platform's skill location:

```bash
# From Claude Code to Copilot
cp -r ~/.claude/skills/my-skill/ .github/skills/my-skill/

# From Cursor to Cline
cp -r .cursor/rules/my-skill/ .clinerules/my-skill/
```

### CLI Platform to Desktop/Web

Export as .zip:

```bash
python scripts/export_utils.py ./my-skill --variant desktop
# Output: exports/my-skill-desktop-v1.0.0.zip
```

### CLI Platform to API

Export as optimized .zip:

```bash
python scripts/export_utils.py ./my-skill --variant api
# Output: exports/my-skill-api-v1.0.0.zip (< 8MB)
```

---

## Best Practices

1. **Develop once, deploy everywhere**: Create and test in your preferred CLI tool, then install on other platforms.
2. **Use install.sh**: Include the cross-platform installer for easy deployment.
3. **Keep SKILL.md lean**: Under 500 lines, detailed content in `references/`.
4. **Test activation**: Verify the `description` triggers correctly on your target platform.
5. **Include README.md**: Document installation instructions for all platforms.
6. **No platform hacks**: Avoid platform-specific code or configuration. The standard format works everywhere.

---

**Generated by:** agent-skill-creator v4.0
**Standard:** Agent Skills Open Standard (agentskills.io/specification)
