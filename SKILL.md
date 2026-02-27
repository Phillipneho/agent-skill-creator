---
name: agent-skill-creator
description: >-
  Create cross-platform agent skills from workflow descriptions. Activates when
  users ask to create an agent, automate a repetitive workflow, create a custom
  skill, or need advanced agent creation. Triggers on phrases like create agent
  for, automate workflow, create skill for, every day I have to, daily I need to,
  turn process into agent, need to automate, create a cross-platform skill,
  validate this skill, export this skill, migrate this skill. Supports single
  skills, multi-agent suites, transcript processing, template-based creation,
  interactive configuration, cross-platform export, and spec validation.
license: MIT
metadata:
  author: Francy Lisboa Charuto
  version: 4.0.0
compatibility: >-
  Works on all platforms supporting the Agent Skills Open Standard (SKILL.md):
  Claude Code, GitHub Copilot CLI, VS Code Copilot, Cursor, Windsurf, Cline,
  OpenAI Codex CLI, Gemini CLI, and 20+ others.
---
# /agent-skill-creator — Create Agent Skills from Anything

You are an expert skill builder. Your job is to take whatever the user provides — workflow descriptions, documentation, links, code, PDFs, API docs — and autonomously create a production-ready, cross-platform agent skill through a structured 5-phase pipeline. The user provides sources, you build the skill.

## Trigger

User invokes `/agent-skill-creator` followed by their input:

```
/agent-skill-creator Every week I pull sales data, clean it, and generate a report
/agent-skill-creator https://wiki.internal/deploy-runbook
/agent-skill-creator See scripts/invoice_processor.py — turn it into a reusable skill
/agent-skill-creator Here's our API docs: https://api.internal/docs — make a skill for querying inventory
/agent-skill-creator Based on compliance-checklist.pdf, create a skill for SOX audits
```

The user can also activate naturally without the prefix:

```
Create a skill for analyzing CSV files
Every day I process invoices manually, automate this
Automate this workflow
Validate this skill
Export this skill for Cursor
```

## Overview

This skill guides the agent through a **5-phase autonomous pipeline** to create complete, validated, cross-platform agent skills:

```
Phase 1: DISCOVERY    -> Research APIs, data sources, tools
Phase 2: DESIGN       -> Define use cases, analyses, methodologies
Phase 3: ARCHITECTURE -> Structure skill directory (standard-compliant)
Phase 4: DETECTION    -> Generate description + keywords for activation
Phase 5: IMPLEMENTATION -> Create all files, validate, security scan
```

**Output**: A complete skill directory ready to install on any platform:

```
skill-name/
├── SKILL.md          # <500 lines, spec-compliant frontmatter
├── scripts/          # Functional Python code
├── references/       # Detailed documentation (loaded on demand)
├── assets/           # Templates, schemas, data files
├── install.sh        # Cross-platform auto-detect installer
└── README.md         # Multi-platform installation instructions
```

## Core Workflow

### Phase 1: Discovery

Research available APIs and data sources for the user's domain. Compare options by cost, rate limits, data quality, and documentation. **Decide** which API to use with justification.

See `references/pipeline-phases.md` for detailed Phase 1 instructions.

### Phase 2: Design

Define 4-6 priority analyses covering 80% of use cases. For each: name, objective, inputs, outputs, methodology. Always include a comprehensive report function.

See `references/pipeline-phases.md` for detailed Phase 2 instructions.

### Phase 3: Architecture

Structure the skill using the Agent Skills Open Standard:

- **Simple Skill**: Single SKILL.md + scripts + references + assets
- **Complex Suite**: Multiple component skills with shared resources

**Decision criteria**: Number of workflows, code complexity, maintenance needs.

See `references/architecture-guide.md` for decision logic and directory structures.

### Phase 4: Detection

Generate a description (<=1024 chars) with domain keywords for agent discovery. The description is the primary activation mechanism across all platforms.

See `references/pipeline-phases.md` for detailed Phase 4 instructions.

### Phase 5: Implementation

Create all files in this order:

1. Create directory structure
2. Write **SKILL.md** with spec-compliant frontmatter (primary file)
3. Implement Python scripts (functional, no placeholders)
4. Write references (detailed documentation)
5. Write assets (templates, configs)
6. Generate `install.sh` (cross-platform installer)
7. Write `README.md` (multi-platform install instructions)
8. Run **validation** against the official spec
9. Run **security scan** for hardcoded keys and injection patterns
10. Report results to user

See `references/pipeline-phases.md` for detailed Phase 5 instructions.

### Generated SKILL.md Format

Every generated skill's SKILL.md must have:

```yaml
---
name: skill-name            # 1-64 chars, lowercase + hyphens, matches directory
description: >-             # 1-1024 chars, activation keywords
  Description here...
license: MIT                # or appropriate license
metadata:
  author: Author Name
  version: 1.0.0
---
```

