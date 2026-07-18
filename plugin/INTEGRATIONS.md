# claude-hunterKit — 4 Agent Integrations

## Quick Install

```bash
cd claude-hunterKit
bash install.sh
```

Detects all installed agents and, for each, symlinks skills + wordlists as siblings (so `wordlist_ref` paths resolve) and wires the `chrome-devtools` MCP server. Non-destructive and idempotent.

---

## 1. Claude Code

**Plugin:** `plugin/.claude-plugin/plugin.json`

```bash
# Auto-install
bash install.sh --plugin claude

# Manual
ln -s "$(pwd)/Claude-HunterKit/skills"     ~/.claude/skills/claude-hunterkit
ln -s "$(pwd)/Claude-HunterKit/wordlists"  ~/.claude/skills/wordlists
ln -s "$(pwd)/Claude-HunterKit/bugbounty"  ~/.claude/skills/bugbounty
claude mcp add --scope user chrome-devtools -- npx -y chrome-devtools-mcp@latest
```

Skills appear in the `/skills` command. MCP auto-loads via `.mcp.json` in the repo root when cwd is the repo; the user-scope `claude mcp add` above makes it available everywhere.

**Config:** `.claude/settings.local.json` enables the `chrome-devtools` MCP server.

---

## 2. Codex CLI

**Plugin:** `plugin/.codex-plugin/plugin.json`

```bash
# Auto-install (wires MCP)
bash install.sh --plugin codex

# Manual
codex mcp add chrome-devtools -- npx -y chrome-devtools-mcp@latest
```

Codex loads plugins from a marketplace snapshot, not local skill folders. Use skills by referencing `skills/<domain>/<skill>/SKILL.md` from the repo. Publish to a marketplace via `plugin/.codex-plugin/plugin.json`.

---

## 3. Gemini CLI

**Plugin:** `gemini-extension.json` (repo root) + `plugin/.gemini/gemini-extension.json`

```bash
# Auto-install
bash install.sh --plugin gemini

# Manual
gemini extensions link "$(pwd)/Claude-HunterKit" --consent
gemini mcp add -s user chrome-devtools npx -y chrome-devtools-mcp@latest
```

The repo-root `gemini-extension.json` declares the extension and the `chrome-devtools` MCP server. `gemini extensions link` reflects repo updates immediately.

---

## 4. Command Code (cmd)

**Plugin:** `.commandcode/plugin.json`

```bash
# Install the skill set from GitHub
cmd skills add vigilantshield/Claude-HunterKit -g

# Auto-install (links wordlists next to skills + wires MCP)
bash install.sh --plugin cmd

# Manual wordlist link (so wordlist_ref resolves from the skills root)
ln -s "$(pwd)/Claude-HunterKit/wordlists" ~/.commandcode/skills/wordlists
cmd mcp add chrome-devtools -- npx -y chrome-devtools-mcp@latest
```

Skills appear in `/skills`. The wordlist symlink makes each skill's `wordlist_ref: "wordlists/<domain>/..."` resolve from `~/.commandcode/skills/`.

---

## MCP Server (All Integrations)

| Server | Purpose | Command |
|--------|---------|---------|
| **chrome-devtools** | Browser automation — XSS, SSRF, OAuth verification | `npx -y chrome-devtools-mcp@latest` |

Only one MCP server is wired. Skill routing is handled by the `_hunter` orchestrator and the `CLAUDE.md` pipeline — no separate router server is needed.

---

## Pipeline (All Integrations)

Every integration follows the same 5-phase pipeline:

1. **Deep Recon** — 11 recon skills covering stack, surface, and defense
2. **Decision Matrix** — 40+ signal rules match recon findings to vuln agents
3. **Targeted Exploit** — Launch only matched skill agents
4. **Chain & Escalate** — Escalate via pre-defined chain paths
5. **Report** — Human-voice findings output

See `skills/_hunter/recon-decision-matrix.yaml` for the full decision logic.
