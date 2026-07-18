<div align="center">
  <h1>⚔️ claude-hunterKit</h1>
  <p><strong>148 offensive security skills · 1,569 payload files · 4 agent integrations · Recon-first RED TEAM pipeline</strong></p>
  <p>Red-team offensive security engine — deep recon first, signal-gated exploitation, aggressive chaining to critical impact.</p>

  [![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
  [![Skills](https://img.shields.io/badge/skills-148-brightgreen)]()
  [![Payloads](https://img.shields.io/badge/payloads-1,569-orange)]()
  [![Web Vulns](https://img.shields.io/badge/web%20vulns-51-red)]()
  [![AI Skills](https://img.shields.io/badge/AI%20security-24-blueviolet)]()
  [![Integrations](https://img.shields.io/badge/integrations-4-lightgrey)]()
</div>

---

# 🔥 Stop Hunting Blind. RED TEAM MODE.

**claude-hunterKit** is an open-source red-team offensive security engine — 148 structured skill files, 1,569 payloads, and a **recon-first conditional launch pipeline** with 31 escalation paths and 8 stop conditions. Every finding is a primitive to chain into critical impact.

> **Phase 1:** Deep recon (11 skills) → **Phase 2:** Decision matrix matches 40+ signals → **Phase 3:** Targeted exploit → **Phase 4:** Chain & escalate → **Phase 5:** Report

---

## 🎯 RED TEAM MINDSET

Every finding is a PRIMITIVE, not a report entry.
- XSS is not "reflected XSS confirmed" — it's a **session hijack vector**
- SQLi is not "error-based injection" — it's a **database exfil pipeline**
- SSRF is not "blind SSRF detected" — it's a **cloud metadata extraction tunnel**

Chain LOW/MEDIUM primitives into CRITICAL impact. A finding without a chain path is an incomplete finding.

---

## 🧠 The Offensive Pipeline

```
Target → PHASE 0: Categorize (web/api/auth/ai/network/cloud)
         ↓
         PHASE 1a: Network/Stack Recon  (recon-01,02,03)
         PHASE 1b: Surface Mapping      (recon-04,05,06)
         PHASE 1c: Defense Analysis     (recon-07,08,09,10,11)
         ↓
         PHASE 2: Decision Matrix       (40+ signal rules → select agents)
         ↓
         PHASE 3: Targeted Exploit      (confirm → escalate → exfil)
         ↓
         PHASE 4: Chain & Escalate      (31 escalation paths)
         ↓
         PHASE 5: Report                (human-voice, impact-first)
```

| Phase | What Happens | Skills Used |
|-------|-------------|-------------|
| **0. Categorize** | Classify target (web, API, AI, network, cloud, auth) | domain orchestrator |
| **1a. Network/Stack** | Subdomains, IPs, WAF, tech stack, CDN, server fingerprint | `recon-01` `recon-02` `recon-03` |
| **1b. Surface Mapping** | Crawl, JS endpoints, OpenAPI specs, hidden routes, forms | `recon-04` `recon-05` `recon-06` |
| **1c. Defense Analysis** | WAF type, auth schemes, security headers, CORS, shadow APIs | `recon-07` `recon-08` `recon-09` `recon-10` `recon-11` |
| **2. Decision Matrix** | Map 40+ signals → launch matched agents only | `_hunter/recon-decision-matrix.yaml` |
| **3. Exploit** | confirm/ → parameters/ → payloads/ → post-exploit extraction | matched vuln skills |
| **4. Chain** | 31 escalation paths: SQLi→RCE, SSRF→Cloud, XSS→ATO, JWT→Admin | escalation_paths in matrix |
| **5. Report** | ✅ Confirmed / 🔍 Signal / ❌ Not found — impact-first | reporting skill |

**Cardinal rule:** Complete ALL of Phase 1 before launching ANY vulnerability agent. Launch agents ONLY for vuln classes where recon found matching signals.

---

## 📦 Installation

Skills reference wordlists via repo-root-relative paths (`wordlists/web/...`). The only working layout is **skills + wordlists as siblings** — either via symlink or the installer.

### Quick (Symlink) — Works With Every CLI

Clone once, symlink into each CLI's skills directory. The repo stays in place; updates are `git pull`.

```bash
git clone https://github.com/vigilantshield/Claude-HunterKit.git
cd Claude-HunterKit

# Claude Code — symlink skills + wordlists + chrome-devtools MCP
ln -s "$PWD/skills"     ~/.claude/skills/claude-hunterkit
ln -s "$PWD/wordlists"  ~/.claude/skills/wordlists
ln -s "$PWD/bugbounty"  ~/.claude/skills/bugbounty
claude mcp add --scope user chrome-devtools -- npx -y chrome-devtools-mcp@latest

# Gemini CLI — link repo as extension + MCP
gemini extensions link "$PWD" --consent
gemini mcp add -s user chrome-devtools npx -y chrome-devtools-mcp@latest

# Command Code (cmd) — install skill set from GitHub + link wordlists + MCP
cmd skills add vigilantshield/Claude-HunterKit -g
ln -s "$PWD/wordlists"  ~/.commandcode/skills/wordlists
cmd mcp add chrome-devtools -- npx -y chrome-devtools-mcp@latest

# Codex CLI — chrome-devtools MCP only (skills referenced from repo)
codex mcp add chrome-devtools -- npx -y chrome-devtools-mcp@latest
```

### One-Click (Installer) — Detects + Integrates All Installed CLIs

```bash
git clone https://github.com/vigilantshield/Claude-HunterKit.git
cd Claude-HunterKit
bash install.sh
```

Does the same as above but auto-detects which CLIs are on your PATH and runs the right commands for each. Idempotent — re-running is safe.

| Flag | What It Installs |
|------|-----------------|
| _(none)_ | All detected CLIs: Claude Code → symlinks, cmd → wordlist link, gemini → extension link, codex → MCP |
| `--plugin claude` | Claude Code only |
| `--plugin cmd` | Command Code only |
| `--plugin gemini` | Gemini CLI only |
| `--plugin codex` | Codex CLI only |
| `--mcp` | Chrome DevTools MCP only (all CLIs) |
| `--domain <name> --target <dir>` | Copy one domain's skills + wordlists as siblings to `<dir>` |
| `--dry-run` | Preview what would happen (no changes) |
| `--list` | Show available domains and plugins |

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

# Want the RED TEAM workflow?
skills/_hunter/_hunter-orchestrator.yaml
```

---

## 📊 By the Numbers

| Metric | Value | What It Means |
|--------|-------|---------------|
| **148** | Skills | Every vulnerability class, framework, and technique — deduplicated and clean |
| **1,569** | Payload files | Ready-to-fire wordlists — no external tools needed |
| **51** | Web vuln types | SQLi, XSS, SSRF, IDOR, XXE, SSTI, RCE, GraphQL, JWT... |
| **35** | API skills | BOLA, BFLA, gRPC, WebSocket, mTLS, supply chain... |
| **24** | AI/LLM skills | Prompt injection, jailbreaking, RAG poisoning, MCP... |
| **21** | Network skills | Cloud, K8s, CI/CD, Kerberos, LDAP, serverless... |
| **11** | Recon skills | OSINT, tech fingerprint, JS analysis, OpenAPI, crawl, WAF, auth, headers, CORS, API surface |
| **42,000+** | Lines of methodology | Deep analysis — not shallow checklists |
| **31** | Escalation paths | Chain primitives into critical impact (was 7) |
| **8** | Stop conditions | Know when you own the target (ATO, RCE, PII, IAM keys, pivot) |
| **4** | Agent plugins | Claude Code, Codex CLI, Gemini CLI, cmd |
| **1** | MCP Server | Chrome DevTools (browser automation) |
| **40+** | Signal rules | Decision matrix entries mapping recon findings → vuln agents |

---

## 🎯 What Makes This Different

| Other Toolkits | claude-hunterKit |
|---------------|------------------|
| Fire all payloads at every target | **Recon-first** — deep recon decides which agents to launch |
| Payload dumps with no context | **Full methodology** — 6 sections per skill, consistent, reusable |
| Generic scanning tools | **Domain-specific** — web vs API vs AI vs network all separated |
| Report findings, not impact | **RED TEAM MINDSET** — every finding is a chain primitive, not a report entry |
| No chain guidance | **31 escalation paths** — built-in attack trees (SQLi→RCE, SSRF→Cloud, XSS→ATO, JWT→Admin) |
| No kill discipline | **8 stop conditions** — know when you own the target |
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
│   ├── CLAUDE.md               # RED TEAM pipeline instructions
│   └── settings.local.json     # MCP server enablement
│
├── .mcp.json                   # MCP server definition (chrome-devtools)
│
├── bugbounty/
│   └── bugbounty-master/       # Full bug bounty pipeline
│
├── skills/
│   ├── _hunter/                # Master orchestrator + routing
│   │   ├── _hunter-orchestrator.yaml     # ← RED TEAM entry point
│   │   ├── routing-table.yaml
│   │   └── recon-decision-matrix.yaml    # ← 40+ signal rules, 31 escalation paths
│   │
│   ├── recon/                  # 11 recon skills
│   │   ├── recon-01-osint              # OSINT, subdomains, emails, leaks
│   │   ├── recon-02-osint-methodology  # Structured OSINT
│   │   ├── recon-03-tech-fingerprinting # Server, framework, WAF
│   │   ├── recon-04-js-analysis        # JS endpoints, source maps
│   │   ├── recon-05-openapi-enum       # API spec discovery
│   │   ├── recon-06-crawl-deep         # Hidden routes, SPA crawling
│   │   ├── recon-07-waf-detection      # WAF type, block pages, gaps
│   │   ├── recon-08-auth-mapping       # JWT/OAuth/SAML/Session
│   │   ├── recon-09-security-headers   # CSP, HSTS, XFO, CORS
│   │   ├── recon-10-cors-scan          # Origin reflection, credentialed
│   │   └── recon-11-api-surface        # Shadow APIs, all endpoints
│   │
│   ├── web/                   # 51 web skills (deduplicated)
│   │   ├── web-01-sqli                # SQL injection
│   │   ├── web-16-xss                 # Cross-site scripting
│   │   ├── web-27-ssrf                # SSRF
│   │   ├── web-23-idor                # IDOR
│   │   ├── web-37-rce                 # Remote code execution
│   │   ├── web-32-graphql             # GraphQL
│   │   ├── web-34-business-logic      # Business logic flaws
│   │   ├── web-68-nextjs              # Next.js specific
│   │   ├── web-69-laravel             # Laravel specific
│   │   └── ... up to 51
│   │   └── _orchestrator/            # Offensive web orchestrator
│   │
│   ├── api/                    # 35 API skills
│   │   ├── api-01-spec-ingestion     # OpenAPI/Swagger
│   │   ├── api-04-bola               # Broken Object Level Auth
│   │   ├── api-10-sqli               # API SQL injection
│   │   ├── api-16-grpc               # gRPC security
│   │   ├── api-29-jwt                # JWT attacks
│   │   ├── api-32-graphql            # GraphQL
│   │   └── ... up to 35
│   │   └── _orchestrator/            # Offensive API orchestrator
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
│   ├── auth/                   # 2 auth skills
│   │   └── _orchestrator/            # Offensive auth orchestrator
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
├── wordlists/                  # 1,569 payload files
│   ├── web/           (583 files)
│   ├── api/           (410 files)
│   ├── ai/            (387 files)
│   ├── network/       (71 files)
│   ├── auth/          (100 files)
│   ├── recon/         (18 files)
│   └── shared/        (2 files — index + invocation matrix)
│
├── gemini-extension.json        # Gemini CLI extension manifest
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

## ⚡ MCP Integration (1 Server)

Only one MCP server is wired — `chrome-devtools` (a real, published npm package). Skill routing is handled by the `_hunter` orchestrator and the `CLAUDE.md` pipeline, so no separate router server is needed.

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"],
      "description": "Browser automation for XSS, SSRF, OAuth verification"
    }
  }
}
```

---

## 🏆 Who This Is For

| Role | Why You Need This |
|------|-------------------|
| **Bug bounty hunters** | Full pipeline: recon → signal match → exploit → chain → report |
| **Red teamers** | RED TEAM MINDSET, 31 escalation paths, 8 stop conditions |
| **Pentesters** | 51 web vulns + 35 API skills + comprehensive kill chains |
| **AI security researchers** | 24 LLM-specific skills (most in any open-source repo) |
| **SOC / Blue team** | Know your enemy — offensive depth for defensive understanding |

---

## 💡 Attacker Workflow

```
0. bugbounty/bugbounty-master/  →  Define scope, understand target
1. skills/recon/                →  Deep recon (11 skills, 3 phases)
2. _hunter/recon-decision-matrix.yaml  →  Match signals → select agents
3. Each matched agent:          →  confirm → escalate → post-exploit
4. Chain findings:              →  SSRF→Cloud, XSS→ATO, SQLi→RCE, JWT→Admin
5. Check stop conditions:       →  Hit one? Deliver the chain.
6. skills/reporting/            →  Write human-voice report → Get paid
```---

## 🧪 Verify Installation

### Claude Code

```bash
# Skills and wordlists in place?
ls ~/.claude/skills/claude-hunterkit/web && echo "✓ skills"
ls ~/.claude/skills/wordlists/web/web-03-sqli && echo "✓ wordlists resolve"

# MCP server connected?
claude mcp list | grep chrome-devtools
# → chrome-devtools: npx -y chrome-devtools-mcp@latest - ✔ Connected

# Count installed
ls ~/.claude/skills/claude-hunterkit/ | wc -l            # → should show domain dirs
find ~/.claude/skills/claude-hunterkit -name SKILL.md | wc -l  # → 148
```

### Command Code (cmd)

```bash
# Wordlists resolve from installed skills?
ls ~/.commandcode/skills/wordlists/web/web-03-sqli && echo "✓ wordlists resolve"

# Skills installed?
cmd skills list | head -5

# MCP server enabled?
cmd mcp list | grep chrome-devtools
```

### Gemini CLI

```bash
# Extension linked?
gemini extensions list | grep claude-hunterkit

# MCP server connected?
gemini mcp list | grep chrome-devtools
```

### Codex CLI

```bash
# MCP server enabled?
codex mcp list | grep chrome-devtools
```

### Repo (Works With All CLIs)

```bash
bash install.sh --list          # 10 domains, plugins, counts
bash install.sh --dry-run       # preview (no changes)

find skills/ -name SKILL.md ! -path "*/_*" | wc -l   # → 148
find wordlists/ -name "*.txt" | wc -l                 # → 1,569
find skills/web -name SKILL.md | wc -l                # → 51
find skills/recon -name SKILL.md | wc -l              # → 11
ls skills/ai/ | wc -l                                 # → 24
ls skills/api/ | wc -l                                # → 35

# Red team pipeline: verify decision matrix
grep -c "from:" skills/_hunter/recon-decision-matrix.yaml    # → 31 escalation paths
grep -c "signals:" skills/_hunter/recon-decision-matrix.yaml  # → 40+ signal rules
```

---

## 📜 License

Apache 2.0 — free for commercial and personal use.

---

<div align="center">
  <p>
    <strong>⭐ Star this repo if you use it — it helps others find it.</strong><br>
    <sub>148 skills · 1,569 payloads · 4 agent plugins · 31 escalation paths · RED TEAM MODE</sub>
  </p>
  <p>
    <a href="bugbounty/bugbounty-master/SKILL.md">Start Hunting →</a>
  </p>
</div>
