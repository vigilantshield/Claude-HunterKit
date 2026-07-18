<div align="center">
  <h1>⚔️ claude-hunterKit</h1>
  <p><strong>170 offensive security skills · 1,770+ payload files · 4 agent integrations · Recon-first conditional launch</strong></p>
  <p>The largest open-source offensive security skill library — deep recon first, then fire payloads only where it matters.</p>

  [![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
  [![Skills](https://img.shields.io/badge/skills-170-brightgreen)]()
  [![Payloads](https://img.shields.io/badge/payloads-1,770%2B-orange)]()
  [![Web Vulns](https://img.shields.io/badge/web%20vulns-51-red)]()
  [![AI Skills](https://img.shields.io/badge/AI%20security-24-blueviolet)]()
  [![Integrations](https://img.shields.io/badge/integrations-4-lightgrey)]()
</div>

---

# 🔥 Stop Hunting Blind. Recon First, Then Strike.

**claude-hunterKit** is the largest open-source offensive security toolkit — 170 structured skill files, 1,770+ payloads, and a **recon-first pipeline** that runs deep reconnaissance before deciding which vulnerability agents to launch. No more firing every payload at every target.

> **Phase 1:** Deep recon (11 skills) → **Phase 2:** Decision matrix matches signals → **Phase 3:** Targeted exploit only on matched vulns

---

## 🧠 The Recon-First Pipeline

```
Target → PHASE 0: Categorize (web/api/auth/ai/network/cloud)
         ↓
         PHASE 1a: Network/Stack Recon  (recon-01,02,03)
         PHASE 1b: Surface Mapping      (recon-04,05,06)
         PHASE 1c: Defense Analysis     (recon-07,08,09,10,11)
         ↓
         PHASE 2: Decision Matrix       (40+ signal rules → launch decisions)
         ↓
         PHASE 3: Targeted Exploit      (only matched vuln agents)
         ↓
         PHASE 4: Chain & Escalate      (escalation paths for multi-bug chains)
         ↓
         PHASE 5: Report                (human-voice findings)
```

| Phase | What Happens | Skills Used |
|-------|-------------|-------------|
| **0. Categorize** | Classify target (web, API, AI, network, cloud, auth) | domain orchestrator |
| **1a. Network/Stack** | Subdomains, IPs, WAF, tech stack, CDN, server fingerprint | `recon-01` `recon-02` `recon-03` |
| **1b. Surface Mapping** | Crawl, JS endpoints, OpenAPI specs, hidden routes, forms | `recon-04` `recon-05` `recon-06` |
| **1c. Defense Analysis** | WAF type, auth schemes, security headers, CORS misconfig, shadow APIs | `recon-07` `recon-08` `recon-09` `recon-10` `recon-11` |
| **2. Decision Matrix** | Map 40+ signals to matched agents — launch selectively | `_hunter/recon-decision-matrix.yaml` |
| **3. Targeted Exploit** | confirm/ → parameters/ → payloads/ on matched skills | matched vuln skills |
| **4. Chain** | Escalate via chain paths (SQLi→RCE, SSRF→Cloud, XSS→ATO) | escalation_paths in matrix |
| **5. Report** | ✅ Confirmed / 🔍 Signal / ❌ Not found | reporting skill |

**Cardinal rule:** Complete ALL of Phase 1 before launching ANY vulnerability agent. Launch agents ONLY for vuln classes where recon found matching signals.

---

## 📦 Installation

### Option 1: One-Click Install

```bash
git clone https://github.com/your-org/claude-hunterKit
cd claude-hunterKit
bash install.sh
```

This installs:
- **170 skills** → `~/.claude/skills/claude-hunterkit/`
- **1,770+ wordlist payloads** → bundled alongside skills
- **2 MCP servers** → Chrome DevTools + HunterKit Router
- **4 agent plugins** → Claude Code, Codex CLI, Gemini CLI, Command Code (cmd)

### Option 2: Install Per Agent

| Agent | Install Command | Integration |
|-------|----------------|-------------|
| **Claude Code** | `bash install.sh --plugin claude` | Skills in `/skills` + MCP auto-wired |
| **Codex CLI** | `bash install.sh --plugin codex` | Plugin in marketplace browser |
| **Gemini CLI** | `bash install.sh --plugin gemini` | `gemini extensions install <path>` |
| **Command Code (cmd)** | `bash install.sh --plugin cmd` | Skills in `/skills` menu |

### Option 3: MCP Only

```bash
bash install.sh --mcp
```

Adds Chrome DevTools MCP + HunterKit Router for browser automation and skill routing.

### Option 4: Domain-Specific

```bash
bash install.sh --domain web       # Web skills + payloads only
bash install.sh --domain api       # API skills + payloads only
bash install.sh --domain ai        # AI/LLM skills + payloads only
bash install.sh --domain bugbounty # Full bug bounty workflow
```

### Option 5: Marketplace Install

```bash
gemini extensions install claude-hunterKit
codex plugin install claude-hunterKit
```

### Option 7: Manual

```bash
git clone https://github.com/your-org/claude-hunterKit
ln -s $(pwd)/claude-hunterKit ~/.claude/skills/claude-hunterkit

# In .mcp.json or agent config:
{
  "mcpServers": {
    "chrome-devtools": { "command": "npx", "args": ["-y", "chrome-devtools-mcp@latest"] },
    "hunterkit-router": { "command": "npx", "args": ["-y", "claude-hunterkit@latest"], "env": {"HUNTERKIT_PATH": "${workspaceFolder}"} }
  }
}
```

### Verify Installation

```bash
bash install.sh --list       # See all domains, skills, wordlists, and plugins
bash install.sh --dry-run    # Preview what would be installed
ls skills/recon/             # List all 11 recon skills
ls skills/web/               # List all 79 web skills
```

---

## 🚀 Quick Start (10 Seconds)

```bash
# Bug bounty? Start here:
bugbounty/bugbounty-master/SKILL.md

# Hunting SQLi?
skills/web/web-01-sqli/SKILL.md

# Testing an API?
skills/api/api-01-spec-ingestion/SKILL.md

# AI/LLM chatbot?
skills/ai/ai-01-prompt-injection/SKILL.md

# Need to map the target first?
skills/recon/recon-03-tech-fingerprinting/SKILL.md
```

---

## 📊 By the Numbers

| Metric | Value | What It Means |
|--------|-------|---------------|
| **170** | Skills | Every vulnerability class, framework, and technique |
| **1,770+** | Payload files | Ready-to-fire wordlists — no external tools needed |
| **51** | Web vuln types | SQLi, XSS, SSRF, IDOR, XXE, SSTI, RCE, GraphQL, JWT... |
| **35** | API skills | BOLA, BFLA, gRPC, WebSocket, mTLS, supply chain... |
| **24** | AI/LLM skills | Prompt injection, jailbreaking, RAG poisoning, MCP... |
| **21** | Network skills | Cloud, K8s, CI/CD, Kerberos, LDAP, serverless... |
| **11** | Recon skills | OSINT, tech fingerprint, JS analysis, OpenAPI, crawl, WAF, auth, headers, CORS, API surface |
| **42,000+** | Lines of methodology | Deep analysis — not shallow checklists |
| **4** | Agent plugins | Claude Code, Codex CLI, Gemini CLI, cmd |
| **2** | MCP Servers | Chrome DevTools + HunterKit Router |
| **40+** | Signal rules | Decision matrix entries mapping recon findings → vuln agents |

---

## 🎯 What Makes This Different

| Other Toolkits | claude-hunterKit |
|---------------|------------------|
| Fire all payloads at every target | **Recon-first** — deep recon decides which agents to launch |
| Payload dumps with no context | **Full methodology** — what, why, how, and next steps |
| Generic scanning tools | **Domain-specific** — web vs API vs AI vs network all separated |
| One-off scripts | **Structured skills** — 6 sections, consistent, reusable |
| No chain guidance | **Built-in chaining** — every skill shows the pivot paths |
| Agent plugin support | **4 integrations** — Claude Code, Codex CLI, Gemini CLI, cmd |

---

## 🧠 Every Skill Has 6 Sections (The Hunter Standard)

```
┌─────────────────────────────────────┐
│  🔮 Hacker Mindset                  │  ← Think like the attacker
│  🔍 Detection                       │  ← How to find it
│  📦 Wordlist Payloads               │  ← Actual payloads, ready to fire
│  ⚡ Bypass Techniques               │  ← How to evade filters/WAFs
│  ⛓️ Chaining & Escalation           │  ← Turn low into critical
│  📡 OOB Detection & Blind Confirm   │  ← Prove it without output
└─────────────────────────────────────┘
```

---

## 📁 Full Structure

```
claude-hunterKit/
│
├── .claude/                    # Claude Code config
│   ├── CLAUDE.md               # Pipeline instructions (recon-first)
│   └── settings.local.json     # MCP server enablement
│
├── .mcp.json                   # MCP server definitions (2 servers)
│
├── bugbounty/
│   └── bugbounty-master/       # Full bug bounty pipeline
│
├── skills/
│   ├── _hunter/                # Master orchestrator + routing
│   │   ├── _hunter-orchestrator.yaml
│   │   ├── routing-table.yaml
│   │   └── recon-decision-matrix.yaml   # ← 40+ signal rules
│   │
│   ├── recon/                  # 11 recon skills (NEW: recon-06 to 11)
│   │   ├── recon-01-osint              # OSINT methodology
│   │   ├── recon-02-osint-methodology  # Structured OSINT
│   │   ├── recon-03-tech-fingerprinting # Server, framework, WAF
│   │   ├── recon-04-js-analysis        # JS endpoints, source maps
│   │   ├── recon-05-openapi-enum       # API spec discovery
│   │   ├── recon-06-crawl-deep         # Hidden routes, SPA crawling
│   │   ├── recon-07-waf-detection      # WAF type, block pages, gaps
│   │   ├── recon-08-auth-mapping       # JWT/OAuth/SAML/Session detection
│   │   ├── recon-09-security-headers   # CSP, HSTS, XFO, CORS, cache
│   │   ├── recon-10-cors-scan          # Origin reflection, credentialed
│   │   └── recon-11-api-surface        # Shadow APIs, all endpoints
│   │
│   ├── web/                   # 79 web skills
│   │   ├── web-01-sqli                # SQL injection
│   │   ├── web-16-xss                 # Cross-site scripting
│   │   ├── web-27-ssrf                # SSRF
│   │   ├── web-23-idor                # IDOR
│   │   ├── web-37-rce                 # Remote code execution
│   │   ├── web-32-graphql             # GraphQL
│   │   ├── web-34-business-logic      # Business logic flaws
│   │   ├── web-68-nextjs              # Next.js specific
│   │   ├── web-69-laravel             # Laravel specific
│   │   └── ... up to 79
│   │   └── _orchestrator/            # Conditional launch routing
│   │
│   ├── api/                    # 35 API skills
│   │   ├── api-01-spec-ingestion     # OpenAPI/Swagger
│   │   ├── api-04-bola               # Broken Object Level Auth
│   │   ├── api-10-sqli               # API SQL injection
│   │   ├── api-16-grpc               # gRPC security
│   │   ├── api-29-jwt                # JWT attacks
│   │   ├── api-32-graphql            # GraphQL
│   │   └── ... up to 35
│   │   └── _orchestrator/            # Conditional launch routing
│   │
│   ├── ai/                     # 24 AI/LLM security skills
│   │   ├── ai-01-prompt-injection    # Direct/indirect injection
│   │   ├── ai-04-system-prompt-leakage
│   │   ├── ai-05-rag-poisoning
│   │   ├── ai-08-excessive-agency
│   │   ├── ai-10-mcp-security
│   │   └── ... up to 24
│   │
│   ├── network/                # 21 network/infra skills
│   ├── cloud/                  # 2 cloud security skills
│   ├── auth/                   # 3 auth skills
│   │   └── _orchestrator/            # Conditional launch routing
│   ├── devtools/               # Chrome DevTools MCP
│   └── reporting/              # Human-voice report writing
│
├── plugin/                     # Agent integration plugins
│   ├── .claude-plugin/         # Claude Code
│   ├── .codex-plugin/          # Codex CLI
│   └── .gemini/                # Gemini CLI
│
├── .commandcode/               # Command Code (cmd) plugin
│
├── wordlists/                  # 1,770+ payload files
│   ├── web/           (661 files)
│   ├── api/           (446 files)
│   ├── ai/            (424 files)
│   ├── network/       (87 files)
│   ├── auth/          (129 files)
│   ├── recon/         (21 files)
│   └── shared/        (2 files — index + invocation matrix)
│
├── install.sh                  # Universal installer
└── README.md
```

---

## 🔥 Top 10 Most Dangerous Skills

| Skill | Why It Pays |
|-------|------------|
| **[SSRF](skills/web/web-27-ssrf/)** → Cloud Metadata → IAM Keys → Full Account | Critical, fast, reliable |
| **[Business Logic](skills/web/web-34-business-logic/)** → Coupon Race → Negative Total → Free Money | Direct financial impact |
| **[Prompt Injection](skills/ai/ai-01-prompt-injection/)** → System Prompt → API Keys → Full Access | New, unsaturated |
| **[IDOR/BOLA](skills/web/web-23-idor/)** → User A reads User B's data → PII Breach | Most common API bug |
| **[JWT](skills/auth/auth-01-jwt/)** → alg:none → Admin Access | One line of JSON = admin |
| **[CORS Misconfig](skills/recon/recon-10-cors-scan/)** → Data Exfiltration via Origin Reflection | PII theft via JS |
| **[WAF Gap](skills/recon/recon-07-waf-detection/)** → Unprotected endpoint → Direct injection | Bypass all blocks |
| **[Shadow API](skills/recon/recon-11-api-surface/)** → Undocumented endpoint → No auth → Data access | 10x more endpoints |
| **[Auth Mapping](skills/recon/recon-08-auth-mapping/)** → Public endpoint with sensitive data → IDOR | Every app has these |
| **[Security Headers](skills/recon/recon-09-security-headers/)** → Missing CSP → XSS is game on | Free findings |

---

## ⚡ MCP Integration (2 Servers)

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"],
      "description": "Browser automation for XSS, SSRF, OAuth verification"
    },
    "hunterkit-router": {
      "command": "npx",
      "args": ["-y", "claude-hunterkit@latest"],
      "env": { "HUNTERKIT_PATH": "${workspaceFolder}" },
      "description": "Routes hunting tasks to the correct skill"
    }
  }
}
```

GitHub: [ChromeDevTools/chrome-devtools-mcp](https://github.com/ChromeDevTools/chrome-devtools-mcp) (46k ⭐)

---

## 🏆 Who This Is For

| Role | Why You Need This |
|------|-------------------|
| **Bug bounty hunters** | Full workflow from recon to payout-optimized reporting |
| **Red teamers** | Infrastructure, cloud, K8s, CI/CD attack paths |
| **Pentesters** | 51 web vuln types + 35 API skills + comprehensive methodology |
| **AI security researchers** | 24 LLM-specific skills (the most in any open-source repo) |
| **SOC / Blue team** | Know your enemy — offensive depth for defensive understanding |

---

## 💡 Attacker Workflow

```
0. bugbounty/bugbounty-master/  →  Define scope, understand target
1. skills/recon/                →  Deep recon (11 skills, 3 phases)
2. _hunter/recon-decision-matrix.yaml  →  Match signals → select agents
3. skills/web/ or api/ or ai/   →  Targeted exploit (matched skills only)
4. Each skill:                  →  Detect → Payload → Bypass → Chain → OOB
5. Chain findings:              →  SSRF→Cloud, XSS→ATO, SQLi→RCE
6. skills/reporting/            →  Write human-voice report → Get paid
```

---

## 🧪 Quick Test

```bash
# Verify a skill has all sections
grep -c "Hacker Mindset" skills/web/web-01-sqli/SKILL.md
# → 1

# Count all skills
find skills/ -name "SKILL.md" ! -path "*/_*" | wc -l
# → 170

# Count all recon skills
ls skills/recon/ | wc -l
# → 11

# Count all plugins
ls plugin/ | grep plugin
# → 3

# Test decision matrix is valid
grep -c "signals:" skills/_hunter/recon-decision-matrix.yaml
# → 40+
```

---

## 📜 License

Apache 2.0 — free for commercial and personal use.

---

<div align="center">
  <p>
    <strong>⭐ Star this repo if you use it — it helps others find it.</strong><br>
    <sub>170 skills · 1,770+ payloads · 4 agent plugins · Recon-first · Built for hunters, by hunters</sub>
  </p>
  <p>
    <a href="bugbounty/bugbounty-master/SKILL.md">Start Hunting →</a>
  </p>
</div>
