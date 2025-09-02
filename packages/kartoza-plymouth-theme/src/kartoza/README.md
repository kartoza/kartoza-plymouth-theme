# Kartoza Theme by Tim

Based on work by <https://github.com/Hugopikachu/plymouth-theme-chain>

I used their script to assign Kartoza colours:

```bash
nix-shell -p bc
./change-color.sh background "#FFFFFF"
./change-color.sh main "#DF9E2F"
./change-color.sh secondary "#569FC6"
```

## Animation Scaling

The theme now includes automatic scaling to fit different screen resolutions. The scaling behavior can be configured in `kartoza.script`:

- `LOGO.max_height_percent`: Maximum animation height as percentage of screen height (default: 0.4 = 40%)
- `LOGO.max_width_percent`: Maximum animation width as percentage of screen width (default: 0.4 = 40%)
- `LOGO.keep_aspect_ratio`: Whether to maintain aspect ratio when scaling (1 = yes, 0 = no)
- `LOGO.min_size`: Minimum size in pixels to prevent animations from becoming too small on large screens (default: 200)

## Image Requirements

Images must be 1920x1080 for optimal quality, but the theme will automatically scale them to fit different screen resolutions while maintaining aspect ratio.

Render with synfig then use the rename script to remove trailing zeros from
sequence numbers.
