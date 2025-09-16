#!/bin/bash
# ================================================
#  TUNNEL MANAGEMENT SCRIPT
#  Support: Debian/Ubuntu (extendable to all OS)
#  Author: DIN-STORE
# ================================================

DB_FILE="/usr/local/bin/users.db"
DOMAIN_FILE="/usr/local/bin/domain.conf"
WHITELIST_FILE="/usr/local/bin/whitelist.conf"

# =================== FUNGSI DASHBOARD ===================
show_status() {
    CLIENT="DIN-STORE"
    OS=$(lsb_release -d | awk -F"\t" '{print $2}')
    RAM=$(free -m | awk 'NR==2{print $2}')
    UPTIME=$(uptime -p | cut -d " " -f 2-)
    IP=$(curl -s ifconfig.me)
    ISP=$(curl -s ipinfo.io/org)
    EXPIRED="30 Day"

    if [ -f "$DOMAIN_FILE" ]; then
        DOMAIN=$(cat $DOMAIN_FILE)
    else
        DOMAIN="Belum diset"
    fi

    RX=$(vnstat -i eth0 --oneline | awk -F\; '{print $10}')
    TX=$(vnstat -i eth0 --oneline | awk -F\; '{print $11}')
    TODAY=$(vnstat -i eth0 --oneline | awk -F\; '{print $9}')
    MONTH=$(vnstat -i eth0 --oneline | awk -F\; '{print $8}')
    SPEED="0.00 Mbps"

    ACC_SSH=$(grep -c "ACTIVE" $DB_FILE 2>/dev/null)
    ACC_XRAY=25

    clear
    echo "════════════════════════════════════════════════════════════"
    echo " CLIENTS : $CLIENT          OS     : $OS"
    echo " RAM     : ${RAM} MB        UPTIME : $UPTIME"
    echo " IP      : $IP        ISP    : $ISP"
    echo " EXPIRED : $EXPIRED   DOMAIN : $DOMAIN"
    echo " RX      : $RX        LAST   : $MONTH"
    echo " TX      : $TX        TODAY  : $TODAY"
    echo " SPEED   : $SPEED     MONTH  : $MONTH"
    echo " ────────────────────────────────────────────────────────────"
    echo "                  [ SERVICE STATUS - GOOD ]"
    echo " ────────────────────────────────────────────────────────────"
    echo " PROXY  : ON     SSH  : ON     ACCOUNT : $ACC_SSH"
    echo " NGINX  : ON     XRAY : ON     ACCOUNT : $ACC_XRAY"
    echo "════════════════════════════════════════════════════════════"
}