Body must be <500 lines. Move detailed content to `references/`.

## Architecture Decision

| Factor | Simple Skill | Complex Suite |
|--------|-------------|---------------|
| Workflows | 1-2 | 3+ distinct |
| Code size | <1000 lines | >2000 lines |
| Maintenance | Single developer | Team |
| Structure | Single SKILL.md | Multiple component SKILL.md files |
| marketplace.json | Not needed | Optional (official fields only) |

See `references/architecture-guide.md` for detailed decision framework.

## Cross-Platform Support

Generated skills work on all platforms supporting the SKILL.md standard:

| Platform | Install Location | Command |
|----------|-----------------|---------|
| Claude Code | `~/.claude/skills/` or `.claude/skills/` | `./install.sh` or copy |
| GitHub Copilot | `.github/skills/` | `./install.sh --platform copilot` |
| Cursor | `.cursor/rules/` | `./install.sh --platform cursor` |
| Windsurf | `.windsurf/skills/` | `./install.sh --platform windsurf` |
| Cline | `.clinerules/` | `./install.sh --platform cline` |
| Codex CLI | `.codex/skills/` | `./install.sh --platform codex` |
| Gemini CLI | `.gemini/skills/` | `./install.sh --platform gemini` |

See `references/cross-platform-guide.md` for full platform details.

## Validation and Security

After generating a skill, run:

- **Spec validation**: Checks frontmatter, naming, structure, line count
- **Security scan**: Checks for hardcoded API keys, .env files, injection patterns

```bash
# Validate a skill
python3 scripts/validate.py path/to/skill/

# Security scan
python3 scripts/security_scan.py path/to/skill/
```

## Export System

Package skills for distribution:

```bash
# Export for all platforms
python3 scripts/export_utils.py path/to/skill/

# Desktop/Web package only
python3 scripts/export_utils.py path/to/skill/ --variant desktop

# API package only
python3 scripts/export_utils.py path/to/skill/ --variant api
```

See `references/export-guide.md` for full export documentation.

## Template-Based Creation

Pre-built templates for common domains:

- **Financial Analysis**: Alpha Vantage/Yahoo Finance, fundamental + technical analysis
- **Climate Analysis**: Open-Meteo/NOAA, anomalies + trends + seasonal patterns
- **E-commerce Analytics**: Google Analytics/Stripe/Shopify, traffic + revenue + cohorts

See `references/templates-guide.md` for template details and customization.

## Multi-Agent Suites

Create multiple related agents in one operation:

```
"Create a financial analysis suite with 4 agents:
fundamental, technical, portfolio, and risk assessment"
```

See `references/multi-agent-guide.md` for suite creation docs.

## Interactive Configuration

Step-by-step wizard for complex projects:

```
"Help me create an agent with interactive options"
"Walk me through creating a financial analysis system"
```

See `references/interactive-mode.md` for wizard documentation.

## AgentDB Integration

Optional learning system that gets smarter over time:

- Stores creation episodes for pattern learning
- Progressively improves API selection, architecture, and keywords
- Works identically with or without AgentDB available

See `references/agentdb-integration.md` for integration details.

## Quality Standards

**Always**:
- Complete, functional code (no TODOs, no `pass`)
- Detailed docstrings and type hints
- Robust error handling
- Real content in references (not "see docs")
- Configs with real values

**Never**:
- Placeholder code or empty functions
- `api_key: YOUR_KEY_HERE` without env var instructions
- SKILL.md over 500 lines
- Platform-specific hacks

See `references/quality-standards.md` for complete standards.

## Naming Convention

Skills use standard kebab-case naming per the Agent Skills Open Standard:

- 1-64 characters, lowercase letters, numbers, and hyphens
- Must match parent directory name
- Must not start or end with hyphen
- Must not contain consecutive hyphens

Examples: `stock-analyzer`, `csv-data-cleaner`, `weekly-report-generator`

## Reference Files

| File | Contents |
|------|----------|
| `references/pipeline-phases.md` | Detailed Phase 1-5 instructions |
| `references/architecture-guide.md` | Simple vs Suite decision logic |
| `references/templates-guide.md` | Template-based creation |
| `references/interactive-mode.md` | Interactive wizard docs |
| `references/multi-agent-guide.md` | Batch/suite creation |
| `references/agentdb-integration.md` | AgentDB learning system |
| `references/cross-platform-guide.md` | Platform compatibility matrix |
| `references/export-guide.md` | Cross-platform export system |
| `references/quality-standards.md` | Quality and code standards |
| `references/phase1-discovery.md` | Phase 1 deep-dive |
| `references/phase2-design.md` | Phase 2 deep-dive |
| `references/phase3-architecture.md` | Phase 3 deep-dive |
| `references/phase4-detection.md` | Phase 4 deep-dive |
