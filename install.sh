#!/usr/bin/env bash
set -euo pipefail

EXTDIR="$(cd "$(dirname "$0")" && pwd)"
UUID="top-window-list.molok.github.io"
SCHEMA_FILE="top-window-list.molok.github.io.gschema.xml"

TARGET_DIR="${1:-$HOME/.local/share/gnome-shell/extensions/$UUID}"

echo "==> Installing to: $TARGET_DIR"

rm -rf "$TARGET_DIR"

mkdir -p "$TARGET_DIR"
mkdir -p "$TARGET_DIR/schemas"

echo "==> Copying files..."

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

echo "==> Compiling GSettings schemas..."
glib-compile-schemas "$TARGET_DIR/schemas/"

echo "==> Installation complete"
echo ""
echo "    Restart GNOME Shell:"
echo "      - Wayland: logout/restart session"
echo "      - X11:     Alt+F2 → r → Enter"
echo ""
echo "    Then enable the extension:"
echo "      gnome-extensions enable $UUID"
echo ""
echo "    Or install system-wide (requires sudo):"
echo "      ./install.sh /usr/share/gnome-shell/extensions/$UUID"
