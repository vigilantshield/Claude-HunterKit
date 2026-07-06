#!/usr/bin/env bash
# claude-hunterKit installer — 170 offensive security skills · 1,770+ payloads
# Installs skills, wordlists, MCP server, and agent plugins.
#
# Usage:
#   bash install.sh                          # interactive (asks for target)
#   bash install.sh --target ~/.claude/skills # explicit target
#   bash install.sh --domain web              # one domain only
#   bash install.sh --plugin claude           # plugin manifest only
#   bash install.sh --mcp                     # MCP server only
#   bash install.sh --list                    # list domains
#   bash install.sh --dry-run                 # preview only
#   bash install.sh --help                    # this help

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"
WORDLISTS_DIR="$SCRIPT_DIR/wordlists"
BUG_BOUNTY_DIR="$SCRIPT_DIR/bugbounty"
PLUGIN_DIR="$SCRIPT_DIR/plugin"
DEFAULT_TARGET="${HOME}/.claude/skills/claude-hunterkit"

TARGET=""
DOMAIN=""
DRY_RUN=0
LIST_ONLY=0
INSTALL_MCP=0
PLUGIN_ONLY=""

usage() { sed -n '2,12p' "$0" | sed 's/^# //'; exit 0; }

list_domains() {
  echo "Available domains:"
  for d in "$SKILLS_DIR"/*/; do
    [ -d "$d" ] || continue
    name=$(basename "$d"); [[ "$name" == _* ]] && continue
    sc=$(find "$d" -name SKILL.md 2>/dev/null | wc -l || echo 0)
    wl_dir="$WORDLISTS_DIR/$name"
    [ -d "$wl_dir" ] && wc=$(find "$wl_dir" -name "*.txt" 2>/dev/null | wc -l || echo 0) || wc=0
    printf "  %-15s %3d skills  %3d wordlists\n" "$name" "$sc" "$wc"
  done
  bc=$(find "$BUG_BOUNTY_DIR" -name SKILL.md 2>/dev/null | wc -l)
  printf "  %-15s %3d workflows\n" "bugbounty" "$bc"
}

install_mcp() {
  echo ""
  echo "<<< MCP: Chrome DevTools >>>"
  echo "  npx -y chrome-devtools-mcp@latest"
  echo "  GitHub: https://github.com/ChromeDevTools/chrome-devtools-mcp"
  echo ""

  if command -v cmd &>/dev/null; then
    cmd mcp add claude-hunterkit -- npx -y chrome-devtools-mcp@latest 2>/dev/null && echo "  ✓ cmd" || echo "  Add MCP manually for cmd"
  fi

  for cli in claude codex gemini; do
    command -v "$cli" &>/dev/null && echo "  ✓ $cli detected — use its MCP add command"
  done
}

install_plugin_all() {
  echo ""
  echo "<<< Plugins >>>"
  mkdir -p "$TARGET"
  for src in .claude-plugin .codex-plugin .cursor-plugin; do
    [ -d "$PLUGIN_DIR/$src" ] && cp -r "$PLUGIN_DIR/$src" "$TARGET/" 2>/dev/null && echo "  ✓ $src"
  done
  [ -d "$PLUGIN_DIR/.gemini" ] && cp -r "$PLUGIN_DIR/.gemini" "$TARGET/.gemini" 2>/dev/null && echo "  ✓ .gemini"
  if [ -d "$SCRIPT_DIR/.commandcode" ]; then
    mkdir -p "$TARGET/.commandcode/skills"
    cp "$SCRIPT_DIR/.commandcode/plugin.json" "$TARGET/.commandcode/" 2>/dev/null
    cp -r "$SCRIPT_DIR/.commandcode/skills/"* "$TARGET/.commandcode/skills/" 2>/dev/null
    echo "  ✓ .commandcode"
  fi
}

copy_skills() {
  echo ""
  echo "<<< Skills >>>"
  mkdir -p "$(dirname "$TARGET")"
  if command -v rsync &>/dev/null; then
    rsync -a --info=stats1 "$SOURCE/" "$DEST/"
  else
    cp -r "$SOURCE/." "$DEST/"
  fi
  sc=$(find "$DEST" -name SKILL.md 2>/dev/null | wc -l)
  echo "  ✓ $sc skills → $DEST"
}

copy_wordlists() {
  [ -z "${WL_SOURCE:-}" ] && return
  [ ! -d "$WL_SOURCE" ] && return
  echo ""
  echo "<<< Wordlists >>>"
  mkdir -p "$(dirname "$WL_DEST")"
  cp -r "$WL_SOURCE" "$WL_DEST" 2>/dev/null
  wc=$(find "$WL_DEST" -name "*.txt" 2>/dev/null | wc -l)
  echo "  ✓ $wc payload files → $WL_DEST"
}

while [ $# -gt 0 ]; do
  case "$1" in
    --target)    TARGET="$2"; shift 2 ;;
    --domain)    DOMAIN="$2"; shift 2 ;;
    --plugin)    PLUGIN_ONLY="$2"; shift 2 ;;
    --mcp)       INSTALL_MCP=1; shift ;;
    --dry-run)   DRY_RUN=1; shift ;;
    --list)      list_domains; exit 0 ;;
    -h|--help)   usage ;;
    *)           echo "Unknown: $1"; usage ;;
  esac
done

# Plugin-only mode
if [ -n "$PLUGIN_ONLY" ]; then
  TARGET="${TARGET:-$DEFAULT_TARGET}"
  install_plugin_all
  echo "  ✓ Plugin installed for $PLUGIN_ONLY"
  exit 0
fi

# MCP-only mode
if [ "$INSTALL_MCP" -eq 1 ]; then
  install_mcp
  exit 0
fi

# ── MAIN ──
[ -t 0 ] && [ -z "$TARGET" ] && read -r -p "Install target [$DEFAULT_TARGET]: " TARGET
TARGET="${TARGET:-$DEFAULT_TARGET}"

if [ -n "$DOMAIN" ]; then
  if [ "$DOMAIN" = "bugbounty" ]; then
    [ ! -d "$BUG_BOUNTY_DIR" ] && { echo "No bugbounty dir"; exit 1; }
    SOURCE="$BUG_BOUNTY_DIR"; DEST="$TARGET/bugbounty"
  elif [ ! -d "$SKILLS_DIR/$DOMAIN" ]; then
    echo "Domain '$DOMAIN' not found"; list_domains; exit 1
  else
    SOURCE="$SKILLS_DIR/$DOMAIN"; DEST="$TARGET/$DOMAIN"
    WL_SOURCE="$WORDLISTS_DIR/$DOMAIN"; WL_DEST="$TARGET/../wordlists/$DOMAIN"
  fi
else
  SOURCE="$SKILLS_DIR"; DEST="$TARGET"
  # Copy all wordlists for full install
  WL_ALL=1
fi

echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║    claude-hunterKit Installer             ║"
echo "╚═══════════════════════════════════════════╝"
echo "  Source: $SOURCE"
echo "  Target: $DEST"
echo ""

if [ "$DRY_RUN" -eq 1 ]; then
  echo "[dry-run] Would copy:"
  find "$SOURCE" -name SKILL.md | head -20 | sed "s|^$SOURCE|  $DEST|"
  echo "  ..."
  echo ""
  echo "  Would install: MCP server + 5 agent plugins"
  exit 0
fi

copy_skills

if [ -n "${WL_ALL:-}" ]; then
  for dom in ai api auth network recon web; do
    [ -d "$WORDLISTS_DIR/$dom" ] || continue
    mkdir -p "$TARGET/../wordlists/$dom"
    cp -r "$WORDLISTS_DIR/$dom/"* "$TARGET/../wordlists/$dom/" 2>/dev/null
  done
  twc=$(find "$TARGET/../wordlists" -name "*.txt" 2>/dev/null | wc -l)
  echo "  ✓ $twc wordlist files"
else
  copy_wordlists
fi

install_mcp
install_plugin_all

echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║  ✅  Done!                               ║"
echo "║  Skills:  $TARGET           ║"
echo "║  MCP:     chrome-devtools-mcp             ║"
echo "║  Plugins: Claude · Codex · Gemini · Cursor · cmd ║"
echo "╚═══════════════════════════════════════════╝"
