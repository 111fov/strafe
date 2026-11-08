#!/bin/sh
# Install the portable Linux release into the current user's home.
set -eu
cd "$(dirname "$0")"

PREFIX="${HOME}/.local"
APPS="${PREFIX}/share/applications"
ICONS="${PREFIX}/share/icons/hicolor"

if [ "$(id -u)" -eq 0 ]; then
    echo "Run this as your normal user, not root." >&2
    exit 1
fi

install -Dm755 strafe "${PREFIX}/bin/strafe"
install -Dm644 strafe.desktop "${APPS}/app.strafe.client.desktop"
sed -i "s|^Exec=.*|Exec=${PREFIX}/bin/strafe|" "${APPS}/app.strafe.client.desktop"

for source in icons/hicolor/*/apps/strafe.png; do
    [ -f "$source" ] || continue
    size=$(basename "$(dirname "$(dirname "$source")")")
    install -Dm644 "$source" "${ICONS}/${size}/apps/strafe.png"
done
install -Dm644 icons/hicolor/scalable/apps/strafe.svg "${ICONS}/scalable/apps/strafe.svg"

gtk-update-icon-cache -f -t "${ICONS}" >/dev/null 2>&1 || true
update-desktop-database "${APPS}" >/dev/null 2>&1 || true

echo "Installed Strafe to ${PREFIX}/bin/strafe"
echo "Launch it from your app menu or run ${PREFIX}/bin/strafe"
