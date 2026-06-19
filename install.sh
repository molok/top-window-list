#!/usr/bin/env bash
set -euo pipefail

EXTDIR="$(cd "$(dirname "$0")" && pwd)"
UUID="top-window-list.molok.github.io"
SCHEMA_FILE="top-window-list.molok.github.io.gschema.xml"

TARGET_DIR="${1:-$HOME/.local/share/gnome-shell/extensions/$UUID}"

echo "==> Installazione in: $TARGET_DIR"

mkdir -p "$TARGET_DIR"
mkdir -p "$TARGET_DIR/schemas"

echo "==> Copia file..."

cp -v "$EXTDIR"/extension.js \
      "$EXTDIR"/prefs.js \
      "$EXTDIR"/metadata.json \
      "$EXTDIR"/stylesheet-dark.css \
      "$EXTDIR"/stylesheet-light.css \
      "$EXTDIR"/stylesheet-workspace-switcher-dark.css \
      "$EXTDIR"/stylesheet-workspace-switcher-light.css \
      "$EXTDIR"/workspaceIndicator.js \
      "$EXTDIR"/workspacePrefs.js \
      "$TARGET_DIR/"

cp -v "$EXTDIR/$SCHEMA_FILE" "$TARGET_DIR/schemas/"

echo "==> Compilazione schemi GSettings..."
glib-compile-schemas "$TARGET_DIR/schemas/"

echo "==> Installazione completata"
echo ""
echo "    Riavvia GNOME Shell:"
echo "      - Wayland: logout/riavvia sessione"
echo "      - X11:     Alt+F2 → r → Invio"
echo ""
echo "    Poi abilita l'estensione:"
echo "      gnome-extensions enable $UUID"
echo ""
echo "    Oppure installa come sistema (richiede sudo):"
echo "      ./install.sh /usr/share/gnome-shell/extensions/$UUID"
