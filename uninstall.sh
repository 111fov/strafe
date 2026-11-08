#!/usr/bin/env bash
set -euo pipefail

PREFIX="${HOME}/.local"
APPS="${PREFIX}/share/applications"
ICONS="${PREFIX}/share/icons/hicolor"

rm -f "${PREFIX}/bin/strafe"
rm -f "${APPS}/app.strafe.client.desktop"
for size in 16 22 24 32 48 64 128 256 512 1024; do
  rm -f "${ICONS}/${size}x${size}/apps/strafe.png"
done
rm -f "${ICONS}/scalable/apps/strafe.svg"

gtk-update-icon-cache -f -t "$ICONS" >/dev/null 2>&1 || true
update-desktop-database "$APPS" >/dev/null 2>&1 || true

echo "Removed the Strafe binary, launcher and icons."
echo "Account data in ~/.local/share/strafe-development was kept."
