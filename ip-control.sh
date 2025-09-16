#!/bin/bash
WHITELIST_FILE="/usr/local/bin/whitelist.conf"
mkdir -p /usr/local/bin
touch $WHITELIST_FILE

case "$1" in
    add)
        echo "$2" >> $WHITELIST_FILE
        echo "✅ IP $2 berhasil ditambahkan."
        ;;
    remove)
        sed -i "/$2/d" $WHITELIST_FILE
        echo "✅ IP $2 berhasil dihapus."
        ;;
    list)
        cat $WHITELIST_FILE ;;
    check)
        MYIP=$(curl -s ifconfig.me)
        if grep -q "$MYIP" $WHITELIST_FILE; then
            echo "✅ IP $MYIP terdaftar."
            exit 0
        else
            echo "❌ IP $MYIP tidak terdaftar!"
            exit 1
        fi
        ;;
    *)
        echo "Gunakan: $0 {add|remove|list|check}"
        ;;
esac
