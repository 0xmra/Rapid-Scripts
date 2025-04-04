#!/usr/bin/env bash

BLUE='\033[1;32m'
RED='\033[1;31m'
RESET='\033[0m'

TOWER_MOUNT="/media/tower"
SYNC_MOUNT="/media/sync"

mount_share() {
    local share_path="$1"
    local mount_point="$2"

    if ! mountpoint -q "$mount_point"; then
        sudo mount -t cifs "$share_path" "$mount_point" -o credentials=/home/kali/.smbcredentials,uid=$(whoami),gid=users,iocharset=utf8,file_mode=0777,dir_mode=0777 >/dev/null 2>&1
    fi
}

mount_share "//192.168.1.10/sync" "$SYNC_MOUNT"

if mountpoint -q "$TOWER_MOUNT"; then
    clear
    echo -e "${BLUE}Already connected to the Tower.${RESET}"
else
    # Attempt to mount Tower
    if sudo mount -t cifs //192.168.1.10/tower "$TOWER_MOUNT" -o credentials=/home/kali/.smbcredentials,uid=$(whoami),gid=users,iocharset=utf8,file_mode=0777,dir_mode=0777; then
        clear
        echo -e "${BLUE}"
        echo "__________________  __      _______________________"
        echo "\__    ___/\   _  \/  \    /  \_   _____/\______   \\"
        echo "  |    |   /  /_\  \   \/\/   /|    __)_  |       _/"
        echo "  |    |   \  \_/   \        / |        \ |    |   \\"
        echo "  |____|    \_____  /\__/\  / /_______  / |____|_  /"
        echo "                  \/      \/          \/         \/"
        echo -e "${RESET}"

        echo -e "${BLUE}----------------------------------------------------"
        echo -e "---------------${RESET}${RED}CONNECTED TO THE TOWER${RESET}${BLUE}---------------"
        echo -e "----------------------------------------------------${RESET}\n"
    else
        clear
	echo -e "${RED}Failed to mount /🗼/ Tower. Server might be down.${RESET}"
        exit 0
    fi
fi

cd "$TOWER_MOUNT"
