# Agent Skill Creator

**Create cross-platform agent skills from natural language workflow descriptions.**

[![Agent Skills Open Standard](https://img.shields.io/badge/Agent%20Skills-Open%20Standard-blue)](https://github.com/anthropics/agent-skills-spec)
[![Version](https://img.shields.io/badge/version-4.0.0-brightgreen)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)]()

---

## What Is This?

Agent Skill Creator is a **meta-skill** -- a skill that creates other skills. Describe a repetitive workflow in plain English and it generates a complete, validated, cross-platform agent skill through an autonomous 5-phase pipeline. Then publish it to the built-in registry so your entire team can install and use it.

**Input**: *"Every day I download stock data, analyze trends, and create reports"*
**Output**: A ready-to-install skill directory with functional scripts, documentation, cross-platform installer, and spec-compliant SKILL.md — published to a shared catalog your team can browse and install from.

---

## Why Agent Skills Matter

AI agents (Claude Code, GitHub Copilot, Cursor, Windsurf, Codex, Gemini) are becoming the primary interface for knowledge work. But out of the box, every agent starts from zero — it doesn't know your company's processes, data sources, naming conventions, or compliance requirements.

**Agent skills solve this.** A skill is structured domain knowledge that an agent loads automatically. Instead of re-explaining your workflow every conversation, the agent already knows how to do it.

**The corporate opportunity:**

- **Without skills**: Every person prompts the agent differently. Knowledge stays in individual chat histories. New hires start from scratch. The same workflow gets re-explained hundreds of times.
- **With skills**: Someone describes a workflow once. The agent-skill-creator turns it into a reusable skill. It gets published to the team registry. Now every agent on the team — regardless of platform — knows how to do that workflow. Knowledge compounds instead of evaporating.

**What changes in practice:**

1. **Operations teams** describe their runbooks. Skills get created. Now agents can execute standard procedures consistently.
2. **Data teams** describe their analysis pipelines. Skills get created. Now any team member can run the same analysis by asking their agent.
3. **Finance teams** describe their reporting workflows. Skills get created. Now quarterly reports follow the same methodology every time.
4. **Engineering teams** describe their deployment processes, code review standards, testing protocols. Skills get created. Now agents enforce consistency across the organization.

The pattern is always the same: **capture tacit knowledge as skills, share them through the registry, and let agents scale that knowledge across the team.**

This repo is the complete toolkit: create skills from natural language, validate them against the open standard, security-scan them, and share them through a git-based registry that gives you version history, access control, and review workflows for free.

---

## End-to-End Walkthrough

This is the full lifecycle from idea to team-wide adoption.

### Step 1: Install the Skill Creator

Clone this repo into your agent's skill directory:

```bash
# Claude Code
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git ~/.claude/skills/agent-skill-creator

# Cursor
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .cursor/rules/agent-skill-creator

# Any other supported platform — see "Setup by Platform" below
```

### Step 2: Describe a Workflow

Open your agent and describe a repetitive task in plain English:

```
"Every week I pull sales data from our CRM, clean duplicate entries,
calculate regional totals, and generate a PDF report for leadership."
```

The skill creator activates automatically and walks you through its 5-phase pipeline:

```
DISCOVERY        → Researches CRM APIs, data cleaning techniques, PDF generation
     |
DESIGN           → Defines use cases: data pull, dedup, aggregation, report
     |
ARCHITECTURE     → Plans the skill directory structure
     |
DETECTION        → Crafts activation keywords so the skill triggers reliably
     |
IMPLEMENTATION   → Generates all code, docs, and installer
```

Output: a complete skill directory (e.g., `./sales-report-builder/`) ready to use.

### Step 3: Validate and Scan

Before sharing, verify the skill meets the open standard and has no security issues:

```bash
python3 scripts/validate.py ./sales-report-builder/
python3 scripts/security_scan.py ./sales-report-builder/
```

Both checks run automatically during publishing (Step 4), but you can run them manually anytime.

### Step 4: Publish to the Team Registry

The registry lives inside this repo at `registry/`. Publishing copies the skill into the shared catalog:

```bash
python3 scripts/skill_registry.py publish ./sales-report-builder/ --tags sales,reports,crm
```

This validates the skill, runs the security scan, copies the files into `registry/skills/sales-report-builder/`, and updates `registry/registry.json`.

Then commit and push so the team can access it:

```bash
git add registry/
git commit -m "feat: Add sales-report-builder skill"
git push
```

### Step 5: Team Discovers and Installs Skills

Colleagues pull the latest and browse the catalog:

```bash
git pull

# What skills are available?
python3 scripts/skill_registry.py list

# Output:
# NAME                  VERSION  AUTHOR       TAGS
# sales-report-builder  1.0.0    sales-team   sales, reports, crm
# data-quality-checker  1.0.0    data-team    data, validation
# deploy-checklist      2.0.0    engineering  deploy, ci, checklist

# Search for something specific
python3 scripts/skill_registry.py search "sales"

# Get full details
python3 scripts/skill_registry.py info sales-report-builder

# Install it (auto-detects your platform)
python3 scripts/skill_registry.py install sales-report-builder
```

### Step 6: Use the Skill

After installing, the skill activates automatically. The colleague just opens their agent and says:

```
"Generate the weekly sales report for the West region"
```

The agent recognizes this matches the sales-report-builder skill and executes the workflow — pulling data, cleaning it, calculating totals, and generating the PDF. Same process, same quality, every time.

### Step 7: Iterate

Skills improve over time. Someone adds error handling for API timeouts. Another person adds a new region. They publish updates to the registry, the team pulls, and everyone benefits.

```bash
# Update and re-publish
python3 scripts/skill_registry.py publish ./sales-report-builder/ --force
git add registry/ && git commit -m "fix: Handle CRM API timeouts" && git push
```

### The Result

Over weeks and months, the registry grows organically. Each team contributes skills from their domain. The organization builds a **living library of operational knowledge** that every agent can access — regardless of which platform (Claude Code, Cursor, Copilot, etc.) each person uses.

```bash
python3 scripts/skill_registry.py list

# NAME                    VERSION  AUTHOR        TAGS
# sales-report-builder    1.2.0    sales-team    sales, reports, crm
# data-quality-checker    1.0.0    data-team     data, validation
# deploy-checklist        2.1.0    engineering   deploy, ci, checklist
# quarterly-compliance    1.0.0    legal-team    compliance, audit
# customer-churn-model    3.0.0    data-science  ml, churn, prediction
# incident-runbook        1.1.0    sre-team      incidents, on-call
# onboarding-guide        1.0.0    hr-team       onboarding, new-hire
```

This is the shift: from individual prompting to organizational capability.

---

## Quick Start

### Claude Code

```bash
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git ~/.claude/skills/agent-skill-creator
```

### GitHub Copilot

```bash
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .github/skills/agent-skill-creator
```

### Cursor

```bash
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .cursor/rules/agent-skill-creator
```

After installing, open your agent and type:

```
Create a skill for analyzing CSV files
```

The skill creator activates and walks you through the full pipeline.

For Windsurf, Cline, Codex CLI, Gemini CLI, and other platforms see [Setup by Platform](#setup-by-platform-complete-guide) below.

---

## Usage

### Trigger Phrases

Say any of these to your agent:

```
"Create a skill for analyzing stock market data"
"Every day I process CSV files manually, automate this"
"Create a cross-platform skill for weather alerts"
"Automate this workflow"
"I need to automate [repetitive task]"
"Validate this skill"
"Export this skill for Cursor and Copilot"
"Migrate this skill to v4"
```

### What Happens

The creator runs a **5-phase autonomous pipeline**:

```
Phase 1: DISCOVERY        Research APIs, data sources, and domain knowledge
          |
Phase 2: DESIGN           Define use cases, methodologies, and outputs
          |
Phase 3: ARCHITECTURE     Structure skill directory (simple vs. complex suite)
          |
Phase 4: DETECTION        Generate description + keywords for reliable activation
          |
Phase 5: IMPLEMENTATION   Create all files, run validation, run security scan
```

Output: a complete skill directory you can install on any supported platform.

---

## Setup by Platform (Complete Guide)

Each platform installs with a single `git clone` directly into the right location. Replace `agent-skill-creator` with the skill name when installing generated skills.

### Claude Code

```bash
# Personal skill (available in all projects)
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git ~/.claude/skills/agent-skill-creator

# Per-project (scoped to one repo)
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .claude/skills/agent-skill-creator
```

### GitHub Copilot (CLI + VS Code)

```bash
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .github/skills/agent-skill-creator
```

### Cursor

```bash
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .cursor/rules/agent-skill-creator
```

Cursor reads SKILL.md natively alongside its `.mdc` rules.

### Windsurf

```bash
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .windsurf/skills/agent-skill-creator
```

### Cline

```bash
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .clinerules/agent-skill-creator
```

### OpenAI Codex CLI

```bash
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .codex/skills/agent-skill-creator
```

### Gemini CLI

```bash
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .gemini/skills/agent-skill-creator
```

### Claude Desktop / claude.ai (Export)

These platforms use `.zip` upload instead of directory copying:

1. Export: `python3 scripts/export_utils.py ./agent-skill-creator/ --variant desktop`
2. Open Claude Desktop or claude.ai
3. Go to Settings > Skills > Upload skill
4. Select the generated `.zip` file

### Claude API (Programmatic)

```bash
python3 scripts/export_utils.py ./agent-skill-creator/ --variant api
```

```python
import anthropic

client = anthropic.Anthropic()

with open("agent-skill-creator-api-v4.0.0.zip", "rb") as f:
    skill = client.skills.create(file=f, name="agent-skill-creator")

response = client.messages.create(
    model="claude-sonnet-4",
    messages=[{"role": "user", "content": "Your query here"}],
    container={"type": "custom_skill", "skill_id": skill.id},
    betas=["code-execution-2025-08-25", "skills-2025-10-02"],
)
```

Note: API sandbox has no network access, no pip install at runtime, and an 8 MB size limit.

### Updating

To update an installed skill, just `git pull` from inside the skill directory:

```bash
cd ~/.claude/skills/agent-skill-creator && git pull
```

---

## How It Works

| Phase | What Happens | Key Output |
|-------|-------------|------------|
| **Discovery** | Researches the domain, identifies APIs and data sources | Domain model, API list |
| **Design** | Defines use cases, analysis methods, output formats | Use case specs, methodology docs |
| **Architecture** | Decides simple skill vs. complex suite, plans directory structure | Architecture decision, file plan |
| **Detection** | Crafts SKILL.md description and activation keywords | SKILL.md frontmatter, trigger phrases |
| **Implementation** | Generates all code, docs, installer; validates and scans | Complete skill directory |

For full pipeline documentation, see [references/pipeline-phases.md](references/pipeline-phases.md).

---

## Generated Skill Format

Every generated skill follows the Agent Skills Open Standard:

```
skill-name/
  SKILL.md              # Main skill file (<500 lines, spec-compliant)
  scripts/              # Functional Python code
  references/           # Detailed documentation (progressive disclosure)
  assets/               # Templates, schemas, config files
  install.sh            # Cross-platform installer
  README.md             # Multi-platform install instructions
```

### SKILL.md Frontmatter

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

**Naming rules**: `kebab-case`, 1-64 characters, pattern `^[a-z][a-z0-9-]*[a-z0-9]$`, must match directory name.

---

## Tools

### Validate a Skill

Check spec compliance against the Agent Skills Open Standard:

```bash
python3 scripts/validate.py ./my-skill/

# JSON output (for CI/CD)
python3 scripts/validate.py ./my-skill/ --json
```

**Checks**: SKILL.md existence, valid frontmatter, kebab-case name (1-64 chars), description under 1024 chars, body under 500 lines, required directory structure, install.sh exists and is executable.

**Exit codes**: `0` = valid (may have warnings), `1` = invalid (errors found).

### Security Scan

Scan for common security issues before sharing or deploying:

```bash
python3 scripts/security_scan.py ./my-skill/

# JSON output
python3 scripts/security_scan.py ./my-skill/ --json
```

**Detects**: hardcoded API keys (OpenAI, AWS, GitHub, GitLab), tokens and secrets, command injection patterns, unsafe file operations, credential exposure in config files.

**Exit codes**: `0` = clean, `1` = issues found.

### Export for Other Platforms

Package skills for distribution:

```bash
# Desktop/Web (.zip for Claude Desktop, claude.ai)
python3 scripts/export_utils.py ./my-skill/ --variant desktop

# API (.zip for Claude API, <=8MB)
python3 scripts/export_utils.py ./my-skill/ --variant api

# All variants
python3 scripts/export_utils.py ./my-skill/
```

Output goes to `exports/`. See [references/export-guide.md](references/export-guide.md) for full documentation.

### Skill Registry

Share and discover skills across your team. The registry lives inside this repo (`registry/`) so one `git pull` gives everyone access to all published skills.

**First-time setup** (once per organization):

```bash
python3 scripts/skill_registry.py init --name "Acme Corp Skills"
```

**Typical workflow:**

```bash
# Someone describes a workflow, the agent creates a skill
# "Every week I pull sales data, clean it, and make a report"
# → agent creates ./sales-report-builder/

# Publish it so the team can use it
python3 scripts/skill_registry.py publish ./sales-report-builder/ --tags sales,reports

# Browse what the team has built
python3 scripts/skill_registry.py list
python3 scripts/skill_registry.py search "sales"

# Get details about a skill
python3 scripts/skill_registry.py info sales-report-builder

# Install a skill to your platform (auto-detects Claude Code, Cursor, etc.)
python3 scripts/skill_registry.py install sales-report-builder

# Install for a specific platform or at project level
python3 scripts/skill_registry.py install sales-report-builder --platform cursor --project

# Remove a skill from the registry
python3 scripts/skill_registry.py remove sales-report-builder --force
```

After publishing, commit and push so colleagues can `git pull` and install the new skill.

All commands support `--json` for machine-readable output. Use `--force` to overwrite duplicates or bypass confirmation prompts.

**Exit codes**: `0` = success, `1` = error.

---

## Architecture Decisions

The creator automatically decides simple vs. complex based on scope:

| Factor | Simple Skill | Complex Suite |
|--------|-------------|---------------|
| Workflows | 1-2 | 3+ distinct |
| Code size | <1000 lines | >2000 lines |
| Structure | Single SKILL.md | Multiple component SKILL.md files |

For detailed decision logic, see [references/architecture-guide.md](references/architecture-guide.md).

---

## For AI Agents (Machine-Readable Reference)

This section provides structured metadata for AI agents ingesting this README as context.

### Activation Triggers

```
create an agent for [objective]
create a skill for [domain]
develop a custom skill
automate this workflow
every day I [task]
I repeatedly need to [process]
I need to automate [task]
create a cross-platform skill for [objective]
validate this skill
check if this skill is spec-compliant
export this skill for [platform]
package this skill for [platform]
migrate this skill to v4
update this skill to the new standard
create a multi-agent suite for [objective]
create a skill from the [name] template
```

### Install Commands

```bash
# Claude Code (personal)
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git ~/.claude/skills/agent-skill-creator
# GitHub Copilot
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .github/skills/agent-skill-creator
# Cursor
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .cursor/rules/agent-skill-creator
# Windsurf
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .windsurf/skills/agent-skill-creator
# Cline
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .clinerules/agent-skill-creator
# Codex CLI
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .codex/skills/agent-skill-creator
# Gemini CLI
git clone https://github.com/FrancyJGLisboa/agent-skill-creator.git .gemini/skills/agent-skill-creator
# Update
cd <install-path>/agent-skill-creator && git pull
```

### Tool Commands

```bash
# Validate
python3 scripts/validate.py PATH      # Human output
python3 scripts/validate.py PATH --json  # Machine output

# Security scan
python3 scripts/security_scan.py PATH
python3 scripts/security_scan.py PATH --json

# Export
python3 scripts/export_utils.py PATH --variant desktop
python3 scripts/export_utils.py PATH --variant api

# Registry (default --registry ./registry)
python3 scripts/skill_registry.py init --name "Team Name"
python3 scripts/skill_registry.py publish SKILL_PATH --tags T1,T2
python3 scripts/skill_registry.py list [--json]
python3 scripts/skill_registry.py search QUERY [--json]
python3 scripts/skill_registry.py install SKILL_NAME [--platform PLATFORM] [--project]
python3 scripts/skill_registry.py info SKILL_NAME [--json]
python3 scripts/skill_registry.py remove SKILL_NAME --force
```

### Platform Paths

| Platform | Path | Scope |
|----------|------|-------|
| Claude Code | `~/.claude/skills/` | User-level |
| Claude Code | `.claude/skills/` | Project-level |
| GitHub Copilot | `.github/skills/` | Project-level |
| Cursor | `.cursor/rules/` | Workspace |
| Windsurf | `.windsurf/skills/` | Workspace |
| Cline | `.clinerules/` | Workspace |
| Codex CLI | `.codex/skills/` | Workspace |
| Gemini CLI | `.gemini/skills/` | Workspace |
| Claude Desktop | `.zip` upload | App-level |
| claude.ai | `.zip` upload | Web |
| Claude API | `.zip` via API | Programmatic |

### SKILL.md Spec (Required Fields)

```yaml
---
name: kebab-case-name          # 1-64 chars, ^[a-z][a-z0-9-]*[a-z0-9]$
description: >-                # 1-1024 chars, include activation keywords
  What this skill does...
license: MIT
metadata:
  author: Author Name
  version: X.Y.Z
---
# Body: <500 lines. Move detailed content to references/.
```

### Pipeline Phases

```
DISCOVERY -> DESIGN -> ARCHITECTURE -> DETECTION -> IMPLEMENTATION
```

Each phase is documented in `references/phase{1..5}-*.md`.

---

## Migration from v3.x

Key changes in v4.0:

- `-cskill` suffix removed from skill names (use standard kebab-case)
- SKILL.md body limited to 500 lines (move detail to `references/`)
- `install.sh` cross-platform installer added
- Spec validation and security scanning tools added
- `marketplace.json` simplified (optional for simple skills)

Quick migration:

```bash
mv my-skill-cskill/ my-skill/
# Update SKILL.md name field to remove -cskill suffix
python3 scripts/validate.py ./my-skill/
```

For the complete migration guide, see [MIGRATION.md](MIGRATION.md).

---

## Troubleshooting

**Skill not activating**: Ensure SKILL.md `description` field contains the trigger phrases you expect. The description is the primary activation mechanism.

**Validation fails on name**: Names must be kebab-case, 1-64 characters, no consecutive hyphens, no leading/trailing hyphens. Pattern: `^[a-z][a-z0-9-]*[a-z0-9]$`.

**SKILL.md too long**: Body must be under 500 lines. Move detailed documentation to `references/` and link from the main SKILL.md.

**Export fails with size error**: API exports have an 8 MB limit. Reduce asset sizes or exclude large files.

**install.sh not executable**: Run `chmod +x install.sh` before executing.

**Platform not auto-detected**: Use `./install.sh --platform <name>` to specify explicitly.

---

## Project Structure

```
agent-skill-creator/
  SKILL.md                      # Meta-skill definition
  README.md                     # This file
  MIGRATION.md                  # v3.x to v4.0 migration guide
  scripts/
    validate.py                 # Spec compliance validator
    security_scan.py            # Security scanner
    export_utils.py             # Cross-platform export tool
    skill_registry.py           # Git-based shared skill registry
    install-template.sh         # Template for generated install.sh
  references/
    pipeline-phases.md          # Full 5-phase pipeline docs
    architecture-guide.md       # Simple skill vs. complex suite
    cross-platform-guide.md     # Platform-specific details
    export-guide.md             # Export system documentation
    phase1-discovery.md         # Phase 1 deep dive
    phase2-design.md            # Phase 2 deep dive
    phase3-architecture.md      # Phase 3 deep dive
    phase4-detection.md         # Phase 4 deep dive
    phase5-implementation.md    # Phase 5 deep dive
    phase6-testing.md           # Testing guide
    quality-standards.md        # Quality standards reference
    templates-guide.md          # Template system guide
    templates/                  # Skill templates
    tools/                      # Validation and scanning tools
    examples/                   # Example configurations
  registry/                      # Shared skill catalog (git-tracked)
    registry.json               # Skill manifest
    skills/                     # Published skill directories
  integrations/
    agentdb_bridge.py           # AgentDB integration bridge
    fallback_system.py          # Graceful degradation system
    learning_feedback.py        # Learning loop integration
    validation_system.py        # Integration validation
  article-to-prototype/         # Example generated skill
  exports/                      # Export output directory
  docs/
    CHANGELOG.md                # Version history
    NAMING_CONVENTIONS.md       # Naming rules reference
    PIPELINE_ARCHITECTURE.md    # Pipeline internals
    DECISION_LOGIC.md           # Architecture decision logic
```

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

MIT License.

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
