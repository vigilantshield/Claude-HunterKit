<div align="center">
  <h1>⚔️ claude-hunterKit</h1>
  <p><strong>170 offensive security skills · 1,770+ payload files · Bug bounty · Red team · Pentest</strong></p>
  <p>The largest open-source offensive security skill library — one command to hunt anything.</p>

  [![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
  [![Skills](https://img.shields.io/badge/skills-170-brightgreen)]()
  [![Payloads](https://img.shields.io/badge/payloads-1,770%2B-orange)]()
  [![Web Vulns](https://img.shields.io/badge/web%20vulns-51-red)]()
  [![AI Skills](https://img.shields.io/badge/AI%20security-24-blueviolet)]()
</div>

---

# 🔥 Stop Hunting Blind. Pick a Domain, Fire Payloads, Get Paid.

**claude-hunterKit** is a complete offensive security toolkit — 170 structured skill files covering **web, API, AI/LLM, network, cloud, recon, and auth** with **1,770+ wordlist payload files**. Every skill tells you exactly how to detect, exploit, chain, and bypass — in one markdown file.

> **From zero to finding in under 60 seconds.** Open the skill → follow the methodology → fire the payloads.

---

## 📦 Installation

### Option 1: One-Click Install (All Agents)

```bash
git clone https://github.com/your-org/claude-hunterKit
cd claude-hunterKit
bash install.sh
```

This installs:
- **171 skills** → `~/.claude/skills/claude-hunterkit/`
- **1,580+ wordlist payloads** → bundled alongside skills
- **Chrome DevTools MCP** → browser automation for XSS/SSRF/OAuth
- **Agent plugins** → auto-detected for Claude Code, Codex, Gemini, Cursor

### Option 2: Install Per Agent

| Agent | Install Command | Plug & Play |
|-------|----------------|-------------|
| **Claude Code** | `bash install.sh --plugin claude` | Skills appear in `/skills` + MCP auto-wired |
| **Codex CLI** | `bash install.sh --plugin codex` | Available in `/plugins` marketplace browser |
| **Gemini CLI** | `bash install.sh --plugin gemini` | `gemini extensions install <path>` |
| **Cursor** | `bash install.sh --plugin cursor` | MCP config added automatically |
| **Command Code (cmd)** | `bash install.sh --plugin cmd` | Skills appear in `/skills` menu |

### Option 3: MCP Only (Browser Automation)

```bash
bash install.sh --mcp
```

Adds Chrome DevTools MCP to your agent for XSS verification, SSRF confirmation, and OAuth interception.

### Option 4: Domain-Specific

```bash
# Just web skills + payloads
bash install.sh --domain web

# Just AI/LLM skills
bash install.sh --domain ai

# Just bug bounty workflow
bash install.sh --domain bugbounty
```

### Option 5: Direct Plugin Installation

If you prefer to install the plugins directly without using the installation script, you can copy the specific agent plugin directory from the `plugin/` folder to your agent's configuration directory. These plugins provide deep integration with the respective AI agents, offering auto-wiring of the MCP, custom skill menus, and domain-specific context directly inside the agent UI.

| Agent | Direct Copy Command |
|-------|--------------------|
| **Claude Code** | `cp -r plugin/.claude-plugin ~/.claude/plugins/claude-hunterkit` |
| **Codex CLI** | `cp -r plugin/.codex-plugin ~/.codex/plugins/claude-hunterkit` |
| **Gemini CLI** | `cp -r plugin/.gemini ~/.gemini/plugins/claude-hunterkit` |
| **Cursor** | `cp -r plugin/.cursor-plugin ~/.cursor/plugins/claude-hunterkit` |

### Option 6: Install via Marketplace

You can also install the **claude-hunterKit** directly through the built-in extension marketplaces or plugin directories of supported AI agents. Simply search for `claude-hunterKit` in the marketplace browser of your agent (e.g., Codex CLI plugins or Gemini Extensions) and click install.

### Option 7: Manual

```bash
# Clone and symlink or copy
git clone https://github.com/your-org/claude-hunterKit
ln -s $(pwd)/claude-hunterKit ~/.claude/skills/claude-hunterkit

# Add MCP to your agent config:
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"]
    }
  }
}
```

### Verify Installation

```bash
bash install.sh --list       # See all domains and skill counts
bash install.sh --dry-run    # Preview what would be installed
ls skills/web/               # List all 79 web skills
```

---

## 🚀 Quick Start (10 Seconds)

```bash
# Bug bounty? Start here:
bugbounty/bugbounty-master/SKILL.md

# SQLi today?
skills/web/web-01-sqli/SKILL.md

# Testing an API?
skills/api/api-01-spec-ingestion/SKILL.md

# AI/LLM chatbot?
skills/ai/ai-01-prompt-injection/SKILL.md
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
| **42,000+** | Lines of methodology | Deep analysis — not shallow checklists |
| **100%** | Section coverage | Every skill has Hacker Mindset, Chain, OOB, Bypass, Payloads |

---

## 🎯 What Makes This Different

| Other Toolkits | claude-hunterKit |
|---------------|------------------|
| Payload dumps with no context | **Full methodology** — what, why, how, and next steps |
| Generic scanning tools | **Domain-specific** — web vs API vs AI vs network all separated |
| One-off scripts | **Structured skills** — 6 sections, consistent, reusable |
| Outdated techniques | **2025-2026 CVEs** — current attack landscape |
| No chain guidance | **Built-in chaining** — every skill shows the pivot paths |

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

## 📁 Structure (All 170 Skills)

```
claude-hunterKit/
│
├── bugbounty/              # Bug bounty master workflow (full pipeline)
│
├── skills/
│   ├── web/                # 79 skills — 51 unique vuln types
│   │   ├── web-01-sqli     # SQL injection (error, blind, time, OOB, all DBs)
│   │   ├── web-16-xss      # Cross-site scripting (stored, reflected, DOM, blind)
│   │   ├── web-27-ssrf     # SSRF (cloud metadata, blind, IMDSv2, K8s)
│   │   ├── web-34-biz-logic # Business logic (coupons, races, currency)
│   │   ├── web-37-rce      # Remote code execution (all vectors)
│   │   ├── web-39-csrf     # CSRF (token bypass, SameSite, JSON)
│   │   ├── web-66-nodejs   # Node.js security
│   │   ├── web-68-nextjs   # Next.js specific
│   │   └── ... up to 80    # Framework-specific (Laravel, ASP.NET, SharePoint)
│   │
│   ├── api/                # 35 API skills
│   │   ├── api-01-spec-ingestion  # OpenAPI/Swagger discovery
│   │   ├── api-04-bola            # Broken Object Level Auth
│   │   ├── api-10-sqli            # API SQL injection
│   │   ├── api-16-grpc            # gRPC security
│   │   ├── api-22-biz-logic       # API business logic
│   │   ├── api-26-supply-chain    # API supply chain
│   │   └── ... up to 35
│   │
│   ├── ai/                 # 24 AI/LLM security skills
│   │   ├── ai-01-prompt-injection    # Direct/indirect injection
│   │   ├── ai-03-jailbreaking        # DAN, roleplay, encoding bypass
│   │   ├── ai-05-rag-poisoning       # RAG injection
│   │   ├── ai-08-excessive-agency    # AI agent tool abuse
│   │   ├── ai-09-agentic-attacks     # Multi-agent attacks
│   │   ├── ai-14-llm-infra           # LLM infrastructure
│   │   ├── ai-19-adversarial-ml      # Adversarial ML
│   │   └── ... up to 24
│   │
│   ├── network/            # 21 network/infra skills
│   │   ├── net-01-cloud    # AWS/Azure/GCP offensive
│   │   ├── net-04-k8s      # Kubernetes attacks
│   │   ├── net-12-cicd     # CI/CD pipeline hijacking
│   │   └── ... up to 21
│   │
│   ├── cloud/              # Advanced cloud depth
│   │   ├── cloud-01-cloud          # Cloud fundamentals
│   │   └── cloud-02-cloud-advanced # Full AWS/Azure/GCP kill chain
│   │
│   ├── auth/               # Authentication attacks
│   │   ├── auth-01-jwt     # JWT algorithm confusion, kid injection
│   │   └── auth-02-oauth   # OAuth redirect_uri, PKCE bypass
│   │
│   ├── recon/              # Reconnaissance
│   │   ├── recon-01-osint  # OSINT methodology
│   │   └── recon-05-openapi-enum  # API spec discovery
│   │
│   ├── devtools/           # Browser automation
│   │   └── devtools-01-mcp-reference  # Chrome DevTools MCP (46k stars)
│   │
│   └── reporting/          # Human-voice report writing
│       └── report-01-human-reporting
│
├── wordlists/              # 1,770+ payload files
│   ├── web/                # 661 files — SQLi, XSS, SSRF, JWT, NoSQL...
│   ├── api/                # 446 files — BOLA, gRPC, WS, mTLS...
│   ├── ai/                 # 424 files — prompt injection, jailbreaks...
│   ├── network/            # 87 files — cloud metadata, K8s, LDAP...
│   ├── auth/               # 129 files — JWT, OAuth, SAML...
│   └── recon/              # 21 files — fingerprinting, JS analysis...
│
└── README.md               # You are here
```

---

## 🔥 Top 5 Most Dangerous Skills

| Skill | Why It Pays |
|-------|------------|
| **[SSRF](skills/web/web-27-ssrf/)** → Cloud Metadata → IAM Keys → Full Account | Critical, fast, reliable |
| **[Business Logic](skills/web/web-34-business-logic/)** → Coupon Race → Negative Total → Free Money | Direct financial impact |
| **[Prompt Injection](skills/ai/ai-01-prompt-injection/)** → System Prompt → API Keys → Full Access | New, unsaturated |
| **[IDOR/BOLA](skills/web/web-23-idor/)** → User A reads User B's data → PII Breach | Most common API bug |
| **[JWT](skills/auth/auth-01-jwt/)** → alg:none → Admin Access | One line of JSON = admin |

---

## ⚡ Chrome DevTools MCP Integration

Browser automation for XSS verification, SSRF confirmation, and OAuth interception:

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"]
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
1. bugbounty/bugbounty-master/  →  Define target, understand scope
2. skills/recon/                →  Discover attack surface
3. skills/web/ or api/ or ai/   →  Hunt systematically
4. Each skill:                  →  Detect → Payload → Bypass → Chain → OOB
5. skills/reporting/            →  Write human-voice report → Get paid
```

---

## 🧪 Quick Test

```bash
# Test a skill is complete
grep -c "Hacker Mindset" skills/web/web-01-sqli/SKILL.md
# Should return 1 — every skill has it

# Count total skills
find skills/ -name "SKILL.md" ! -path "*/_*" | wc -l
# 170
```

---

## 📜 License

Apache 2.0 — free for commercial and personal use.

---

<div align="center">
  <p>
    <strong>⭐ Star this repo if you use it — it helps others find it.</strong><br>
    <sub>170 skills · 1,770+ payloads · Built for hunters, by hunters</sub>
  </p>
  <p>
    <a href="bugbounty/bugbounty-master/SKILL.md">Start Hunting →</a>
  </p>
</div>
