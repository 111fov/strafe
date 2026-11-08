# smithay-client-toolkit patch

Some environments export `XCURSOR_SIZE` as the **physical** cursor size and the
**logical** size in `XCURSOR_SIZE_LOW_DENSITY`.

SCTK treats `XCURSOR_SIZE` as logical and multiplies it by the output scale, which can
draw a double-size pointer on scale-2 outputs.

`Themes::new` prefers `XCURSOR_SIZE_LOW_DENSITY` when it is present and non-zero.
Environments without that variable keep the upstream behaviour exactly.

Upstream: smithay-client-toolkit 0.19.2.
