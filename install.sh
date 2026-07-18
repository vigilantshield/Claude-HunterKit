#!/usr/bin/env bash
# claude-hunterKit installer — 148 offensive security skills · 1,569 payload files
# Recon-first pipeline with conditional agent launch via decision matrix.
#
# Usage:
#   bash install.sh                              # integrate into ALL detected CLIs (default)
#   bash install.sh --plugin claude              # one CLI only: claude|codex|gemini|cmd
#   bash install.sh --mcp                        # wire chrome-devtools MCP into detected CLIs
#   bash install.sh --domain web                 # copy one domain's skills + wordlists to --target
#   bash install.sh --target /path --domain api  # explicit target for --domain
#   bash install.sh --list                       # list domains and plugins
#   bash install.sh --dry-run                    # preview only (no changes, no config writes)
#   bash install.sh --help                       # this help
#
# Integration model: each skill references wordlists via repo-root-relative paths
# ("wordlists/web/..."). The installer symlinks skills + wordlists as siblings into
# each CLI's skills directory so those paths resolve. Non-destructive and idempotent.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"
WORDLISTS_DIR="$SCRIPT_DIR/wordlists"
BUG_BOUNTY_DIR="$SCRIPT_DIR/bugbounty"
PLUGIN_DIR="$SCRIPT_DIR/plugin"

REPO_URL="https://github.com/vigilantshield/Claude-HunterKit"
MCP_NAME="chrome-devtools"
MCP_CMD="npx"
MCP_ARGS=(-y chrome-devtools-mcp@latest)

TARGET=""
DOMAIN=""
DRY_RUN=0
LIST_ONLY=0
INSTALL_MCP_ONLY=0
PLUGIN_ONLY=""

usage() { sed -n '2,16p' "$0" | sed 's/^# //'; exit 0; }

have() { command -v "$1" &>/dev/null; }

