# Strafe

Strafe is a personal fork of [Serein](https://github.com/ViceVerse-cz/Serein): a native,
GPU-accelerated Discord client written in Rust with egui/wgpu.

The goal is the familiar Discord layout with a calmer, rounder, less cluttered look and a
much smaller resource footprint than the Electron client.

## What this fork changes

- Product name, window title, app ID (`app.strafe.client`) and data directory (`strafe-development`)
  are Strafe. The internal crate/binary is still named `serein` so upstream patches stay easy to apply.
- Member lists start collapsed, giving chat more room on first launch.
- The bundled **Strafe** theme uses a Discord-familiar palette with larger corner radii,
  tighter spacing and flat surfaces.
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

## Theme

The theme package is [`extensions/themes/strafe.serein-extension`](../extensions/themes/strafe.serein-extension).
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

### ChromeOS/Crostini audio

Crostini exposes one virtual sound card (`Virtio 1.0 sound Stereo`). ChromeOS chooses whether that
goes to the built-in speakers, the headphone jack or Bluetooth; Linux never sees those as separate
devices, so the picker cannot list “Headphones” inside the container.

Microphone access is a ChromeOS permission. If the mic meter stays at -100 dBFS while you speak,
open ChromeOS Settings → About ChromeOS → Developers → Linux development environment and enable
**Microphone**, then restart Strafe. The capture source exists either way, but ChromeOS feeds it
silence until the permission is on.
