# QGIS "Spatial without Compromise" Plymouth Theme

A QGIS-branded boot splash for NixOS, styled after the QGIS.ORG keynote
title slide:

- a dark navy hand-drawn cartographic backdrop,
- the **Spatial without Compromise** strapline and understrapline
  ("Spatial visualization and decision-making tools for everyone"),
- the QGIS "Q" globe breathing gently on the right,
- a QGIS-green boot progress bar and a ZFS password prompt.

## Regenerating the artwork

All raster assets under `images/` are generated from the small set of
source images in `source/`:

```bash
./generate-assets.sh
```

The script needs ImageMagick 7 (`magick`) and the Open Sans font family.
On a host where fontconfig is unusual you can point it at the fonts
explicitly:

```bash
OPEN_SANS_LIGHT=/path/OpenSans-Light.ttf \
OPEN_SANS_REGULAR=/path/OpenSans-Regular.ttf \
./generate-assets.sh
```

Commit the regenerated PNGs so the Nix build never runs ImageMagick.

## Credits

Script structure adapted from the Kartoza Plymouth theme, itself derived
from <https://github.com/Hugopikachu/plymouth-theme-chain>.

Made with 💗 by [Kartoza](https://kartoza.com).
