#!/bin/bash
BANNER_FILE="/etc/issue.net"

set_box() {
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
}

set_logo() {
cat > $BANNER_FILE << 'EOF'
██████╗ ██╗███╗   ██╗    ███████╗████████╗ ██████╗ ██████╗ ███████╗
██╔══██╗██║████╗  ██║    ██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝
██████╔╝██║██╔██╗ ██║    ███████╗   ██║   ██║   ██║██████╔╝█████╗  
██╔═══╝ ██║██║╚██╗██║    ╚════██║   ██║   ██║   ██║██╔══██╗██╔══╝  
██║     ██║██║ ╚████║    ███████║   ██║   ╚██████╔╝██║  ██║███████╗
╚═╝     ╚═╝╚═╝  ╚═══╝    ╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝

              🚀 DIN-STORE TUNNEL SERVER 🚀
EOF
}

set_minimal() {
cat > $BANNER_FILE << 'EOF'
=========================================
    🚀 DIN-STORE TUNNEL SERVER 🚀
-----------------------------------------
 Managed by: script-tunnel.sh
 Powered on: Debian/Ubuntu (All OS Ready)
=========================================
EOF
}

case "$1" in
    set)
        cat > $BANNER_FILE
        ;;
    add)
        read text
        echo "$text" >> $BANNER_FILE
        ;;
    clear)
        > $BANNER_FILE
        ;;
    show)
        cat $BANNER_FILE
        ;;
    choose)
        echo " (1) Box Simple"
        echo " (2) ASCII Logo Besar"
        echo " (3) Minimalis Clean"
        read -p "Pilih varian: " choice
        case $choice in
            1) set_box ;;
            2) set_logo ;;
            3) set_minimal ;;
        esac
        ;;
    random)
        rand=$((1 + RANDOM % 3))
        case $rand in
            1) set_box ;;
            2) set_logo ;;
            3) set_minimal ;;
        esac
        ;;
    *)
        echo "Gunakan: $0 {set|add|clear|show|choose|random}"
        ;;
esac
