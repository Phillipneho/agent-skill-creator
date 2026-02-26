# Architecture Decision Guide

**Version:** 4.0
**Purpose:** Comprehensive guide for choosing the right architecture when creating agent skills, including directory structures, naming conventions, sizing patterns, and performance strategies.

---

## 1. Architecture Decision Framework

Before creating any skill, determine whether it should be a **Simple Skill** or a **Complex Suite**. This decision drives the entire directory structure, file organization, and whether a `marketplace.json` is needed.

### 1.1 Decision Criteria

| Factor | Simple Skill | Complex Suite |
|--------|-------------|---------------|
| **Number of workflows** | 1-2 related workflows | 3+ distinct workflows |
| **Code complexity** | <1000 lines total | >2000 lines total |
| **SKILL.md files** | 1 | Multiple (one per component) |
| **Maintenance scope** | Single developer | Team or multi-concern |
| **Domain breadth** | Single domain focus | Spans multiple sub-domains |
| **Deployment** | Install as one unit | Components may be used independently |
| **marketplace.json** | **Not needed** | Optional (official fields only) |

### 1.2 Decision Flowchart

Follow this logic sequentially:

```
START
  |
  v
How many distinct workflows does this skill address?
  |
  +-- 1-2 workflows --> Does the total code exceed 2000 lines?
  |                       |
  |                       +-- No  --> SIMPLE SKILL
  |                       +-- Yes --> Can it be split into independent sub-skills?
  |                                     |
  |                                     +-- No  --> SIMPLE SKILL (large)
  |                                     +-- Yes --> COMPLEX SUITE
  |
  +-- 3+ workflows --> Are the workflows tightly coupled?
                        |
                        +-- Yes (shared state/data) --> SIMPLE SKILL (organized)
                        +-- No  (independent concerns) --> COMPLEX SUITE
```

### 1.3 Decision Examples

| User Request | Decision | Rationale |
|-------------|----------|-----------|
| "Analyze stock prices with technical indicators" | Simple Skill | Single domain, 1-2 workflows (fetch + analyze) |
| "Format markdown tables" | Simple Skill | Single workflow, <500 lines |
| "Full-stack web dev with frontend, backend, deployment" | Complex Suite | 3 independent sub-domains |
| "USDA agriculture data with 6 analysis types" | Simple Skill (organized) | Multiple analyses but single domain, shared data pipeline |
| "Financial suite: stock analysis, portfolio tracking, tax reporting" | Complex Suite | 3 distinct workflows, each usable independently |

---

## 2. Simple Skill Structure

A Simple Skill is a single, self-contained agent skill that follows the Agent Skills Open Standard. It has one SKILL.md file and no `marketplace.json`.

### 2.1 Standard Directory Layout

```
skill-name/
├── SKILL.md          # <500 lines, spec-compliant frontmatter
├── scripts/          # Functional Python code
├── references/       # Detailed documentation (loaded on demand)
├── assets/           # Templates, schemas, data files
├── install.sh        # Cross-platform auto-detect installer
└── README.md         # Multi-platform installation instructions
```

**Key rule:** NO `.claude-plugin/marketplace.json` for simple skills. The SKILL.md file is the sole manifest and activation mechanism.

### 2.2 SKILL.md Frontmatter (Required)

```yaml
---
name: skill-name            # 1-64 chars, lowercase + hyphens, must match directory
description: >-             # 1-1024 chars, activation keywords included
  Description with domain keywords for agent discovery...
license: MIT                # or appropriate license
metadata:
  author: Author Name
  version: 1.0.0
compatibility: >-           # optional, use when platform-specific features exist
  Works on all platforms supporting the SKILL.md standard.
---
```

### 2.3 File Responsibilities

| File/Directory | Purpose | Required? |
|---------------|---------|-----------|
| `SKILL.md` | Primary skill definition, frontmatter, instructions | Yes |
| `scripts/` | Executable Python code (functional, no placeholders) | Yes (if skill has code) |
| `references/` | Detailed documentation, API guides, methodology docs | Recommended |
| `assets/` | Configuration files, templates, schemas, static data | Optional |
| `install.sh` | Cross-platform installer script | Yes |
| `README.md` | Installation instructions for 5+ platforms | Yes |

### 2.4 Why No marketplace.json for Simple Skills

Per the Agent Skills Open Standard and FR-005:

