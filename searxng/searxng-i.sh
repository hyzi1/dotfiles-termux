#!/usr/bin/env bash

# Quick installation of SearXNG and themes in Termux.

# Repositories used:
# https://github.com/searxng/searxng
# https://github.com/privau/searxng

# I performed the installation in a base Termux environment, and it works perfectly. However, in similar projects, I’ve encountered errors with 'pip', and the only way I managed to fix that was by simply using 'proot-distro'.
set -e
SEARXNG_DIR="$HOME/searxng"
PRIVAU_DIR="$HOME/privau"
pkg i -y git python
if [ ! -d "$SEARXNG_DIR" ]; then
    git clone https://github.com/searxng/searxng.git "$SEARXNG_DIR"
fi
cd "$SEARXNG_DIR"
python -m venv searx1
source searx1/bin/activate
pip install --upgrade pip
pip install tzdata
pip install -r requirements.txt

#===
# Privau themes

# No point copying styles into a folder we never found.
CSSDIR=$(dirname "$(find . -name 'sxng-ltr.min.css' | head -1)")
if [ ! -f "$CSSDIR/sxng-ltr.min.css" ]; then
    echo -e "\033[31m[-] theme css not found, this searxng layout is playing tricks\033[0m"
    exit 1
fi

# Privau ships its css pre-baked.
if [ ! -d "$PRIVAU_DIR" ]; then
    git clone --depth 1 https://github.com/privau/searxng.git "$PRIVAU_DIR"
fi
cp "$PRIVAU_DIR"/out/sxng-*.min.css "$CSSDIR/"

# These three decide if the web ui even lets you pick a style.
sed -i "/'simple_style': EnumStringSetting(/,/center_alignment/ s/choices=\[\"\", \"auto\", \"light\", \"dark\", \"black\"\]/choices=[\"\", \"auto\", \"light\", \"dark\", \"black\", \"paulgo\", \"latte\", \"frappe\", \"macchiato\", \"mocha\", \"kagi\", \"brave\", \"moa\", \"night\", \"dracula\", \"gruvbox\", \"gruvboxmat\", \"everforest\", \"nord\", \"matcha\", \"evergarden\"]/" searx/preferences.py

sed -i "s/SIMPLE_STYLE = ('auto', 'light', 'dark', 'black')/SIMPLE_STYLE = ('auto', 'light', 'dark', 'black', 'paulgo', 'latte', 'frappe', 'macchiato', 'mocha', 'kagi', 'brave', 'moa', 'night', 'dracula', 'gruvbox', 'gruvboxmat', 'everforest', 'nord', 'matcha', 'evergarden')/" searx/settings_defaults.py

sed -i "s/{%- for name in \['auto', 'light', 'dark', 'black'\] -%}/{%- for name in \['auto', 'light', 'dark', 'black', 'paulgo', 'latte', 'frappe', 'macchiato', 'mocha', 'kagi', 'brave', 'moa', 'night', 'dracula', 'gruvbox', 'gruvboxmat', 'everforest', 'nord', 'matcha', 'evergarden'\] -%}/" searx/templates/simple/preferences/theme.html

for target in searx/preferences.py searx/settings_defaults.py searx/templates/simple/preferences/theme.html; do
    if ! grep -q dracula "$target"; then
        echo -e "\033[31m[-] patch missed $target, version mismatch most likely\033[0m"
        exit 1
    fi
done
#===

#===
# Secret key

# A fresh key only when the factory lock is still on, re-runs keep yours.
if grep -q 'secret_key: "ultrasecretkey"' searx/settings.yml; then
    SECRET_KEY=$(python -c "import secrets; print(secrets.token_hex(32))")
    sed -i "s/secret_key: \"ultrasecretkey\"/secret_key: \"$SECRET_KEY\"/" searx/settings.yml
fi

# If the factory key survived, something upstream changed shape.
if grep -q 'ultrasecretkey' searx/settings.yml; then
    echo -e "\033[31m[-] secret key did not take, go edit it by hand\033[0m"
    exit 1
fi
#===

#===
# Backdrop

WALLPAPER_BASE="$HOME/.config/.searxng/img"
IMG_NAME="backdrop"
SRC_IMG=""
IMG_EXT=""

for ext in jpg JPG png PNG jpeg JPEG; do
    if [ -f "$WALLPAPER_BASE.$ext" ]; then
        SRC_IMG="$WALLPAPER_BASE.$ext"
        IMG_EXT="$ext"
        break
    fi
done

if [ -n "$SRC_IMG" ]; then
    rm -f searx/static/themes/simple/img/$IMG_NAME.{jpg,JPG,png,PNG,jpeg,JPEG}
    cp "$SRC_IMG" "searx/static/themes/simple/img/$IMG_NAME.$IMG_EXT"

    # The css must match the format we actually shipped, not almost it.
    if ! grep -q "img/$IMG_NAME.$IMG_EXT" "$CSSDIR/sxng-ltr.min.css"; then
        printf '\n' >> "$CSSDIR/sxng-ltr.min.css"
        cat >> "$CSSDIR/sxng-ltr.min.css" <<EOF

/* User backdrop, appended by searxng-i.sh */
html {
  -webkit-text-size-adjust: 100%;
  -moz-text-size-adjust: 100%;
  text-size-adjust: 100%;
  color: var(--color-base-font);

  background-color: var(--color-base-background);
  background-image: url("/static/themes/simple/img/$IMG_NAME.$IMG_EXT");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  background-attachment: fixed;

  scroll-behavior: smooth;
  margin: 0;
  padding: 0;
  font-family: monospace;
  font-size: 0.9em;
}

.search_categories:hover .help {
  background-color: var(--color-base-background);
  background-image: url("/static/themes/simple/img/$IMG_NAME.$IMG_EXT");
  background-repeat: no-repeat;
  background-position: center;
  background-size: cover;
  background-attachment: fixed;
}
EOF
    fi

    echo -e "\033[35m[+] backdrop in place: $SRC_IMG\033[0m"
else
    echo -e "\033[31m[-] no wallpaper at $WALLPAPER_BASE.{jpg,png,jpeg}, backdrop skipped\033[0m"
fi
#===

#===
# Font

FONT_SRC="$HOME/.config/.searxng/font.ttf"

if [ -f "$FONT_SRC" ]; then
    mkdir -p searx/static/themes/simple/fonts
    cp "$FONT_SRC" searx/static/themes/simple/fonts/font.ttf

    if ! grep -q "fonts/font.ttf" "$CSSDIR/sxng-ltr.min.css"; then
        printf '\n' >> "$CSSDIR/sxng-ltr.min.css"
        cat >> "$CSSDIR/sxng-ltr.min.css" <<EOF

/* User font, appended by searxng-i.sh */
@font-face{font-family:"my";src:url("/static/themes/simple/fonts/font.ttf") format("truetype")}
html,pre,code{font-family:"my",monospace}
EOF
    fi

    echo -e "\033[35m[+] font in place\033[0m"
else
    echo -e "\033[31m[-] $FONT_SRC not found, font skipped\033[0m"
fi
#===

echo -e "\033[35m[+] styles landed, start the engine: python -m searx.webapp\033[0m"
