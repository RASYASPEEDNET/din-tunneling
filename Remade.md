# 🚀 Tunnel Management Script (All OS Ready)

Script untuk mengelola layanan tunneling (SSH, XRay, VPN, dll) dengan menu interaktif di **Debian/Ubuntu**.

## 📦 Fitur Utama
- Dashboard status server
- Menu SSH, VPN, XRay, Trojan, Shadowsocks, WireGuard
- System menu (service management, admin, fix, cleanup, info)
- Banner manager (set, add, show, clear, choose, random)
- IP whitelist
- Backup & Rebuild

## ⚙️ Instalasi
```bash
wget -O install.sh https://raw.githubusercontent.com/yourrepo/script-tunnel/main/install.sh
chmod +x install.sh
./install.sh
```

## 🔐 IP Whitelist
```bash
ip-control.sh add <IP>
ip-control.sh list
ip-control.sh remove <IP>
```

## 🎨 Banner Manager
```bash
banner-control.sh choose
banner-control.sh random
```

## ♻️ Rebuild
```bash
rebuild.sh
```

Author: **DIN-STORE**
