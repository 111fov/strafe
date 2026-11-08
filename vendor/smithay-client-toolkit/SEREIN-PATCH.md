# smithay-client-toolkit patch

Strafe on ChromeOS/Crostini: ChromeOS exports `XCURSOR_SIZE` as the **physical** cursor size
(38 at a 2× display scale) and `XCURSOR_SIZE_LOW_DENSITY` as the **logical** size (19).

SCTK treats `XCURSOR_SIZE` as logical and multiplies it by the output scale, so the pointer is
drawn at double size inside Wayland apps — large in the app, normal on the rest of the desktop.

`Themes::new` now prefers `XCURSOR_SIZE_LOW_DENSITY` when it is present and non-zero. Desktops
without that variable keep the upstream behaviour exactly.

Upstream: smithay-client-toolkit 0.19.2.
