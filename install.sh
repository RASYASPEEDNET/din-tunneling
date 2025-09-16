#!/bin/bash
SCRIPT_URL="https://raw.githubusercontent.com/yourrepo/script-tunnel/main/script-tunnel.sh"
INSTALL_PATH="/usr/local/bin/script-tunnel.sh"
BANNER_FILE="/etc/issue.net"

apt-get update -y
apt-get install -y curl wget vnstat htop neofetch speedtest-cli

wget -q -O $INSTALL_PATH $SCRIPT_URL
chmod +x $INSTALL_PATH

cat > $BANNER_FILE << 'EOF'
╔════════════════════════════════════════════╗
║                                            ║
║   🚀 WELCOME TO DIN-STORE TUNNEL SERVER 🚀  ║
║                                            ║
║   Managed by: script-tunnel.sh             ║
║   Powered on: Debian/Ubuntu (All OS Ready) ║
║                                            ║
╚════════════════════════════════════════════╝
EOF

echo "✅ Instalasi selesai! Jalankan dengan: script-tunnel.sh"
