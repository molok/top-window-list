#!/usr/bin/env bash
set -euo pipefail

EXTDIR="$(cd "$(dirname "$0")" && pwd)"
SCHEMA_FILE="top-window-list.molok.github.io.gschema.xml"
BUILD_DIR="$EXTDIR/_build"

echo "==> Compilando schema GSettings..."
mkdir -p "$BUILD_DIR/schemas"
cp "$EXTDIR/$SCHEMA_FILE" "$BUILD_DIR/schemas/"
glib-compile-schemas "$BUILD_DIR/schemas/"

echo "==> Verifica file JS..."
# controllo sintattico con gjs (se disponibile)
if command -v gjs &>/dev/null; then
    for js in extension.js prefs.js workspaceIndicator.js workspacePrefs.js; do
        if gjs -c "import('file://$EXTDIR/$js')" 2>&1 | grep -qv "not found"; then
            echo "  $js: OK"
        else
            echo "  $js: avviso - verifica manuale necessaria"
        fi
    done
else
    echo "  gjs non trovato, salto verifica sintassi"
fi

echo "==> Controllo integrità..."
required_files=(
    extension.js
    prefs.js
    metadata.json
    stylesheet-dark.css
    stylesheet-light.css
    stylesheet-workspace-switcher-dark.css
    stylesheet-workspace-switcher-light.css
    workspaceIndicator.js
    workspacePrefs.js
    "$SCHEMA_FILE"
)

missing=0
for f in "${required_files[@]}"; do
    if [[ ! -f "$EXTDIR/$f" ]]; then
        echo "  MANCANTE: $f"
        missing=1
    fi
done

if [[ $missing -eq 0 ]]; then
    echo "  Tutti i file richiesti presenti"
else
    echo "  ERRORE: file mancanti"
    exit 1
fi

echo "==> UUID estensione: top-window-list.molok.github.io"
echo "==> Build completata in: $BUILD_DIR"
