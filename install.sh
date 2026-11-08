#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if [[ "${SKIP_BUILD:-0}" != "1" ]]; then
  cargo build --release --locked
fi

BIN="target/release/strafe"
[[ -x "$BIN" ]] || { echo "missing $BIN — run without SKIP_BUILD=1 first" >&2; exit 1; }

PREFIX="${HOME}/.local"
APPS="${PREFIX}/share/applications"
ICONS="${PREFIX}/share/icons/hicolor"

install -Dm755 "$BIN" "${PREFIX}/bin/strafe"
install -d "$APPS"

cat > "${APPS}/strafe.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Strafe
Comment=Native Discord client
Exec=${PREFIX}/bin/strafe
TryExec=${PREFIX}/bin/strafe
Icon=${ICONS}/256x256/apps/strafe.png
StartupWMClass=strafe
Terminal=false
Categories=Network;InstantMessaging;
EOF

cat > "${APPS}/app.strafe.client.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Strafe
NoDisplay=true
Exec=${PREFIX}/bin/strafe
Icon=${ICONS}/256x256/apps/strafe.png
StartupWMClass=strafe
Terminal=false
Categories=Network;InstantMessaging;
EOF

for size in 16 22 24 32 48 64 128 256 512 1024; do
  install -Dm644 "packaging/linux/hicolor/${size}x${size}/apps/serein.png" \
    "${ICONS}/${size}x${size}/apps/strafe.png"
done
install -Dm644 assets/brand/serein.svg "${ICONS}/scalable/apps/strafe.svg"

gtk-update-icon-cache -f -t "$ICONS" >/dev/null 2>&1 || true
update-desktop-database "$APPS" >/dev/null 2>&1 || true

echo "Installed Strafe to ${PREFIX}/bin/strafe"
echo "Launcher: ${APPS}/strafe.desktop"
