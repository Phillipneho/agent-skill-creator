# Multi-Agent Suite Creation

## Overview

A multi-agent suite is a collection of related skills that work together as a unified system. Instead of creating one monolithic skill, the suite splits responsibilities across multiple focused skills that share references and coordinate through a common integration layer.

The 5-phase pipeline applies to each component skill, but Phase 3 (Architecture) makes the critical decision: simple skill vs. complex suite.

## When to Use Batch Creation

| Scenario | Single Skill | Multi-Agent Suite |
|----------|-------------|-------------------|
| 1-2 distinct workflows | Recommended | Overkill |
| 3+ distinct workflows | Unwieldy | Recommended |
| Total code > 2,000 lines | Hard to maintain | Organized by component |
| Team maintenance | Single owner ok | Multiple contributors benefit |
| Shared data sources across workflows | Duplicated logic | Shared reference layer |
| Independent scaling of capabilities | Not possible | Each skill evolves independently |

**Rule of thumb**: If you find yourself describing more than two unrelated tasks in a single skill description, you need a suite.

## Suite Creation Process

### Step 1: Analyze Relationships

The system examines the user's requirements and identifies distinct workflow clusters.

```
User: "I need to track our e-commerce store -- monitor sales,
       analyze customer behavior, track inventory levels, and
       generate executive reports."

Analysis:
  Cluster 1: Sales Monitoring (revenue, orders, conversion)
  Cluster 2: Customer Analytics (segmentation, cohorts, churn)
  Cluster 3: Inventory Tracking (stock levels, reorder alerts)
  Cluster 4: Executive Reporting (aggregated dashboards)

  Shared resources: Shopify API connection, date utilities,
  report generation templates
```

### Step 2: Determine Structure

Based on the cluster analysis, the system designs the suite directory:

```
ecommerce-suite/
├── SKILL.md                        # Suite-level overview (<500 lines)
├── .claude-plugin/
│   └── marketplace.json            # Suite manifest (official fields only)
├── skills/
│   ├── sales-monitor/
│   │   ├── SKILL.md                # Sales-specific instructions
│   │   └── scripts/
│   │       └── monitor_sales.py
│   ├── customer-analytics/
│   │   ├── SKILL.md                # Customer-specific instructions
│   │   └── scripts/
│   │       └── analyze_customers.py
│   ├── inventory-tracker/
│   │   ├── SKILL.md                # Inventory-specific instructions
│   │   └── scripts/
│   │       └── track_inventory.py
│   └── executive-reports/
│       ├── SKILL.md                # Reporting instructions
│       └── scripts/
│           └── generate_reports.py
├── shared/
│   ├── api_client.py               # Shared Shopify API connection
│   ├── date_utils.py               # Common date handling
│   └── report_templates/           # Shared report assets
│       └── executive_template.html
├── references/
│   └── api-guide.md                # Shared API documentation
├── install.sh                      # Installs entire suite
└── README.md                       # Multi-platform instructions
```

### Step 3: Create Individual Skills

Each component skill goes through Phases 1-5 independently, but with awareness of the shared resources:

1. **Discovery** -- Each skill identifies its specific API endpoints (e.g., sales-monitor uses Shopify Orders API, inventory-tracker uses Shopify Inventory API).
2. **Design** -- Each skill defines its own analyses, scoped to its cluster.
3. **Architecture** -- Each skill follows the simple skill structure within the suite.
4. **Detection** -- Each skill gets its own description and keywords for independent activation.
5. **Implementation** -- Each skill references shared utilities from `shared/`.

### Step 4: Integration Layer

The suite-level `SKILL.md` serves as the orchestration layer. It describes how the component skills relate and when to invoke which one:

```markdown
# E-commerce Suite

## Component Skills

This suite contains four specialized skills:

- **sales-monitor**: Activate for revenue, orders, and conversion queries
- **customer-analytics**: Activate for segmentation, cohort, and churn queries
- **inventory-tracker**: Activate for stock levels, reorder, and supply queries
- **executive-reports**: Activate for dashboards, summaries, and executive briefings

## Cross-Skill Workflows

When the user asks for a "full store overview" or "weekly executive summary",
invoke executive-reports which aggregates data from all three other skills.
```