# ── Listing ────────────────────────────────────────────────────────────────
list_domains() {
  echo "Available domains:"
  for d in "$SKILLS_DIR"/*/; do
    [ -d "$d" ] || continue
    name=$(basename "$d"); [[ "$name" == _* ]] && continue
    sc=$(find "$d" -name SKILL.md 2>/dev/null | wc -l | tr -d ' ')
    wl_dir="$WORDLISTS_DIR/$name"
    [ -d "$wl_dir" ] && wc=$(find "$wl_dir" -name "*.txt" 2>/dev/null | wc -l | tr -d ' ') || wc=0
    printf "  %-15s %3d skills  %3d wordlists\n" "$name" "$sc" "$wc"
  done
  bc=$(find "$BUG_BOUNTY_DIR" -name SKILL.md 2>/dev/null | wc -l | tr -d ' ')
  printf "  %-15s %3d workflows\n" "bugbounty" "$bc"
}

count_manifest_skills() { # $1 = json file → number of skill entries
  [ -f "$1" ] || { echo 0; return; }
  grep -c '"name"' "$1" 2>/dev/null | tr -d ' ' || echo 0
}

list_plugins() {
  echo "Available integration plugins:"
  local cc cd gx cm
  cc=$(count_manifest_skills "$PLUGIN_DIR/.claude-plugin/plugin.json")
  cd=$(count_manifest_skills "$PLUGIN_DIR/.codex-plugin/plugin.json")
  cm=$(count_manifest_skills "$SCRIPT_DIR/.commandcode/plugin.json")
  echo "  claude          Claude Code   — ${cc} curated skills, symlink + chrome-devtools MCP"
  echo "  codex           Codex CLI     — ${cd} curated skills (marketplace), chrome-devtools MCP"
  echo "  gemini          Gemini CLI    — extension link + chrome-devtools MCP"
  echo "  cmd             Command Code  — ${cm} curated skills, wordlist link + chrome-devtools MCP"
  echo ""
  echo "  MCP server wired: chrome-devtools (npx -y chrome-devtools-mcp@latest)"
  echo "  Total: 4 integration plugins (claude, codex, gemini, cmd)"
}

# ── Symlink helper (idempotent, non-destructive) ───────────────────────────
lnk() { # lnk <src> <dest>
  local src="$1" dest="$2"
  if [ "$DRY_RUN" -eq 1 ]; then
    if [ -L "$dest" ]; then echo "  [dry-run] keep $dest → $(readlink "$dest" 2>/dev/null)"
    elif [ -e "$dest" ]; then echo "  [dry-run] $dest exists (not a symlink) — would skip"
    else echo "  [dry-run] would link $dest → $src"; fi
    return 0
  fi
  if [ -L "$dest" ]; then
    local cur; cur="$(readlink "$dest" || true)"
    if [ "$cur" = "$src" ]; then echo "  ✓ $dest (already linked)"; return 0; fi
    echo "  ! $dest → $cur (expected $src) — left as-is"; return 0
  fi
  if [ -e "$dest" ]; then echo "  ! $dest exists (not a symlink) — skipping to avoid clobber"; return 0; fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest" && echo "  ✓ $dest → $src"
}

# ── MCP wiring (idempotent; only real server: chrome-devtools) ─────────────
mcp_has() { # mcp_has <cli> <name>
  case "$1" in
    claude) claude mcp list 2>/dev/null | grep -q "^$2:" ;;
    cmd)    cmd mcp list 2>/dev/null | grep -q "$2" ;;
    codex)  codex mcp list 2>/dev/null | grep -q "^$2 " ;;
    gemini) gemini mcp list 2>&1 | grep -q "$2" ;;
  esac
}

mcp_add() { # mcp_add <cli>
  case "$1" in
    claude) claude mcp add --scope user "$MCP_NAME" -- "$MCP_CMD" "${MCP_ARGS[@]}" ;;
    cmd)    cmd mcp add "$MCP_NAME" -- "$MCP_CMD" "${MCP_ARGS[@]}" ;;
    codex)  codex mcp add "$MCP_NAME" -- "$MCP_CMD" "${MCP_ARGS[@]}" ;;
    gemini) gemini mcp add -s user "$MCP_NAME" "$MCP_CMD" "${MCP_ARGS[@]}" ;;
  esac
}

wire_mcp() { # wire_mcp <cli>
  have "$1" || { echo "  ($1 not found on PATH — skipping MCP)"; return 0; }
  if [ "$DRY_RUN" -eq 1 ]; then echo "  [dry-run] would wire $MCP_NAME into $1"; return 0; fi
  if mcp_has "$1" "$MCP_NAME"; then echo "  ✓ $1: $MCP_NAME already configured"; return 0; fi
  if mcp_add "$1" >/dev/null 2>&1; then echo "  ✓ $1: $MCP_NAME added"; else echo "  ! $1: failed to add $MCP_NAME (add manually)"; fi
}

# ── Per-CLI integration ────────────────────────────────────────────────────
install_claude() {
  echo "<<< Claude Code >>>"
  have claude || { echo "  (claude not found — skipping)"; return 0; }
  lnk "$SKILLS_DIR"     "$HOME/.claude/skills/claude-hunterkit"
  lnk "$WORDLISTS_DIR"  "$HOME/.claude/skills/wordlists"
  lnk "$BUG_BOUNTY_DIR" "$HOME/.claude/skills/bugbounty"
  echo "  Project .mcp.json at repo root auto-loads chrome-devtools when cwd is the repo."
  wire_mcp claude
}

install_cmd() {
  echo "<<< Command Code (cmd) >>>"
  have cmd || { echo "  (cmd not found — skipping)"; return 0; }
  echo "  cmd skills are installed individually via: cmd skills add vigilantshield/Claude-HunterKit -g"
  echo "  Linking wordlists next to installed skills so wordlist_ref paths resolve:"
  lnk "$WORDLISTS_DIR" "$HOME/.commandcode/skills/wordlists"
  wire_mcp cmd
}

install_codex() {
  echo "<<< Codex CLI >>>"
  have codex || { echo "  (codex not found — skipping)"; return 0; }
  wire_mcp codex
  echo "  Codex loads plugins from a marketplace snapshot, not local skill folders."
  echo "  Use skills by referencing: $SKILLS_DIR/<domain>/<skill>/SKILL.md"
  echo "  Publish to marketplace via plugin/.codex-plugin/plugin.json"
}

install_gemini() {
  echo "<<< Gemini CLI >>>"
  have gemini || { echo "  (gemini not found — skipping)"; return 0; }
  if [ ! -f "$SCRIPT_DIR/gemini-extension.json" ]; then
    echo "  ! gemini-extension.json missing at repo root — cannot link extension"
  elif [ "$DRY_RUN" -eq 1 ]; then
    echo "  [dry-run] would link extension $SCRIPT_DIR"
  elif gemini extensions list 2>&1 | grep -qi "claude-hunterkit"; then
    echo "  ✓ gemini extension claude-hunterkit already linked"
  elif gemini extensions link "$SCRIPT_DIR" --consent >/dev/null 2>&1; then
    echo "  ✓ gemini extension linked ($SCRIPT_DIR)"
  elif gemini extensions list 2>&1 | grep -qi "claude-hunterkit"; then
    echo "  ✓ gemini extension linked ($SCRIPT_DIR)"
  else
    echo "  ! gemini extensions link failed — run: gemini extensions link \"$SCRIPT_DIR\" --consent"
  fi
  wire_mcp gemini
}

install_mcp_all() {
  echo "<<< MCP: chrome-devtools >>>"
  echo "  $MCP_CMD ${MCP_ARGS[*]}"
  wire_mcp claude
  wire_mcp cmd
  wire_mcp codex
  wire_mcp gemini
}

install_all() {
  install_claude
  echo ""
  install_cmd
  echo ""
  install_codex
  echo ""
  install_gemini
}

# ── Domain copy mode (skills + wordlists as siblings under --target) ───────
copy_domain() {
  [ -z "$DOMAIN" ] && return 0
  [ -z "$TARGET" ] && { echo "--domain requires --target"; exit 1; }
  if [ "$DOMAIN" = "bugbounty" ]; then
    [ ! -d "$BUG_BOUNTY_DIR" ] && { echo "No bugbounty dir"; exit 1; }
    local src="$BUG_BOUNTY_DIR" dst="$TARGET/bugbounty"
  elif [ ! -d "$SKILLS_DIR/$DOMAIN" ]; then
    echo "Domain '$DOMAIN' not found"; list_domains; exit 1
  else
    local src="$SKILLS_DIR/$DOMAIN" dst="$TARGET/$DOMAIN"
  fi
  echo "  Source: $src"
  echo "  Target: $dst"
  [ "$DRY_RUN" -eq 1 ] && { echo "[dry-run] would copy $src → $dst"; return 0; }
  mkdir -p "$dst"
  cp -r "$src/." "$dst/"
  local sc; sc=$(find "$dst" -name SKILL.md 2>/dev/null | wc -l | tr -d ' ')
  echo "  ✓ $sc skills → $dst"
  # wordlists as a sibling under $TARGET so wordlist_ref resolves from $TARGET
  if [ -d "$WORDLISTS_DIR/$DOMAIN" ]; then
    local wldst="$TARGET/wordlists/$DOMAIN"
    mkdir -p "$wldst"
    cp -r "$WORDLISTS_DIR/$DOMAIN/." "$wldst/"
    local wc_; wc_=$(find "$wldst" -name "*.txt" 2>/dev/null | wc -l | tr -d ' ')
    echo "  ✓ $wc_ wordlist files → $wldst"
  fi
}

# ── Args ───────────────────────────────────────────────────────────────────
while [ $# -gt 0 ]; do
  case "$1" in
    --target)    TARGET="$2"; shift 2 ;;
    --domain)    DOMAIN="$2"; shift 2 ;;
    --plugin)    PLUGIN_ONLY="$2"; shift 2 ;;
    --mcp)       INSTALL_MCP_ONLY=1; shift ;;
    --dry-run)   DRY_RUN=1; shift ;;
    --list)      list_domains; echo ""; list_plugins; exit 0 ;;
    -h|--help)   usage ;;
    *)           echo "Unknown: $1"; usage ;;
  esac
done

# ── Dispatch ───────────────────────────────────────────────────────────────
echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║    claude-hunterKit Installer             ║"
echo "╚═══════════════════════════════════════════╝"
echo "  Repo: $SCRIPT_DIR"
[ "$DRY_RUN" -eq 1 ] && echo "  Mode: DRY-RUN (no changes)"
echo ""

if [ -n "$DOMAIN" ]; then
  copy_domain
  echo ""
  echo "✅ Domain '$DOMAIN' copied to $TARGET"
  exit 0
fi

if [ "$INSTALL_MCP_ONLY" -eq 1 ]; then
  install_mcp_all
  exit 0
fi

case "$PLUGIN_ONLY" in
  claude)  install_claude ;;
  cmd)     install_cmd ;;
  codex)   install_codex ;;
  gemini)  install_gemini ;;
  "")      install_all ;;
  *)       echo "Unknown plugin: $PLUGIN_ONLY (use claude|codex|gemini|cmd)"; exit 1 ;;
esac

echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║  ✅  Done                                  ║"
echo "║  Skills:  148 · Wordlists: 1,569 payloads  ║"
echo "║  MCP:     chrome-devtools                  ║"
echo "║  Pipeline: recon-first with decision matrix║"
echo "╚═══════════════════════════════════════════╝"
echo "  Verify: bash install.sh --list"
