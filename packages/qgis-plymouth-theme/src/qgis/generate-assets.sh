#!/usr/bin/env bash
# Regenerate every raster asset for the QGIS Plymouth theme from the
# small set of source images in ./source.
#
# The look & feel is lifted from the QGIS.ORG "Spatial without
# Compromise" keynote title slide:
#   * a dark navy hand-drawn cartographic background,
#   * the "Spatial without Compromise" strapline (thin Open Sans Light),
#   * the QGIS "Q" globe on the right (rendered as a gently pulsing
#     Plymouth sprite — see qgis.script),
#   * a QGIS-green boot progress bar.
#
# Everything this script emits is committed to git so the Nix build
# never has to run ImageMagick.  Re-run it only when you change the
# design, then commit the regenerated PNGs.
#
# Requires: ImageMagick 7 (`magick`) and the Open Sans font family.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src="$here/source"
img="$here/images"
anim="$img/animation"
mkdir -p "$img" "$anim"

# ---- Palette (sampled from the keynote title slide) -----------------
NAVY="#0e2230"      # base background navy
INK_L="rgba(6,20,30,0.92)"   # left legibility gradient (opaque -> clear)
INK_R="rgba(6,20,30,0.0)"
INK_BT="rgba(6,18,26,0.0)"    # bottom vignette (clear -> dark)
INK_BB="rgba(6,18,26,0.55)"
WHITE="#ffffff"
MUTE="#aab8c0"      # understrapline grey-blue
GREEN="#93b02a"     # QGIS flag green — progress bar fill

# ---- Fonts ----------------------------------------------------------
# Resolve the Open Sans family in a host-agnostic way.  Prefer explicit
# env overrides (handy in minimal shells where fontconfig isn't wired
# up), then fontconfig, then a best-effort glob of the font dirs.
find_font() {
  local style="$1" envvar="$2" hit
  hit="${!envvar:-}"
  [ -n "$hit" ] && [ -f "$hit" ] && { echo "$hit"; return; }
  # fc-match, but only trust it if it actually resolved an Open Sans
  # face (a mis-configured fontconfig silently returns a default font).
  hit="$(fc-match -f '%{file}' "Open Sans:style=$style" 2>/dev/null || true)"
  case "$hit" in
    *OpenSans-"$style".ttf) [ -f "$hit" ] && { echo "$hit"; return; } ;;
  esac
  # -print -quit: stop at the first match instead of scanning the whole
  # /nix/store (which is huge) — only reached when fontconfig is broken.
  hit="$(find /run/current-system/sw/share/X11/fonts /nix/store \
    -maxdepth 6 -name "OpenSans-${style}.ttf" -print -quit 2>/dev/null)"
  [ -n "$hit" ] && { echo "$hit"; return; }
  echo "ERROR: Open Sans $style not found (set $envvar)" >&2; exit 1
}
LIGHT="$(find_font Light OPEN_SANS_LIGHT)"
REG="$(find_font Regular OPEN_SANS_REGULAR)"

# ---- PNG compressor -------------------------------------------------
# The navy cartographic background is a 1920x1080 photographic texture;
# as a 32-bit RGBA PNG it weighs ~4 MB, over the repo's 1 MB pre-commit
# ceiling.  Re-encode it as an 8-bit, non-interlaced TRUECOLOR
# (color-type 2) PNG: stripping the alpha channel and metadata brings
# this dark, mostly-smooth artwork down to ~0.8 MB with no visible
# quality loss.  Truecolor (not palette) is deliberate — it keeps the
# asset in the same format GRUB's minimal PNG decoder accepts, so the
# generator stays reusable across both the Plymouth and GRUB themes.
compress_png() {
  local f="$1"
  magick "$f" -strip -interlace none -alpha off \
    -define png:color-type=2 -define png:bit-depth=8 \
    -define png:compression-level=9 "$f.tmp.png"
  mv -f "$f.tmp.png" "$f"
}

