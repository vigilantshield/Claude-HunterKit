# claude-hunterKit — 4 Agent Integrations

## Quick Install

```bash
cd claude-hunterKit
bash install.sh
```

Auto-detects all installed agents and copies the right plugin manifests.

---

## 1. Claude Code

**Plugin:** `plugin/.claude-plugin/plugin.json`

```bash
# Auto-install
bash install.sh --plugin claude

# Manual
cp -r plugin/.claude-plugin ~/.claude/plugins/claude-hunterkit
claude mcp add chrome-devtools npx -y chrome-devtools-mcp@latest
claude mcp add hunterkit-router npx -y claude-hunterkit@latest
```

Skills appear in the `/skills` command. MCP auto-wired via `.mcp.json` in the repo root.

**Config:** `.claude/settings.local.json` enables `chrome-devtools` and `hunterkit-router` MCP servers.

---

## 2. Codex CLI

**Plugin:** `plugin/.codex-plugin/plugin.json`

```bash
# Auto-install
bash install.sh --plugin codex

# Manual
cp -r plugin/.codex-plugin ~/.codex/plugins/claude-hunterkit
codex mcp add claude-hunterkit -- npx -y chrome-devtools-mcp@latest
```

Available in the `/plugins` marketplace browser. 45 skills listed with full paths.

---

## 3. Gemini CLI

**Plugin:** `plugin/.gemini/gemini-extension.json`

```bash
# Auto-install
bash install.sh --plugin gemini

# Manual
cp -r plugin/.gemini ~/.gemini/plugins/claude-hunterkit
gemini extensions install claude-hunterKit
gemini mcp add claude-hunterkit npx -y chrome-devtools-mcp@latest
```

9 capabilities registered (web, API, AI, cloud, network, recon, auth, bug bounty, deep recon).
Prompt templates map each domain to the correct skill path.

---

## 4. Command Code (cmd)

**Plugin:** `.commandcode/plugin.json`

```bash
# Auto-install
bash install.sh --plugin cmd

# Manual
cp .commandcode/plugin.json ~/.commandcode/
cp -r .commandcode/skills/ ~/.commandcode/skills/
cmd mcp add chrome-devtools -- npx -y chrome-devtools-mcp@latest
```

Skills appear in `/skills` menu. Both MCP servers pre-configured.

---

## MCP Servers (All Integrations)

| Server | Purpose | Command |
|--------|---------|---------|
| **chrome-devtools** | Browser automation — XSS, SSRF, OAuth verification | `npx -y chrome-devtools-mcp@latest` |
| **hunterkit-router** | Routes hunting tasks to correct skill by target type | `npx -y claude-hunterkit@latest` |

---

## Pipeline (All Integrations)

Every integration follows the same 5-phase pipeline:

1. **Deep Recon** — 11 recon skills covering stack, surface, and defense
2. **Decision Matrix** — 40+ signal rules match recon findings to vuln agents
3. **Targeted Exploit** — Launch only matched skill agents
4. **Chain & Escalate** — Escalate via pre-defined chain paths
5. **Report** — Human-voice findings output

See `skills/_hunter/recon-decision-matrix.yaml` for the full decision logic.
