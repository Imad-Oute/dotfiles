#!/usr/bin/env bash
# Generate a theme's wallpapers with ImageMagick (they are deliberately not committed).
#   wallpapers.sh <slug> <output-dir>
# Seeded noise → visually identical on every machine.
set -euo pipefail

slug="${1:?usage: wallpapers.sh <slug> <output-dir>}"
out="${2:?usage: wallpapers.sh <slug> <output-dir>}"
mkdir -p "$out"
command -v magick >/dev/null || { echo "ImageMagick (magick) is required" >&2; exit 1; }

W=1920x1080

# mesh <out> <base> <modulate> <blur> <colour cx cy ry>...
mesh() {
    local file="$1" base="$2" mod="$3" blur="$4"; shift 4
    local args=(-seed 7 -size "$W" "xc:$base")
    while (($#)); do
        args+=( \( -size "$W" xc:none -fill "$1" -draw "circle $2,$3 $2,$4" \) -composite )
        shift 4
    done
    magick "${args[@]}" -blur "0x$blur" ${mod:+-modulate "$mod"} -attenuate 0.07 +noise Gaussian "$out/$file"
}

[[ -f "$out/.done-$slug" ]] && exit 0

case "$slug" in
glass)
    # soft light mesh (desktop in light wallbash modes) and saturated lock-style mesh
    mesh glass_light.png '#EAF1FF' ""    160 '#7CB8FF' 380 260 760  '#FF9FCB' 1500 200 640 '#C7A6FF' 1100 820 1300 '#FFD39A' 220 980 1300
    mesh glass_vivid.png '#1B2A6B' ""    170 '#0A84FF' 460 300 800  '#FF375F' 1520 260 700 '#BF5AF2' 1080 860 1340 '#FF9F0A' 1760 980 1260
    # night mesh: near-black base with deep blue/violet/magenta/teal blobs (default desktop in theme mode)
    mesh glass_dark.png  '#05060F' "82,110" 190 '#0A58D6' 420 330 760  '#6A2CD9' 1480 300 720 '#C2306E' 1180 900 1280 '#0E8AA8' 260 1000 1240
    mesh glass_night.png '#030309' "70,105" 220 '#1D3FA8' 960 540 1000 '#7B2FBE' 1500 980 1320
    ;;
blackarch)
    magick -size "$W" radial-gradient:'#0B2A3D-#000000' -gravity center -crop "$W+0+0" +repage "$out/blackarch_glow.png"
    magick -size "$W" xc:'#000000' "$out/blackarch_void.png"
    # dim wordmark for the lockscreen: needs a font file; skipped (forge falls back to the glow) if none found
    font="$(fc-match -f '%{file}' 'Inter' 2>/dev/null || true)"
    if [[ -n "$font" && -f "$font" ]]; then
        magick -size "$W" xc:black -font "$font" -pointsize 56 -fill '#1793D1' -gravity center -annotate +0+0 'arch linux' "$out/blackarch_word.png"
    fi
    ;;
*)
    echo "no wallpaper recipe for '$slug' (add one to wallpapers.sh)" >&2
    exit 0
    ;;
esac
touch "$out/.done-$slug"
echo "wallpapers: generated $slug → $out"
