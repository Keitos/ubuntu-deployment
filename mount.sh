#!/bin/bash
mkfs.ext4 /dev/vgubuntu/var
mkfs.ext4 /dev/vgubuntu/home
mkfs.ext4 /dev/vgubuntu/var-log
mkfs.ext4 /dev/vgubuntu/var-tmp
mkdir /mnt/var
mkdir /mnt/home
mkdir /mnt/var/log
mkdir /mnt/var/tmp
mount /dev/vgubuntu/var /mnt/var
mount /dev/vgubuntu/var-log /mnt/var/log
mount /dev/vgubuntu/var-tmp /mnt/var/tmp
mount /dev/vgubuntu/home /mnt/home
#var remount
cd /var
cp -ax * /mnt/var
cd /
mv var var.old
mkdir var
umount /dev/vgubuntu/var
mount /dev/vgubuntu/var /var
#home remount
cd /home
cp -ax * /mnt/home
cd /
mv home home.old
mkdir home
umount /dev/vgubuntu/home
mount /dev/vgubuntu/home /home
#tmp remount
cd /var/tmp
cp -ax * /mnt/var/tmp
cd /
mv var/tmp vartmp.old
mkdir var/tmp
umount /dev/vgubuntu/var-tmp
mount /dev/vgubuntu/var-tmp /var/tmp
#log remount
cd /var/log
cp -ax * /mnt/var/log
cd /
mv var/log varlog.old
mkdir var/log
umount /dev/vgubuntu/var-log
mount /dev/vgubuntu/var-log /var/log
#mount audit
mkdir /var/log/audit
mkfs.ext4 /dev/vgubuntu/var-log-audit
mount /dev/vgubuntu/var-log-audit /var/log/audit
tee -a /etc/fstab > /dev/null <<EOT
/dev/mapper/vgubuntu-var  /var  ext4  defaults    0 0
/dev/mapper/vgubuntu-home  /home  ext4  defaults    0 0
/dev/mapper/vgubuntu-var--log  /var/log  ext4  defaults   0 0
/dev/mapper/vgubuntu-var--tmp  /var/tmp  ext4  defaults   0 0
/dev/mapper/vgubuntu-var--log--audit  /var/log/audit  ext4  defaults   0 0
EOT
