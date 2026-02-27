# Agent Skill Creator

**Create cross-platform agent skills from natural language workflow descriptions.**

[![Agent Skills Open Standard](https://img.shields.io/badge/Agent%20Skills-Open%20Standard-blue)](https://github.com/anthropics/agent-skills-spec)
[![Version](https://img.shields.io/badge/version-4.0.0-brightgreen)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)]()

---

## What Is This?

Agent Skill Creator is a **meta-skill** -- a skill that creates other skills. Install it once, then talk to your agent naturally. Pass in workflow descriptions, documentation, links, existing code, API docs, compliance checklists — whatever you have. The skill creator processes all of it through a structured 5-phase pipeline and produces a complete, validated, security-scanned skill ready for your team to use.

Once installed, type `/agent-skill-creator` followed by whatever you have — a workflow description, a link, existing code, a PDF. The agent builds the skill; the toolchain verifies it.

**Input**: Documentation, links, code, process descriptions — anything that captures the workflow.
**Output**: A ready-to-install skill directory with functional scripts, documentation, cross-platform installer, and spec-compliant SKILL.md — published to a shared catalog your team can browse and install from.

### Built-in Quality Gates

Every skill goes through automated checks before it reaches your team. You don't need to trust the output blindly — the toolchain enforces quality:

| Gate | What It Checks | When It Runs |
|------|---------------|--------------|
| **Spec Validation** | SKILL.md exists, frontmatter is well-formed, name follows kebab-case rules, description under 1024 chars, body under 500 lines | During creation (Phase 5) and on every publish |
| **Security Scan** | No hardcoded API keys, no exposed credentials, no `eval()`/`exec()` injection risks, no sensitive files (.env, secrets.json) | During creation (Phase 5) and on every publish |
| **Naming Convention** | Directory name matches SKILL.md `name` field, no consecutive hyphens, 1-64 characters | During validation |
| **Structure Check** | Required files present, local references resolve, metadata fields populated | During validation |

Skills that fail validation **cannot be published**. Skills with high-severity security issues **are blocked** unless explicitly overridden. This means every skill in the registry has passed both gates — your team can install with confidence.

You can also run these checks independently at any time:

```bash
python3 scripts/validate.py ./my-skill/          # Spec compliance
python3 scripts/security_scan.py ./my-skill/      # Security audit
```

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

**Why you can trust the output:**

The agent-skill-creator doesn't just generate code and hope for the best. Every skill it produces goes through automated validation (spec compliance) and security scanning (credential detection, injection patterns) before it's ready. When you publish to the registry, both checks run again as a gate — skills that fail cannot be published. This means the skills your team installs are structurally sound, security-reviewed, and follow a consistent standard. You describe the workflow; the toolchain handles the quality assurance.

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

### Step 2: Invoke the Skill Creator

Open your agent and type `/agent-skill-creator` followed by whatever you have. The more context you provide, the better the skill:

```
/agent-skill-creator Every week I pull sales data from our CRM, clean
duplicate entries, calculate regional totals, and generate a PDF report.
```

```
/agent-skill-creator Based on our deployment runbook: https://wiki.internal/deploy-process
```

```
/agent-skill-creator See scripts/invoice_processor.py — turn it into a reusable skill
```

```
/agent-skill-creator Here's our API docs: https://api.internal/docs
Create a skill that queries stock levels and generates reorder reports.
```

```
/agent-skill-creator Based on compliance-checklist.pdf, create a SOX audit skill
```

You can pass in plain English descriptions, documentation links, existing code, API docs, PDFs — anything. Combine multiple sources in one message. The agent reads everything and processes it through a structured 5-phase pipeline:

```
DISCOVERY        → Researches the domain, reads your docs/links/code
     |
DESIGN           → Defines use cases, methods, and output formats
     |
ARCHITECTURE     → Plans the skill directory structure
     |
DETECTION        → Crafts activation keywords so the skill triggers reliably
     |
IMPLEMENTATION   → Generates all code, docs, and installer
```

This isn't "prompt and pray." Each phase builds on the previous one, and the agent confirms direction with you along the way. The output is a complete skill directory (e.g., `./sales-report-builder/`) with functional code, documentation, and a spec-compliant SKILL.md.

### Step 3: Automated Quality Gates

Every skill the pipeline produces goes through two automated checks before it's considered ready:

```bash
# Spec compliance — structure, naming, frontmatter, file references
python3 scripts/validate.py ./sales-report-builder/

# Security — no hardcoded keys, no credential exposure, no injection risks
python3 scripts/security_scan.py ./sales-report-builder/
```

These run automatically at the end of Phase 5 (Implementation) and again when you publish to the registry. If validation fails or the security scan finds high-severity issues, the skill is blocked until the issues are fixed. You don't have to review the output manually to trust it — the toolchain does that for you.

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
/agent-skill-creator Create a skill for analyzing CSV files
```

The skill creator activates and walks you through the full pipeline. You can also just describe a workflow naturally — the skill activates on phrases like "create a skill for...", "automate this workflow", etc.

For Windsurf, Cline, Codex CLI, Gemini CLI, and other platforms see [Setup by Platform](#setup-by-platform-complete-guide) below.

---

## Usage

### Invocation

Type `/agent-skill-creator` followed by your input:

```
/agent-skill-creator Create a skill for analyzing stock market data
/agent-skill-creator Every day I process CSV files manually, automate this
/agent-skill-creator https://wiki.internal/weather-api-docs
/agent-skill-creator See scripts/data_pipeline.py — make this a reusable skill
```

The skill also activates on natural language without the prefix:

```
Create a skill for weather alerts
Automate this workflow
Validate this skill
Export this skill for Cursor
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
# Primary invocation
/agent-skill-creator <description, links, code, docs>

# Natural language (also works)
create a skill for [domain]
automate this workflow
every day I [task]
I need to automate [task]
validate this skill
export this skill for [platform]
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
  SKILL.md                      # Meta-skill definition (the product)
  README.md                     # This file
  scripts/
    validate.py                 # Spec compliance validator
    security_scan.py            # Security scanner
    export_utils.py             # Cross-platform export tool
    skill_registry.py           # Shared skill registry CLI
    install-template.sh         # Template for generated install.sh
  references/
    pipeline-phases.md          # Full 5-phase pipeline instructions
    architecture-guide.md       # Simple skill vs. complex suite
    cross-platform-guide.md     # Platform-specific details
    export-guide.md             # Export system documentation
    quality-standards.md        # Quality and code standards
    templates-guide.md          # Template system guide
    interactive-mode.md         # Interactive wizard docs
    multi-agent-guide.md        # Suite creation docs
    agentdb-integration.md      # Optional learning system
    phase1-discovery.md         # Phase 1 deep dive
    phase2-design.md            # Phase 2 deep dive
    phase3-architecture.md      # Phase 3 deep dive
    phase4-detection.md         # Phase 4 deep dive
    phase5-implementation.md    # Phase 5 deep dive
    templates/                  # Skill templates
    examples/stock-analyzer/    # Example skill
  registry/                     # Shared skill catalog (git-tracked)
    registry.json               # Skill manifest
    skills/                     # Published skill directories
  exports/                      # Export output directory
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
- [Architecture Guide](references/architecture-guide.md)
- [Pipeline Phases Reference](references/pipeline-phases.md)
- [Cross-Platform Guide](references/cross-platform-guide.md)
- [Export Guide](references/export-guide.md)
