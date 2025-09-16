#!/bin/bash
INSTALL_PATH="/usr/local/bin/script-tunnel.sh"

echo "⚠️ Rebuild Script Tunnel"
read -p "Lanjutkan? (y/n): " jawab
if [[ "$jawab" != "y" ]]; then
    echo "❌ Rebuild dibatalkan."
    exit 1
fi

rm -f $INSTALL_PATH
bash <(curl -s https://raw.githubusercontent.com/yourrepo/script-tunnel/main/install.sh)

echo "✅ Rebuild selesai. Jalankan ulang: script-tunnel.sh"