- SKILL.md is the universal discovery mechanism across all 26+ platforms
- `marketplace.json` is a Claude Code-specific plugin manifest, not part of the standard
- Simple skills activate via their SKILL.md `description` field alone
- Adding `marketplace.json` to a simple skill creates a non-standard structure that may confuse other platforms
- Skills placed in `~/.claude/skills/` or `.claude/skills/` are discovered automatically by Claude Code without `marketplace.json`

---

## 3. Complex Suite Structure

A Complex Suite bundles multiple related but independently usable skills under a single parent directory. It optionally includes a `marketplace.json` for Claude Code plugin registration.

### 3.1 Standard Directory Layout

```
suite-name/
├── .claude-plugin/
│   └── marketplace.json    # ONLY official fields (see below)
├── component-1/
│   ├── SKILL.md            # Independent skill definition
│   ├── scripts/
│   └── references/
├── component-2/
│   ├── SKILL.md            # Independent skill definition
│   ├── scripts/
│   └── references/
├── shared/                 # Shared utilities, data, config
│   ├── utils.py
│   └── config.json
├── install.sh              # Installs all components
└── README.md               # Suite-level documentation
```

### 3.2 marketplace.json Schema (Official Fields Only)

When a Complex Suite includes a `marketplace.json`, it must contain **only** the official Claude Code fields. No custom or non-standard fields are permitted.

```json
{
  "name": "suite-name",
  "plugins": [
    {
      "name": "component-1",
      "description": "What component-1 does",
      "source": "component-1/SKILL.md",
      "skills": ["component-1"]
    },
    {
      "name": "component-2",
      "description": "What component-2 does",
      "source": "component-2/SKILL.md",
      "skills": ["component-2"]
    }
  ]
}
```

**Allowed top-level fields:**
- `name` (string): The suite name
- `plugins` (array): List of plugin entries

**Allowed fields per plugin entry:**
- `name` (string): Component skill name
- `description` (string): What the component does
- `source` (string): Relative path to the component's SKILL.md
- `skills` (array of strings): Skill identifiers

**Forbidden fields** (non-standard, will cause validation failure):
- `version` -- use `metadata.version` in SKILL.md instead
- `author` -- use `metadata.author` in SKILL.md instead
- `repository` -- not part of the official schema
- `tags` -- not part of the official schema
- Any other custom fields

### 3.3 When to Use marketplace.json

| Scenario | Include marketplace.json? |
|----------|--------------------------|
| Simple skill (1 SKILL.md) | No |
| Complex suite for Claude Code distribution | Yes (optional) |
| Complex suite targeting only non-Claude platforms | No |
| Suite where components must be independently discoverable in Claude Code | Yes |

### 3.4 Component Independence

Each component in a Complex Suite should be independently functional:

- Each component has its own `SKILL.md` with valid frontmatter
- Each component can be installed separately if extracted from the suite
- Shared resources in `shared/` are optional enhancements, not hard dependencies
- Each component's `name` field matches its directory name

---

## 4. Naming Convention

All skill and suite names follow standard kebab-case per the Agent Skills Open Standard.

### 4.1 Rules

| Rule | Requirement |
|------|-------------|
| Length | 1-64 characters |
| Characters | Lowercase letters (`a-z`), numbers (`0-9`), hyphens (`-`) |
| Format | kebab-case |
| First character | Must be a letter or number (not a hyphen) |
| Last character | Must be a letter or number (not a hyphen) |
| Consecutive hyphens | Not allowed (`my--skill` is invalid) |
| Directory match | The `name` field in SKILL.md frontmatter must exactly match the parent directory name |

### 4.2 The -cskill Suffix Is Deprecated

The `-cskill` suffix convention from earlier versions is **removed** as of v4.0. Do not append `-cskill` to any generated skill name.

| Old (deprecated) | New (standard) |
|-------------------|----------------|
| `article-to-prototype-cskill` | `article-to-prototype` |
| `stock-analyzer-cskill` | `stock-analyzer` |
| `csv-data-cleaner-cskill` | `csv-data-cleaner` |

If a user requests the `-cskill` suffix, inform them it is deprecated and generate the skill without it.

### 4.3 Naming Pattern

Use the format `domain-objective` or `domain-objective-type`:

```
{domain}-{objective}[-{qualifier}]
```

**Examples:**
- `stock-analyzer` -- domain: stock, objective: analyzer
- `csv-data-cleaner` -- domain: csv-data, objective: cleaner
- `nass-usda-agriculture` -- domain: nass-usda, objective: agriculture
- `noaa-climate-analysis` -- domain: noaa-climate, objective: analysis
- `financial-analysis-suite` -- complex suite covering financial analysis