# ---- 1. Navy cartographic background (1920x1080) --------------------
# Cover-scale the map strip, drop it onto a navy canvas, darken it so
# the linework reads as a subtle texture, then add a left gradient (for
# strapline legibility) and a soft bottom vignette (for the progress
# stack).
magick "$src/qgis-map-background.webp" -resize 1920x1080^ -gravity center \
  -extent 1920x1080 "$img/.map-cover.png"
magick -size 1920x1080 xc:"$NAVY" \
  \( "$img/.map-cover.png" -modulate 78,90,100 \) -composite \
  "$img/.map-base.png"
magick -size 1920x1080 gradient:"${INK_L}-${INK_R}" "$img/.lgrad.png"
magick -size 1920x1080 gradient:"${INK_BT}-${INK_BB}" "$img/.bgrad.png"
magick "$img/.map-base.png" "$img/.lgrad.png" -composite \
  "$img/.bgrad.png" -composite "$img/.map-bg.png"

# ---- 2. Strapline text ---------------------------------------------
magick -background none -fill "$WHITE" -font "$LIGHT" -pointsize 96 \
  -interline-spacing 6 label:"Spatial without\nCompromise" "$img/.title.png"
magick -background none -fill "$MUTE" -font "$REG" -pointsize 30 \
  label:"Spatial visualization and decision-making tools for everyone" \
  "$img/.understrap.png"

# ---- 3. background.png: map + baked strapline (logo is a sprite) ----
magick "$img/.map-bg.png" \
  "$img/.title.png"      -gravity NorthWest -geometry +115+330 -composite \
  "$img/.understrap.png" -gravity NorthWest -geometry +120+650 -composite \
  "$img/background.png"
compress_png "$img/background.png"

# ---- 4. Pulsing QGIS "Q" animation frames --------------------------
# A calm opacity breathe (0.82 -> 1.0 -> 0.82) over 60 frames.  The Q
# stays a constant size so it never jitters; qgis.script recentres each
# frame by width, so identical dimensions keep it rock-steady.
magick "$src/qgis-q.png" -resize x360 "$img/.q360.png"
frames=60
python3 - "$frames" <<'PY' > "$img/.opacities"
import math, sys
n = int(sys.argv[1])
for i in range(n):
    # sine breathe between 0.82 and 1.0
    o = 0.82 + 0.18 * (0.5 - 0.5 * math.cos(2 * math.pi * i / n))
    print(f"{o:.4f}")
PY
i=0
while IFS= read -r op; do
  magick "$img/.q360.png" -channel A -evaluate multiply "$op" +channel \
    "$anim/qgis-plymouth.${i}.png"
  i=$((i + 1))
done < "$img/.opacities"

# ---- 5. Progress bar (navy trough + QGIS-green fill) ---------------
magick -size 512x6 xc:"rgba(255,255,255,0.14)" "$img/bar-background.png"
magick -size 512x6 xc:"$GREEN" "$img/bar-progress.png"

# ---- 6. Password entry pill + lock (QGIS-green tinted) -------------
# Rounded translucent pill for the ZFS password entry.
magick -size 512x64 xc:none -fill "rgba(255,255,255,0.10)" \
  -draw "roundrectangle 0,0 511,63 20,20" \
  -stroke "rgba(147,176,42,0.55)" -strokewidth 2 -fill none \
  -draw "roundrectangle 1,1 510,62 20,20" "$img/input.png"
# Simple padlock glyph in QGIS green.
magick -size 128x128 xc:none -stroke "$GREEN" -strokewidth 8 -fill none \
  -draw "arc 40,26 88,86 180,360" \
  -fill "$GREEN" -stroke none \
  -draw "roundrectangle 30,60 98,112 10,10" \
  -fill "$NAVY" -draw "circle 64,82 64,94" \
  -draw "rectangle 61,82 67,100" "$img/lock.png"

# ---- 7. Tidy up intermediates --------------------------------------
rm -f "$img"/.*.png "$img/.opacities" 2>/dev/null || true

echo "QGIS Plymouth assets regenerated in $img"