# =================== SUBMENU SYSTEM ===================
system_menu() {
    clear
    echo "             [ SERVICE MANAGEMENT ]"
    echo " ─────────────────────────────────────────────────"
    echo " (1) Running Service       (5) SpeedTest"
    echo " (2) Restart Service       (6) Delete All Account Exp"
    echo " (3) Monitoring BW"
    echo " (4) Monitoring System"
    echo " ─────────────────────────────────────────────────"
    echo "              [ ADMINISTRATION ]"
    echo " ─────────────────────────────────────────────────"
    echo " (7) Factory Reset         (9) Pointing Domain"
    echo " (8) Rebuild VPS           (10) Auto-Reboot"
    echo " ─────────────────────────────────────────────────"
    echo "             [ FIX & CONFIGURATION ]"
    echo " ─────────────────────────────────────────────────"
    echo " (11) Banner Manager       (14) Fix HAProxy"
    echo " (12) Change Domain        (15) Fix Domain"
    echo " (13) Change Respon        (16) Install Bot WhatsApp"
    echo " ─────────────────────────────────────────────────"
    echo "              [ CLEANUP OPTIONS ]"
    echo " ─────────────────────────────────────────────────"
    echo " (17) Clear Cache          (19) Clear Cache File"
    echo " (18) Clear Logs"
    echo " ─────────────────────────────────────────────────"
    echo "             [ SYSTEM INFORMATION ]"
    echo " ─────────────────────────────────────────────────"
    echo " (20) Info Service Port    (22) Limit-on-off XRAY"
    echo " (21) Information System"
    echo " ═════════════════════════════════════════════════"
    echo " (23) Back to Main Menu     (x) Exit"
    echo " ═════════════════════════════════════════════════"
    read -p " Select From Options [1-22 or x] : " sysopt

    case $sysopt in
        1) systemctl --type=service --state=running | less ;;
        2) systemctl restart ssh nginx xray vnstat ;;
        3) vnstat ;;
        4) htop ;;
        5) speedtest-cli ;;
        6) echo "Menghapus semua akun expired..." ;;
        7) echo "⚠️ Factory reset (hapus semua data config)" ;;
        8) /usr/local/bin/rebuild.sh ;;
        9) nano $DOMAIN_FILE ;;
        10) crontab -e ;;
        11)
            clear
            echo "═══════════════════════════════════════════════"
            echo "              [ BANNER MANAGER ]"
            echo "═══════════════════════════════════════════════"
            echo " (1) Set Banner Baru"
            echo " (2) Tambah Baris Banner"
            echo " (3) Tampilkan Banner Saat Ini"
            echo " (4) Kosongkan Banner"
            echo " (5) Pilih Varian Banner"
            echo " (6) Banner Random"
            echo " (x) Kembali"
            echo "═══════════════════════════════════════════════"
            read -p " Pilih opsi banner: " banopt
            case $banopt in
                1) /usr/local/bin/banner-control.sh set ;;
                2) /usr/local/bin/banner-control.sh add ;;
                3) /usr/local/bin/banner-control.sh show; read -n 1 -s -r -p "Tekan tombol apapun untuk lanjut..." ;;
                4) /usr/local/bin/banner-control.sh clear ;;
                5) /usr/local/bin/banner-control.sh choose ;;
                6) /usr/local/bin/banner-control.sh random ;;
                x) system_menu ;;
                *) echo "❌ Pilihan tidak valid!"; sleep 2 ;;
            esac
            ;;
        12) nano $DOMAIN_FILE ;;
        13) echo "Change respon (edit bot/respon)" ;;
        14) systemctl restart haproxy ;;
        15) echo "Fix domain (cek DNS / SSL renew)" ;;
        16) echo "Install bot WhatsApp (under dev)" ;;
        17) sync; echo 3 > /proc/sys/vm/drop_caches ;;
        18) journalctl --vacuum-time=1d ;;
        19) rm -rf /tmp/* /var/tmp/* ;;
        20) ss -tuln ;;
        21) neofetch ;;
        22) systemctl restart xray ;;
        23) main_menu ;;
        x) exit 0 ;;
        *) echo "❌ Pilihan tidak valid!"; sleep 2; system_menu ;;
    esac
}

# =================== MENU UTAMA ===================
main_menu() {
    while true; do
        show_status
        echo ""
        echo -e " [01] SSH & OpenVPN Menu"
        echo -e " [02] Vmess Menu"
        echo -e " [03] Vless Menu"
        echo -e " [04] Trojan Menu"
        echo -e " [05] Shadowsocks Menu"
        echo -e " [06] WireGuard Menu"
        echo -e " [07] L2TP / PPTP / SSTP Menu"
        echo -e " [08] System Menu (Service / Config / Info)"
        echo -e " [09] Backup & Restore"
        echo -e " [x] Keluar"
        echo ""
        read -p " Pilih menu: " opt

        case $opt in
            1) echo "👉 SSH & OpenVPN Menu" ;;
            2) echo "👉 Vmess Menu" ;;
            3) echo "👉 Vless Menu" ;;
            4) echo "👉 Trojan Menu" ;;
            5) echo "👉 Shadowsocks Menu" ;;
            6) echo "👉 WireGuard Menu" ;;
            7) echo "👉 L2TP / PPTP / SSTP Menu" ;;
            8) system_menu ;;
            9) echo "👉 Backup & Restore" ;;
            x) exit 0 ;;
            *) echo "❌ Pilihan tidak valid!"; sleep 2 ;;
        esac
    done
}

main_menu
