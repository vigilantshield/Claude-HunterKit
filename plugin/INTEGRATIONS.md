# claude-hunterKit — 11 Agent Integrations

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

## 3. Cursor

**Plugin:** `plugin/.cursor-plugin/plugin.json`

```bash
# Auto-install
bash install.sh --plugin cursor

# Manual
cp -r plugin/.cursor-plugin ~/.cursor/plugins/claude-hunterkit
```

Adds 2 MCP servers + 36 skills to Cursor's agent. Supports the orchestrator pipeline.

---

## 4. Gemini CLI

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

## 5. GitHub Copilot

**Plugin:** `plugin/.copilot-plugin/plugin.json`

```bash
# Auto-install
bash install.sh --plugin copilot

# Manual
cp -r plugin/.copilot-plugin ~/.config/github-copilot/plugins/
copilot mcp add --name claude-hunterkit -- npx -y chrome-devtools-mcp@latest
```

7 hunt tools registered (web, API, AI, auth, cloud, network, recon). Both MCP servers configured.

---

## 6. Windsurf (Cascade)

**Plugin:** `plugin/.windsurf-plugin/plugin.json`

```bash
# Auto-install
bash install.sh --plugin windsurf

# Manual
cp -r plugin/.windsurf-plugin ~/.windsurf/plugins/
windsurf mcp add --name claude-hunterkit -- npx -y chrome-devtools-mcp@latest
```

8 capabilities + 2 MCP servers. Add MCP config to `.windsurf/settings.json`.

---

## 7. Cline

**Plugin:** `plugin/.cline-plugin/plugin.json`

```bash
# Auto-install
bash install.sh --plugin cline

# Manual
cp -r plugin/.cline-plugin ~/.config/cline/plugins/
```

Add 2 MCP servers to `cline_mcp_settings.json`:
```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"]
    },
    "hunterkit-router": {
      "command": "npx",
      "args": ["-y", "claude-hunterkit@latest"],
      "env": {"HUNTERKIT_PATH": "/path/to/claude-hunterKit"}
    }
  }
}
```

7 hunt tools + 8 capabilities.

---

## 8. Continue.dev

**Plugin:** `plugin/.continue-plugin/plugin.json`

```bash
# Auto-install
bash install.sh --plugin continue

# Manual
cp -r plugin/.continue-plugin ~/.continue/plugins/
```

Adds context providers for loading skills by path. Add MCP config to `.continue/config.json`:
```json
{
  "mcpServers": [
    {
      "name": "chrome-devtools",
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp@latest"]
    },
    {
      "name": "hunterkit-router",
      "command": "npx",
      "args": ["-y", "claude-hunterkit@latest"],
      "env": {"HUNTERKIT_PATH": "/path/to/claude-hunterKit"}
    }
  ]
}
```

---

## 9. Aider

**Plugin:** `plugin/.aider-plugin/plugin.json`

```bash
# Auto-install
bash install.sh --plugin aider

# Manual
cp -r plugin/.aider-plugin ~/.aider/plugins/
```

Aider is file-prompt based. Load skills via `--read`:
```bash
aider --model claude-opus-4-8 --read skills/web/web-01-sqli/SKILL.md
```

---

## 10. Open Interpreter

**Plugin:** `plugin/.ointerpreter-plugin/plugin.json`

```bash
# Auto-install
bash install.sh --plugin ointerpreter

# Manual
cp -r plugin/.ointerpreter-plugin ~/.ointerpreter/plugins/
```

Python tool reference for loading skills directly:
```python
import os
HUNTERKIT_PATH = "/path/to/claude-hunterKit"
skill = open(f"{HUNTERKIT_PATH}/skills/web/web-01-sqli/SKILL.md").read()
```

---

## 11. Command Code (cmd)

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
