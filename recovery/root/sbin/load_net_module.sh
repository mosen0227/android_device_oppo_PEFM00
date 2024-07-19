#!/sbin/sh

/vendor/bin/wmt_loader &
/vendor/bin/wmt_launcher -p /vendor/firmware/ &
insmod /sbin/wmt_drv.ko &
insmod /sbin/wmt_chrdev_wifi.ko &
insmod /sbin/wlan_drv_gen4m.ko &