## Suite-Level marketplace.json

For complex suites that need Claude Code plugin registration, a `marketplace.json` is generated with **only official fields**:

```json
{
  "name": "ecommerce-suite",
  "plugins": [
    {
      "name": "sales-monitor",
      "description": "Monitor e-commerce sales, revenue trends, order volumes, and conversion rates using Shopify data.",
      "source": "./skills/sales-monitor/",
      "skills": ["./skills/sales-monitor/"]
    },
    {
      "name": "customer-analytics",
      "description": "Analyze customer behavior, segmentation, cohort retention, and churn patterns from e-commerce data.",
      "source": "./skills/customer-analytics/",
      "skills": ["./skills/customer-analytics/"]
    },
    {
      "name": "inventory-tracker",
      "description": "Track inventory stock levels, predict reorder points, and alert on low-stock items.",
      "source": "./skills/inventory-tracker/",
      "skills": ["./skills/inventory-tracker/"]
    },
    {
      "name": "executive-reports",
      "description": "Generate executive dashboards and PDF summaries aggregating sales, customer, and inventory data.",
      "source": "./skills/executive-reports/",
      "skills": ["./skills/executive-reports/"]
    }
  ]
}
```

**Important**: The marketplace.json uses ONLY the official fields: `name` and `plugins` at the top level, and `name`, `description`, `source`, `skills` per plugin entry. No `version`, `author`, `repository`, `tags`, `icon`, or other non-standard fields.

## Suite Examples

### Financial Suite

**User request**: "Create a suite for comprehensive financial analysis -- stock tracking, portfolio management, and market research."

```
financial-suite/
├── SKILL.md
├── .claude-plugin/marketplace.json
├── skills/
│   ├── stock-tracker/         # Real-time and historical price data
│   ├── portfolio-manager/     # Holdings, allocation, performance
│   └── market-research/       # Sector analysis, news sentiment
├── shared/
│   ├── market_data_client.py  # Alpha Vantage + Yahoo Finance
│   └── financial_utils.py     # Common calculations (returns, ratios)
├── references/
├── install.sh
└── README.md
```

### E-commerce Suite

**User request**: "I manage an online store and need to track everything -- sales, customers, inventory, and generate weekly reports."

(See the detailed structure in the Suite Creation Process section above.)

### Climate Suite

**User request**: "Build a climate analysis system with historical trend analysis, forecast monitoring, and extreme event alerting."

```
climate-suite/
├── SKILL.md
├── .claude-plugin/marketplace.json
├── skills/
│   ├── historical-trends/     # Long-term climate data analysis
│   ├── forecast-monitor/      # Short-term forecast tracking
│   └── extreme-events/        # Severe weather alerting
├── shared/
│   ├── climate_data_client.py # NOAA + Open-Meteo connections
│   └── geo_utils.py           # Geographic region handling
├── references/
├── install.sh
└── README.md
```

## Benefits of Suite Creation

### Time Efficiency

Creating a suite through the batch process is significantly faster than creating individual skills separately:

| Approach | API Research | Shared Code | Integration | Total |
|----------|-------------|-------------|-------------|-------|
| 4 separate skills | 4x (redundant) | 0 (duplicated) | Manual | ~4 hours |
| 1 suite (batch) | 1x (shared) | 1x (reused) | Automatic | ~1.5 hours |

### Built-in Integration

Component skills within a suite share:
- API client code (no duplicated connection logic)
- Utility functions (date handling, formatting, calculations)
- Reference documentation (API guides written once)
- Report templates (consistent styling across outputs)

### Independent Maintenance

Each component skill can be:
- Updated independently without affecting others
- Tested in isolation
- Replaced with an improved version
- Extended with new analyses

The suite structure makes it possible to update the inventory-tracker without touching the sales-monitor, while still sharing the underlying Shopify API client.

### Marketplace Discoverability

Each plugin entry in `marketplace.json` has its own description and keywords. This means a suite's individual components can be discovered by different searches:
- "track sales" finds the sales-monitor plugin
- "customer churn" finds the customer-analytics plugin
- "inventory alerts" finds the inventory-tracker plugin

The suite functions as both a single installable unit and a collection of independently discoverable capabilities.
