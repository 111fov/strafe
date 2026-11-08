# Strafe

Strafe is a personal fork of [Serein](https://github.com/ViceVerse-cz/Serein): a native,
GPU-accelerated Discord client written in Rust with egui/wgpu.

The goal is the familiar Discord layout with a calmer, rounder, less cluttered look and a
much smaller resource footprint than the Electron client.

## What this fork changes

- Product name, package and binary (`strafe`), window title, app ID (`app.strafe.client`) and
  data directory (`strafe-development`) are Strafe.
- Member lists start collapsed, giving chat more room on first launch.
- The bundled **Strafe Black** theme is true black with minimal colour: white accent, desaturated
  status colours, 10 px controls and a 16 px window radius.
- macOS-style traffic lights replace the GTK header-bar buttons on Linux.
- Upstream release auto-updates are disabled: this fork must never silently replace itself
  with an upstream Serein build.

## Running

```sh
# Debian/Ubuntu build dependencies
sudo apt install libwebkitgtk-6.0-dev libgtk-4-dev libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev libpulse-dev libasound2-dev cmake clang \
  libxkbcommon-dev libwayland-dev libx11-xcb-dev libvulkan-dev libfreetype-dev \
  libfontconfig1-dev pkg-config

cargo run --locked
```

The first build takes a few minutes. Data lives in `~/.local/share/strafe-development`.
Set `STRAFE_DATA_DIR` to use an isolated profile.

## Installing

```sh
./install.sh          # build, install to ~/.local/bin, register the launcher and icons
./uninstall.sh        # remove the binary, launcher and icons (data is kept)
```

The launcher uses `~/.local/bin/strafe`, so the build directory can be cleaned afterwards.

## Theme

The theme package is [`extensions/themes/strafe.serein-extension`](extensions/themes/strafe.serein-extension).
`cargo test -p extensions --test strafe_theme` validates it against the current schema.

To change it live, edit the package, then replace the copy installed under
`~/.local/share/strafe-development/extensions/themes/strafe/package.json` (the stored file wraps
the package with its hash) and restart Strafe. Radius, spacing, typography and colors are
documented in [`docs/theme-api.md`](theme-api.md).

## Keeping up with upstream

```sh
git fetch upstream
git switch strafe
git rebase upstream/main
```

The rebrand touches many display strings, so expect conflicts there; resolve them by keeping the
Strafe wording. Protocol, voice and rendering fixes should be accepted from upstream as-is.

## Notes

- This is an unofficial client. Automating a normal account outside Discord's OAuth2/bot API
  violates Discord's Terms of Service and carries a risk of account termination.
- Voice, screen sharing and camera capture depend on the platform and are tested on Linux/Wayland first.
