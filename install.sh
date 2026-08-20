#!/usr/bin/env bash
# ==============================================================================
# agy-switch Installer
# Fast Multi-Account Profile & Session Manager for Antigravity CLI (agy)
# ==============================================================================
set -e

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${CYAN}====================================================${NC}"
echo -e "${CYAN}      ✨ Installing agy-switch (Antigravity CLI)     ${NC}"
echo -e "${CYAN}====================================================${NC}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
BIN_TARGET="$HOME/.local/bin"
SKILL_TARGET="$HOME/.gemini/config/skills/switch-account"

mkdir -p "$BIN_TARGET" "$SKILL_TARGET" "$HOME/.gemini-profiles"

# 1. 安装主程序与 Skill
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/bin/agy-switch" ]; then
    echo -e "${GREEN}📦 Installing from local repository...${NC}"
    cp -f "$SCRIPT_DIR/bin/agy-switch" "$BIN_TARGET/agy-switch"
    chmod +x "$BIN_TARGET/agy-switch"
    if [ -f "$SCRIPT_DIR/skills/switch-account/SKILL.md" ]; then
        cp -f "$SCRIPT_DIR/skills/switch-account/SKILL.md" "$SKILL_TARGET/SKILL.md"
    fi
else
    echo -e "${GREEN}🌐 Installing from remote GitHub repository...${NC}"
    RAW_BASE="https://raw.githubusercontent.com/oruke/agy-switch/main"
    curl -fsSL "$RAW_BASE/bin/agy-switch" -o "$BIN_TARGET/agy-switch"
    chmod +x "$BIN_TARGET/agy-switch"
    curl -fsSL "$RAW_BASE/skills/switch-account/SKILL.md" -o "$SKILL_TARGET/SKILL.md" 2>/dev/null || true
fi

# 2. 配置 PATH 与 自动补全
COMPLETION_BLOCK='
# --- agy-switch completion ---
export PATH="$HOME/.local/bin:$PATH"

_agy_switch_complete() {
    local cur prev profiles
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    if [ "$COMP_CWORD" -eq 1 ]; then
        profiles=$(find ~/.gemini-profiles -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null)
        COMPREPLY=( $(compgen -W "list ls save new login reauth use switch rename mv delete rm whoami current session usage quota stats $profiles" -- "$cur") )
    elif [ "$prev" = "use" ] || [ "$prev" = "switch" ] || [ "$prev" = "delete" ] || [ "$prev" = "rm" ] || [ "$prev" = "rename" ] || [ "$prev" = "mv" ] || [ "$prev" = "usage" ] || [ "$prev" = "quota" ] || [ "$prev" = "login" ] || [ "$prev" = "reauth" ]; then
        profiles=$(find ~/.gemini-profiles -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null)
        COMPREPLY=( $(compgen -W "all $profiles" -- "$cur") )
    elif [ "$prev" = "session" ]; then
        COMPREPLY=( $(compgen -W "share isolate status" -- "$cur") )
    fi
}
complete -F _agy_switch_complete agy-switch 2>/dev/null || true
# -----------------------------'

for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$rc" ]; then
        sed -i '/# --- agy-switch completion/,/# -----------------------------/d' "$rc" 2>/dev/null || true
        sed -i '/# --- agy-switch completion & project wrapper ---/,/# -----------------------------------------------/d' "$rc" 2>/dev/null || true
        sed -i '/# --- agy project-scoped wrapper/,/# ----------------------------------/d' "$rc" 2>/dev/null || true
        echo "$COMPLETION_BLOCK" >> "$rc"
        echo -e "${GREEN}✅ Configured agy-switch auto-completion in $(basename "$rc")${NC}"
    fi
done

# 3. 初始化并测试
echo -e "${CYAN}🔍 Verifying installation...${NC}"
"$BIN_TARGET/agy-switch" list

echo ""
echo -e "${GREEN}🎉 agy-switch installed successfully!${NC}"
echo -e "👉 Restart your shell or run: ${YELLOW}source ~/.bashrc${NC}"
echo -e "👉 Usage help: ${YELLOW}agy-switch${NC}"
