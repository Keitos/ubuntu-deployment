#!/bin/bash
cryptsetup luksOpen /dev/nvme0n1p3 cryptdisk
lvresize -L 15G --resizefs /dev/mapper/vgubuntu/root
lvresize -L 8G /dev/mapper/vgubuntu/swap_1
mkswap /dev/vgubuntu/swap_1
lvcreate -L 8G -n var-log vgubuntu
lvcreate -L 4G -n var-log-audit vgubuntu
lvcreate -L 1G -n var-tmp vgubuntu
lvcreate -l 60%FREE -n home vgubuntu
lvcreate -l 50%FREE -n var vgubuntu