**Guidelines:**
- Be descriptive but concise
- Prefer shorter names when possible (aim for under 30 characters)
- Include the primary domain for discoverability
- Avoid generic names like `my-skill` or `tool-1`

### 4.4 Naming Validation

A valid name passes all of these checks:

```python
import re

def validate_skill_name(name: str) -> tuple[bool, list[str]]:
    errors = []
    if not name:
        errors.append("Name is required")
    if len(name) > 64:
        errors.append(f"Name exceeds 64 chars ({len(name)})")
    if name != name.lower():
        errors.append("Name must be lowercase")
    if not re.match(r'^[a-z0-9][a-z0-9-]*[a-z0-9]$', name) and len(name) > 1:
        errors.append("Name must start/end with letter or number, contain only a-z, 0-9, hyphens")
    if '--' in name:
        errors.append("Consecutive hyphens not allowed")
    if name.endswith('-cskill'):
        errors.append("The -cskill suffix is deprecated; remove it")
    return (len(errors) == 0, errors)
```

---

## 5. Directory Sizing Patterns

Choose a sizing pattern based on the skill's complexity. These patterns apply to both Simple Skills and individual components within a Complex Suite.

### 5.1 Small Agent Pattern

**When to use:** Single workflow, 1-2 scripts, <500 total lines of code.

```
skill-name/
├── SKILL.md              # <200 lines
├── scripts/
│   └── main.py           # 200-400 lines, single entry point
├── references/
│   └── guide.md          # API docs, methodology
├── assets/
│   └── config.json       # Minimal configuration
├── install.sh
└── README.md
```

**Characteristics:**
- One main script handles the entire workflow
- Minimal configuration
- Single reference document
- Estimated total: 500-800 lines across all files

**Examples:** markdown-table-formatter, url-shortener, json-validator

### 5.2 Medium Agent Pattern

**When to use:** 2-3 workflows, 3-5 scripts, 500-2000 total lines of code.

```
skill-name/
├── SKILL.md              # 200-400 lines
├── scripts/
│   ├── fetch.py          # Data acquisition (200-300 lines)
│   ├── parse.py          # Data processing (150-200 lines)
│   ├── analyze.py        # Analysis logic (300-500 lines)
│   └── utils/
│       ├── cache.py      # Cache management (100-150 lines)
│       └── validators.py # Input validation (100-150 lines)
├── references/
│   ├── api-guide.md      # ~1500 words
│   └── methodology.md    # ~2000 words
├── assets/
│   └── config.json
├── install.sh
└── README.md
```

**Characteristics:**
- Separation of concerns: fetch, parse, analyze
- Utility modules for cross-cutting concerns (caching, validation)
- Multiple reference documents
- Estimated total: 1000-2500 lines across all files

**Examples:** stock-analyzer, weather-dashboard, csv-data-cleaner

### 5.3 Large Agent Pattern

**When to use:** 3+ workflows within a single domain, 6+ scripts, 2000+ total lines of code. Still a Simple Skill if all workflows share a single domain and data pipeline.

```
skill-name/
├── SKILL.md              # 400-500 lines (at the limit)
├── scripts/
│   ├── core/
│   │   ├── fetch_source_a.py    # 200-300 lines
│   │   ├── fetch_source_b.py    # 200-300 lines
│   │   ├── parse_source_a.py    # 150-200 lines
│   │   ├── parse_source_b.py    # 150-200 lines
│   │   └── analyze.py           # 400-600 lines
│   ├── models/
│   │   ├── forecasting.py       # 200-300 lines
│   │   └── ml_models.py         # 200-300 lines
│   └── utils/
│       ├── cache_manager.py     # 100-150 lines
│       ├── rate_limiter.py      # 100-150 lines
│       └── validators.py        # 100-150 lines
├── references/
│   ├── api/
│   │   ├── source-a-guide.md
│   │   └── source-b-guide.md
│   ├── methods/
│   │   └── analysis-methods.md
│   └── troubleshooting.md
├── assets/
│   ├── config.json
│   └── metadata.json
├── install.sh
└── README.md
```

**Characteristics:**
- Sub-directories within `scripts/` for organization (core, models, utils)
- Multiple data sources with dedicated fetch/parse scripts
- Dedicated models directory for analysis/ML logic
- Organized reference documentation
- Estimated total: 2500-5000 lines across all files

**Examples:** nass-usda-agriculture, conab-crop-yield-analysis, noaa-climate-analysis

### 5.4 Sizing Comparison Table

