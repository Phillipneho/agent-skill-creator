# Agent Skill Creator v4.0

**Create Cross-Platform Agent Skills from Workflow Descriptions**

[![Agent Skills Open Standard](https://img.shields.io/badge/Agent%20Skills-Open%20Standard-blue)](https://github.com/anthropics/agent-skills-spec)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-4.0.0-brightgreen)]()

> Works on **8+ platforms**: Claude Code, GitHub Copilot, Cursor, Windsurf, Cline, Codex CLI, Gemini CLI, and any platform supporting the Agent Skills Open Standard.

---

## What It Does

Agent Skill Creator is a **meta-skill** -- a skill that creates other skills. Describe a repetitive workflow in natural language, and it generates a complete, validated, cross-platform agent skill through an autonomous 5-phase pipeline.

**Input**: A workflow description like *"Every day I download stock data, analyze trends, and create reports"*

**Output**: A ready-to-install skill directory with functional scripts, documentation, cross-platform installer, and spec-compliant SKILL.md.

---

## Quick Start

### Install

```bash
# Clone and install as a Claude Code skill
git clone https://github.com/user/agent-skill-creator.git
cp -r agent-skill-creator/ ~/.claude/skills/agent-skill-creator/
```

### Use

Just describe what you need in your agent:

```
"Create a skill for analyzing stock market data"

"Every day I process CSV files manually, automate this"

"Create a cross-platform skill for weather alerts"

"Validate this skill for spec compliance"

"Export this skill for Cursor and Copilot"
```

The skill creator activates automatically when it detects these patterns and walks through the full pipeline.

---

## Supported Platforms

Generated skills work on any platform that supports the Agent Skills Open Standard:

| Platform | Install Location | Notes |
|----------|-----------------|-------|
| **Claude Code** | `~/.claude/skills/` or `.claude/skills/` | Global or per-project |
| **GitHub Copilot** | `.github/skills/` | Repository-level |
| **Cursor** | `.cursor/rules/` | Workspace rules |
| **Windsurf** | `.windsurf/skills/` | Workspace skills |
| **Cline** | `.clinerules/` | Rule-based skills |
| **Codex CLI** | `.codex/skills/` | OpenAI Codex CLI |
| **Gemini CLI** | `.gemini/skills/` | Google Gemini CLI |

Each generated skill includes an `install.sh` script that auto-detects your platform and installs to the correct location.

---

## How It Works

The creator runs a **5-phase autonomous pipeline**:

```
Phase 1: DISCOVERY        Research APIs, data sources, tools, and domain knowledge
                          |
Phase 2: DESIGN           Define use cases, analyses, methodologies, and outputs
                          |
Phase 3: ARCHITECTURE     Structure skill directory (simple skill vs. complex suite)
                          |
Phase 4: DETECTION        Generate description + keywords for reliable activation
                          |
Phase 5: IMPLEMENTATION   Create all files, run validation, run security scan
```

### Phase Details

| Phase | What Happens | Key Output |
|-------|-------------|------------|
| **Discovery** | Researches the domain, identifies APIs and data sources, maps user needs | Domain model, API list, data sources |
| **Design** | Defines use cases, analysis methods, output formats | Use case specs, methodology docs |
| **Architecture** | Decides simple skill vs. complex suite, plans directory structure | Architecture decision, file plan |
| **Detection** | Crafts SKILL.md description and activation keywords for reliable triggering | SKILL.md frontmatter, trigger phrases |
| **Implementation** | Generates all code, docs, installer; validates and scans for security issues | Complete skill directory |

For full pipeline documentation, see [references/pipeline-phases.md](references/pipeline-phases.md).

---

## Architecture: Simple Skill vs. Complex Suite

The creator automatically decides the right architecture based on scope:

### Simple Skill

For focused, single-domain tasks (e.g., "analyze CSV files", "extract text from PDFs").

```
stock-analyzer/
  SKILL.md              # Under 500 lines, spec-compliant
  scripts/
    analyze.py
    fetch_data.py
  references/
    api-guide.md
  assets/
    report-template.html
  install.sh
  README.md
```

### Complex Suite

For multi-domain workflows requiring coordinated agents (e.g., "full financial analysis pipeline with data collection, analysis, and reporting").

```
financial-analysis-suite/
  SKILL.md              # Suite orchestrator, under 500 lines
  scripts/
    orchestrator.py
    data_collector.py
    analyzer.py
    report_generator.py
  references/
    architecture-guide.md
    api-reference.md
  assets/
    templates/
    schemas/
  install.sh
  README.md
```

For detailed architecture guidance, see [references/architecture-guide.md](references/architecture-guide.md).

---

## Generated Skill Format

Every generated skill follows the Agent Skills Open Standard structure:

```
skill-name/
  SKILL.md              # Main skill file (<500 lines, spec-compliant)
  scripts/              # Functional Python code
  references/           # Detailed documentation (progressive disclosure)
  assets/               # Templates, schemas, config files
  install.sh            # Cross-platform installer
  README.md             # Multi-platform install instructions
```

### SKILL.md Structure

The generated SKILL.md includes standard frontmatter:

```yaml
---
name: skill-name
description: >-
  Concise description of what the skill does (<=1024 chars).
  Includes activation trigger phrases.
license: MIT
metadata:
  author: Your Name
  version: 1.0.0
compatibility: >-
  Works on Claude Code, GitHub Copilot, Cursor, Windsurf,
  Cline, Codex CLI, Gemini CLI.
---
```

Followed by sections: When to Use, Overview, Workflow, Implementation Guidelines, and References.

---

## Naming Convention

Skills follow the **Agent Skills Open Standard** naming rules:

- **Format**: `kebab-case` (lowercase letters and hyphens only)
- **Length**: 1-64 characters
- **Pattern**: `^[a-z][a-z0-9-]*[a-z0-9]$`
- **No special suffixes** required

### Examples

| Good | Bad |
|------|-----|
| `stock-analyzer` | `Stock_Analyzer` |
| `csv-data-cleaner` | `csv_data_cleaner` |
| `financial-analysis-suite` | `FinancialAnalysis` |
| `weather-alerts` | `weather-alerts-cskill` |

---

## Validation and Security

### Validate a Skill

Check that a generated skill is compliant with the Agent Skills Open Standard:

```bash
python3 scripts/validate.py ./my-skill/
```

Validates:
- SKILL.md exists and has valid frontmatter
- Name follows kebab-case convention (1-64 chars)
- Description is under 1024 characters
- SKILL.md is under 500 lines
- Required directory structure is present
- install.sh exists and is executable

### Security Scan

Scan for common security issues before sharing or deploying:

```bash
python3 scripts/security_scan.py ./my-skill/
```

Detects:
- Hardcoded API keys, tokens, and secrets
- Potential command injection patterns
- Unsafe file operations
- Credential exposure in configuration files

---

## Cross-Platform Export

Export skills for different deployment targets:

### Desktop/Web Export

Generates a `.zip` archive suitable for sharing or manual installation:

```bash
python3 scripts/export_utils.py ./my-skill/ --variant desktop
```

### API Export

Generates a package suitable for Claude API integration:

```bash
python3 scripts/export_utils.py ./my-skill/ --variant api
```

For full export documentation, see [references/export-guide.md](references/export-guide.md).

---

## Example Skill

The repository includes a complete example skill:

### article-to-prototype

Converts academic articles and research papers into functional prototypes. Demonstrates the full skill structure including scripts, references, and cross-platform installer.

```
article-to-prototype/
  SKILL.md
  scripts/
    article_processor.py
    prototype_generator.py
    validation_engine.py
  references/
    methodology.md
    supported-formats.md
  assets/
    prototype-templates/
  install.sh
  README.md
```

See [article-to-prototype/](article-to-prototype/) for the full example.

---

## Project Structure

The agent-skill-creator repository itself:

```
agent-skill-creator/
  SKILL.md                    # Meta-skill definition (this skill's spec)
  README.md                   # This file
  MIGRATION.md                # v3.x to v4.0 migration guide
  .gitignore
  scripts/
    validate.py               # Spec compliance validator
    security_scan.py           # Security scanner
    export_utils.py            # Cross-platform export tool
    install-template.sh        # Template for generated install.sh
  references/
    pipeline-phases.md         # Full 5-phase pipeline docs
    architecture-guide.md      # Simple skill vs. complex suite
    cross-platform-guide.md    # Platform-specific details
    export-guide.md            # Export system documentation
    phase1-discovery.md        # Phase 1 deep dive
    phase2-design.md           # Phase 2 deep dive
    phase3-architecture.md     # Phase 3 deep dive
    phase4-detection.md        # Phase 4 deep dive
    phase5-implementation.md   # Phase 5 deep dive
    phase6-testing.md          # Testing guide
    quality-standards.md       # Quality standards reference
    templates-guide.md         # Template system guide
    templates/                 # Skill templates
    tools/                     # Validation and scanning tools
    examples/                  # Example configurations
  integrations/
    agentdb_bridge.py          # AgentDB integration bridge
    agentdb_real_integration.py
    fallback_system.py         # Graceful degradation system
    learning_feedback.py       # Learning loop integration
    validation_system.py       # Integration validation
  article-to-prototype/       # Example generated skill
  exports/                    # Export output directory
  docs/                       # Additional documentation
    CHANGELOG.md              # Version history
    NAMING_CONVENTIONS.md     # Naming rules reference
    PIPELINE_ARCHITECTURE.md  # Pipeline internals
    DECISION_LOGIC.md         # Architecture decision logic
    CLAUDE_SKILLS_ARCHITECTURE.md
```

---

## Activation Triggers

The skill creator activates when it detects phrases like:

- "Create an agent for ..."
- "Create a skill for ..."
- "Automate this workflow"
- "Every day I have to ..."
- "I need to automate ..."
- "Create a cross-platform skill for ..."
- "Validate this skill"
- "Export this skill for [platform]"
- "Migrate this skill to v4"

See [references/phase4-detection.md](references/phase4-detection.md) for the full activation pattern reference.

---

## AgentDB Integration (Optional)

Skills can optionally integrate with AgentDB for persistent learning across sessions:

- **Learning feedback**: Skills improve based on usage patterns
- **Cross-session memory**: Retain context between conversations
- **Performance metrics**: Track skill effectiveness over time

AgentDB is not required. Skills work fully without it. See [references/agentdb-integration.md](references/agentdb-integration.md) for setup details.

---

## Migration from v3.x

If you have skills created with v3.x of agent-skill-creator:

**Key changes in v4.0:**
- `-cskill` suffix removed from skill names (use standard kebab-case)
- `marketplace.json` simplified (optional for simple skills)
- SKILL.md body limited to 500 lines (move detail to `references/`)
- `install.sh` cross-platform installer added
- Spec validation and security scanning tools added

**Quick migration:**
```bash
# Rename directory (remove -cskill suffix)
mv my-skill-cskill/ my-skill/

# Update SKILL.md name field
# Validate the migrated skill
python3 scripts/validate.py ./my-skill/
```

For the complete migration guide, see [MIGRATION.md](MIGRATION.md).

---

## Advanced Features

### Interactive Mode

For complex skills, the creator can run in interactive mode, asking clarifying questions before generating:

```
"Create a skill for financial analysis" (interactive)
```

See [references/interactive-mode.md](references/interactive-mode.md).

### Multi-Agent Suites

Create coordinated multi-agent systems where specialized agents collaborate:

```
"Create a multi-agent suite for end-to-end data pipeline"
```

See [references/multi-agent-guide.md](references/multi-agent-guide.md).

### Template-Based Creation

Use pre-built templates to accelerate skill creation:

```
"Create a skill from the data-analysis template"
```

See [references/templates-guide.md](references/templates-guide.md).

---

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Run validation: `python3 scripts/validate.py ./`
5. Run security scan: `python3 scripts/security_scan.py ./`
6. Submit a pull request

---

## License

MIT License. See [LICENSE](LICENSE) for details.

---

## Links

- [Agent Skills Open Standard](https://github.com/anthropics/agent-skills-spec)
- [Migration Guide (v3.x to v4.0)](MIGRATION.md)
- [Changelog](docs/CHANGELOG.md)
- [Architecture Guide](references/architecture-guide.md)
- [Pipeline Phases Reference](references/pipeline-phases.md)
- [Cross-Platform Guide](references/cross-platform-guide.md)
- [Export Guide](references/export-guide.md)
- [Activation Best Practices](references/ACTIVATION_BEST_PRACTICES.md)
