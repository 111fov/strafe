# Strafe brand assets

Strafe's mark is three rounded diagonal bars forming an S, suggesting a smooth sideways strafe.

- `serein.svg` — black plate with the white mark; master app icon.
- `serein-flat.svg` — flat variant for small or low-colour contexts.
- `serein-mark.svg` — solid white silhouette on transparency, view box trimmed to the mark.
  `tools/generate-icons.py` rasterizes this into the shared icon atlas as `serein-mark`,
  which the interface tints at draw time.
- `serein-1024.png` — 1024×1024 sRGB render of the app icon.
- `serein-tray.png` — 72×72 white mark on transparency; hosts that recolour symbolic icons
  use `serein-mark.svg` instead.

The packaged platform icons built from the same artwork live in `packaging/` (`windows/Serein.ico`,
`linux/hicolor/*`, and macOS assets).

Brand palette: `#000000` and `#FFFFFF`. No gradients, no third-party marks.