| Aspect | Small | Medium | Large |
|--------|-------|--------|-------|
| Total code lines | <500 | 500-2000 | 2000+ |
| Script files | 1 | 3-5 | 6+ |
| Script sub-dirs | None | `utils/` | `core/`, `models/`, `utils/` |
| Reference files | 1 | 2-3 | 4+ (may use sub-dirs) |
| Asset files | 0-1 | 1 | 2+ |
| SKILL.md length | <200 lines | 200-400 lines | 400-500 lines |
| Typical domains | Formatters, validators | Data analyzers, dashboards | Multi-source analysis, forecasting |

---

## 6. Performance Strategy

All generated skills should incorporate performance considerations appropriate to their size and use case.

### 6.1 Caching Strategy

Cache API responses and computed results to avoid redundant work and reduce API usage.

**Cache TTL Decision Logic:**

| Data Type | TTL | Rationale |
|-----------|-----|-----------|
| Historical data (past years) | 365 days (effectively permanent) | Historical data does not change |
| Current-year data | 7 days | May be revised/updated |
| Metadata (lists, enums) | 365 days | Rarely changes |
| Real-time data | 1-60 minutes | Freshness required |
| User preferences | Session-scoped | Per-execution only |

**Implementation Pattern:**

```python
import json
import hashlib
from pathlib import Path
from datetime import datetime, timedelta

class FileCache:
    """Simple file-based cache with TTL support."""

    def __init__(self, cache_dir: str = "data/cache"):
        self.cache_dir = Path(cache_dir)
        self.cache_dir.mkdir(parents=True, exist_ok=True)

    def _key_path(self, key: str) -> Path:
        hashed = hashlib.sha256(key.encode()).hexdigest()[:16]
        return self.cache_dir / f"{hashed}.json"

    def get(self, key: str, ttl: timedelta) -> dict | None:
        path = self._key_path(key)
        if not path.exists():
            return None
        data = json.loads(path.read_text())
        cached_at = datetime.fromisoformat(data["cached_at"])
        if datetime.now() - cached_at > ttl:
            return None  # Expired
        return data["value"]

    def set(self, key: str, value: dict) -> None:
        path = self._key_path(key)
        path.write_text(json.dumps({
            "cached_at": datetime.now().isoformat(),
            "value": value
        }, indent=2))

    def get_or_fetch(self, key: str, ttl: timedelta, fetch_fn) -> dict:
        cached = self.get(key, ttl)
        if cached is not None:
            return cached
        value = fetch_fn()
        self.set(key, value)
        return value
```

**Cache Location:** Store cache files under `data/cache/` within the skill directory. This keeps cache local and avoids polluting system directories.

**Graceful Degradation:** If the cache file is corrupted or unreadable, log a warning and proceed without cache (fetch fresh data).

### 6.2 Rate Limiting Strategy

Protect against API rate limit exhaustion with proactive tracking.

**Rate Limiter Pattern:**

```python
import json
from pathlib import Path
from datetime import datetime, timedelta

class RateLimiter:
    """File-based rate limiter with persistent counter."""

    def __init__(
        self,
        max_requests: int,
        period: timedelta,
        counter_file: str = "data/cache/rate_limit.json"
    ):
        self.max_requests = max_requests
        self.period = period
        self.counter_file = Path(counter_file)
        self.counter_file.parent.mkdir(parents=True, exist_ok=True)

    def _load(self) -> dict:
        if not self.counter_file.exists():
            return {"requests": [], "period_start": datetime.now().isoformat()}
        return json.loads(self.counter_file.read_text())

    def _save(self, data: dict) -> None:
        self.counter_file.write_text(json.dumps(data, indent=2))

    def _prune_old(self, data: dict) -> dict:
        cutoff = (datetime.now() - self.period).isoformat()
        data["requests"] = [r for r in data["requests"] if r > cutoff]
        return data

    def allow_request(self) -> bool:
        data = self._prune_old(self._load())
        count = len(data["requests"])
        if count >= self.max_requests:
            return False
        if count > self.max_requests * 0.9:
            remaining = self.max_requests - count
            print(f"WARNING: Rate limit nearly reached ({count}/{self.max_requests}), {remaining} requests remaining")
        return True

    def record_request(self) -> None:
        data = self._prune_old(self._load())
        data["requests"].append(datetime.now().isoformat())
        self._save(data)
```

**Rate Limit Configuration:** Define rate limits in `assets/config.json` so they can be adjusted without code changes:

```json
{
  "rate_limit": {
    "max_requests_per_day": 1000,
    "warn_threshold_percent": 90
  }
}
```

