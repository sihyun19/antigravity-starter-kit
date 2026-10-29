#!/usr/bin/env bash
set -e

echo "============================================="
echo "   Antigravity Starter Kit Installation"
echo "============================================="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEMINI_ROOT="$HOME/.gemini"
CONFIG_DIR="$GEMINI_ROOT/config"
SKILLS_DIR="$CONFIG_DIR/skills"
BACKUP_DIR="$GEMINI_ROOT/backup_$(date +%Y%m%d_%H%M%S)"

mkdir -p "$SKILLS_DIR"

if [ -f "$GEMINI_ROOT/GEMINI.md" ]; then
    echo "[1/3] Existing GEMINI.md found. Creating backup..."
    mkdir -p "$BACKUP_DIR"
    cp "$GEMINI_ROOT/GEMINI.md" "$BACKUP_DIR/GEMINI.md"
fi

echo "[2/3] Installing GEMINI.md..."
cp "$SCRIPT_DIR/GEMINI.md" "$GEMINI_ROOT/GEMINI.md"

echo "[2/3] Installing config.json..."
cp "$SCRIPT_DIR/config/config.json" "$CONFIG_DIR/config.json"

echo "[3/3] Installing skills..."
cp -R "$SCRIPT_DIR/config/skills/"* "$SKILLS_DIR/"

echo "============================================="
echo " [Success] Antigravity setup complete!"
echo " Please reload/restart Antigravity."
echo "============================================="
