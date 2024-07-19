#!/sbin/sh

chmod 755 /system/bin/ip6tables
chmod 755 /system/bin/iptables
chmod 755 /system/bin/netutils-wrapper-1.0
chmod 755 /system/bin/sh
chmod 755 /sbin/toybox
toybox start servicemanager
toybox start hwservicemanager
toybox start wmt_loader
toybox start wmt_launcher
toybox chcon u:object_r:netd_exec:s0 /sbin/netd
#toybox start netd
mkdir -p /mnt/vendor/nvdata
mount /dev/block/platform/bootdevice/by-name/nvdata /mnt/vendor/nvdata
sleep 1
echo 1 > /dev/wmtWifi
busybox ifconfig -a > /tmp/ifconfig.txt
sleep 3
mkdir -p /data/misc/wifi/sockets
busybox chown 1010:1010 /data/misc/wifi/sockets
busybox chmod 0770 /data/misc/wifi/sockets
toybox chcon u:object_r:wpa_socket:s0 /data/misc/wifi/sockets
touch /data/misc/wifi/wpa_supplicant.conf
busybox chown 1010:1010 /data/misc/wifi/wpa_supplicant.conf
busybox chmod 0770 /data/misc/wifi/wpa_supplicant.conf
sleep 3
toybox start wpa_supplicant