### 6.3 Optimization Techniques

**For Small Agents:**
- Keep it simple. A single script with basic caching is sufficient.
- Avoid premature optimization.

**For Medium Agents:**
- File-based caching for API responses.
- Rate limiter for external APIs.
- Lazy loading of reference data (only load when a specific analysis is requested).

**For Large Agents:**
- All Medium optimizations, plus:
- Batch API requests where the API supports it.
- Parallel processing for independent data sources (use `concurrent.futures`).
- Tiered caching: in-memory for hot data, file-based for cold data.
- Progress reporting for long-running operations.

**General Rules:**
- Never make the same API call twice in a single execution -- always check cache first.
- Use exponential backoff for transient API failures (start at 1 second, max 3 retries).
- Log all API calls with timestamps for debugging rate limit issues.
- Keep cached data in `data/cache/` and provide a way to clear it (`--clear-cache` flag or a function).

### 6.4 Error Handling Strategy

Every script must handle errors gracefully:

```python
import sys
from pathlib import Path

def safe_api_call(url: str, params: dict, retries: int = 3) -> dict:
    """Make an API call with retry logic and graceful error handling."""
    import urllib.request
    import urllib.error
    import json
    import time

    for attempt in range(retries):
        try:
            query = "&".join(f"{k}={v}" for k, v in params.items())
            full_url = f"{url}?{query}" if params else url
            req = urllib.request.Request(full_url)
            with urllib.request.urlopen(req, timeout=30) as response:
                return json.loads(response.read().decode())
        except urllib.error.HTTPError as e:
            if e.code == 429:  # Rate limited
                wait = 2 ** attempt
                print(f"Rate limited. Retrying in {wait}s...")
                time.sleep(wait)
            elif e.code >= 500:  # Server error
                wait = 2 ** attempt
                print(f"Server error ({e.code}). Retrying in {wait}s...")
                time.sleep(wait)
            else:
                print(f"HTTP error {e.code}: {e.reason}")
                return {"error": str(e), "code": e.code}
        except urllib.error.URLError as e:
            print(f"Network error: {e.reason}")
            if attempt < retries - 1:
                time.sleep(2 ** attempt)
            else:
                return {"error": f"Network error after {retries} attempts: {e.reason}"}
        except Exception as e:
            return {"error": f"Unexpected error: {str(e)}"}

    return {"error": f"Failed after {retries} retries"}
```

### 6.5 SKILL.md Size Management

The SKILL.md body must stay under 500 lines. Use progressive disclosure:

| Content Type | Where It Goes |
|-------------|---------------|
| Activation triggers, overview, core workflow | `SKILL.md` body (required) |
| API documentation, endpoint details | `references/api-guide.md` |
| Analysis methodology, formulas | `references/methodology.md` |
| Troubleshooting, FAQs | `references/troubleshooting.md` |
| Domain context, terminology | `references/domain-context.md` |
| Configuration schema documentation | `references/config-guide.md` |

Reference content from SKILL.md using `See references/filename.md for details.` directives. The agent will load referenced files on demand, reducing initial context consumption.

---

## 7. Architecture Checklist

Use this checklist before proceeding to implementation (Phase 5):

### Decision

- [ ] Determined Simple Skill vs Complex Suite
- [ ] Justified the decision based on workflow count, code size, and domain scope

### Naming

- [ ] Name is 1-64 characters, kebab-case
- [ ] Name matches the parent directory
- [ ] No `-cskill` suffix
- [ ] Name is descriptive and includes the primary domain

### Structure

- [ ] Directory layout matches the chosen sizing pattern (Small/Medium/Large)
- [ ] SKILL.md planned at <500 lines
- [ ] Scripts have clear separation of concerns
- [ ] References planned for detailed content
- [ ] `install.sh` included
- [ ] `README.md` planned with multi-platform install instructions
- [ ] No `marketplace.json` for Simple Skills
- [ ] If Complex Suite with `marketplace.json`, only official fields used

### Performance

- [ ] Cache strategy defined (what to cache, TTL for each data type)
- [ ] Rate limiting planned for external APIs
- [ ] Error handling approach defined (retries, backoff, fallbacks)
- [ ] SKILL.md size managed via progressive disclosure to `references/`

### Documentation

- [ ] Architecture decisions documented
- [ ] Script responsibilities defined (input, output, line count estimate)
- [ ] Reference files planned (topic, estimated word count)
- [ ] Asset files planned (config structure, metadata)
