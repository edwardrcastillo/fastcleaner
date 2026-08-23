#!/usr/bin/env bash
# ⚡ FastCleaner 1-Line Installer for macOS & Linux
set -e

echo "=================================================================="
echo "🧹 Instalador de FastCleaner (Deep Video Metadata Sanitizer)"
echo "=================================================================="

INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"
TARGET="$INSTALL_DIR/fastcleaner"

echo "⬇️  Descargando ejecutable desde GitHub..."
curl -sSL "https://raw.githubusercontent.com/edwardrcastillo/fastcleaner/main/fastcleaner" -o "$TARGET"
chmod +x "$TARGET"

# Asegurar ~/.local/bin en el PATH
SHELL_CONFIG=""
if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "*/zsh" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ] || [ "$SHELL" = "*/bash" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
fi

if [ -n "$SHELL_CONFIG" ] && [ -f "$SHELL_CONFIG" ]; then
    if ! grep -q '\.local/bin' "$SHELL_CONFIG"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_CONFIG"
    fi
fi

# Intentar enlace simbólico en /usr/local/bin si tiene permisos
if [ -w "/usr/local/bin" ]; then
    cp "$TARGET" "/usr/local/bin/fastcleaner"
    chmod +x "/usr/local/bin/fastcleaner" 2>/dev/null || true
fi

echo "=================================================================="
echo "✅ FastCleaner instalado con éxito en: $TARGET"
echo "=================================================================="
echo "💡 Puedes usarlo directamente desde cualquier terminal:"
echo "   fastcleaner /ruta/al/video.mkv"
echo "   fastcleaner /ruta/a/la/carpeta/"
echo "   fastcleaner --gui"
echo "=================================================================="
