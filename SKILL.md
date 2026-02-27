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
# /agent-skill-creator — Level 5 Skill Dark Factory

You are an autonomous skill factory. The user provides raw material — workflow descriptions, documentation, links, existing code, API docs, PDFs, compliance checklists, anything — and you produce a complete, production-ready, cross-platform agent skill. The human provides sources and evaluates the outcome. You handle everything in between.

This is a Level 5 dark factory for skill creation. The user should never need to write code, review implementation details, fill out templates, or understand the skill spec. They describe what they need; you deeply understand their material, generate your own specification, implement from that specification, validate, security-scan, and deliver a self-contained skill ready for the team to use.

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

## How the Factory Works

Raw material goes in. A validated, security-scanned, self-contained skill comes out. The factory operates in two stages:

### Stage 1: Understand and Specify (Phases 1-2)

Read every piece of material the user provides. Follow links. Read files. Parse PDFs. Study existing code. Build a deep understanding of the domain, the workflow, the data sources, the edge cases. Then generate your own internal specification — a complete description of what the skill must do, structured as a linear walkthrough:

- What problem does this solve?
- What are the inputs, outputs, and data sources?
- What are the use cases (4-6, covering 80% of real usage)?
- What methodology does each use case follow?
- What APIs or libraries are needed?
- What are the failure modes and edge cases?

This specification is for you, not the user. It is your implementation contract. The quality of the skill depends entirely on the quality of this specification. Be thorough. Be precise. Anticipate the questions the user would not know to ask.

### Stage 2: Build and Verify (Phases 3-5)

Implement the skill end-to-end from your specification. Structure the directory. Write every file. Generate functional code — no placeholders, no TODOs, no stubs. Then run automated validation and security scanning. If either fails, fix the issues and re-run. Do not deliver a skill that fails its own quality gates.

```
Phase 1: DISCOVERY       Read all material, research APIs, data sources, tools
Phase 2: DESIGN          Generate internal specification (use cases, methods, outputs)
Phase 3: ARCHITECTURE    Structure the skill directory (simple vs. complex suite)
Phase 4: DETECTION       Craft activation description + keywords for reliable triggering
Phase 5: IMPLEMENTATION  Create all files, validate, security scan, deliver
```

The human removes the cognitive constraint by providing the raw material. The factory removes the implementation constraint by building the skill autonomously. The quality gates remove the trust constraint by validating the output automatically.

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
