#!/sbin/sh
para_list=$@

#Symlink funtion
if [ "$1" = "symlink" ]; then
    shift
    link_src=$1
    shift
    for link_dest in "$@"
    do
        if [ ${link_dest:0:1} != "/" ]; then
            echo "link dest path not start with root dir"
            exit 1
        fi

        link_dir=$(dirname ${link_dest})
        rm -rf link_dest
        cd ${link_dir}
        ln -sf ${link_src} ${link_dest}
    done
    exit 0
fi

if [ "$1" = "fpdata_migrate" ]; then
    #change facedata file mode and lebel from P to Q
    echo "fpdata migrate start."
    facedata="/data/vendor_de/0/facedata"
    mount -o ro /dev/block/by-name/system /system_root
    if [ -d $facedata ]; then
        chmod -R 700 $facedata
        chown -R 1000:1000 $facedata
        chcon -R u:object_r:face_vendor_data_file:s0 $facedata
        echo "fpdata migrate done."
    fi
    umount /system_root

    #ifdef COLOROS_EDIT
    #Bing.Du@ROM.Framework,2019-08-17,Add for delete gamespace sdk.
    rm -rf /data/app/GameSpaceSdk
    rm -rf /data/data/com.coloros.accegamesdk
    rm -rf /data/user_de/0/com.coloros.accegamesdk
    #endif COLOROS_EDIT

    #ifdef COLOROS_EDIT
    #Bin.Wang@ROM.Framework,2019-08-22,Add for HEYTAP change name.
    #1. migrate necessary data to backup directory
    mkdir -p /data/oppo/common/otasave/

    #Cloud Service
    mkdir -p /data/oppo/common/otasave/Cloud/
    cp -rf /data/data/com.coloros.cloud/shared_prefs/com.coloros.cloud_sync_info.xml /data/oppo/common/otasave/Cloud/
    rm -rf /data/data/com.coloros.cloud/shared_prefs/com.coloros.cloud_sync_info.xml
    cp -rf /data/data/com.coloros.cloud/databases/* /data/oppo/common/otasave/Cloud/
    rm -rf /data/data/com.coloros.cloud/databases/*
    #UserCenter
    oppo_usercenter_database_dir="/data/data/com.oppo.usercenter/databases/"
    if [ -d $oppo_usercenter_database_dir ]; then
        mkdir -p /data/oppo/common/otasave/UserCenter/
        cp -rf /data/data/com.oppo.usercenter/databases/* /data/oppo/common/otasave/UserCenter/
    fi
    #Push
    mkdir -p /data/oppo/common/otasave/Mcs/
    cp -rf /data/data/com.coloros.mcs/files/* /data/oppo/common/otasave/Mcs/
    rm -rf /data/data/com.coloros.mcs/files/*
    cp -rf /data/user_de/0/com.coloros.mcs/databases/* /data/oppo/common/otasave/Mcs/
    rm -rf /data/user_de/0/com.coloros.mcs/databases/*
    cp -rf /data/user_de/0/com.coloros.mcs/shared_prefs/* /data/oppo/common/otasave/Mcs/
    rm -rf /data/user_de/0/com.coloros.mcs/shared_prefs/*
    #Browser
    mkdir -p /data/oppo/common/otasave/Browser/
    cp -rf /data/data/com.android.browser/databases/ /data/oppo/common/otasave/Browser/
    rm -rf /data/data/com.android.browser/databases/*
    cp -rf /data/data/com.android.browser/shared_prefs/ /data/oppo/common/otasave/Browser/
    rm -rf /data/data/com.android.browser/shared_prefs/*
    cp -rf /data/data/com.android.browser/files/selfSkin.config /data/oppo/common/otasave/Browser/
    rm -rf /data/data/com.android.browser/files/selfSkin.config
    cp -rf /data/data/com.coloros.browser/databases/ /data/oppo/common/otasave/Browser/
    rm -rf /data/data/com.coloros.browser/databases/*
    cp -rf /data/data/com.coloros.browser/shared_prefs/ /data/oppo/common/otasave/Browser/
    rm -rf /data/data/com.coloros.browser/shared_prefs/*
    cp -rf /data/data/com.coloros.browser/files/selfSkin.config /data/oppo/common/otasave/Browser/
    rm -rf /data/data/com.coloros.browser/files/selfSkin.config
    cp -rf /data/data/com.nearme.browser/databases/ /data/oppo/common/otasave/Browser/
    rm -rf /data/data/com.nearme.browser/databases/*
    cp -rf /data/data/com.nearme.browser/shared_prefs/ /data/oppo/common/otasave/Browser/
    rm -rf /data/data/com.nearme.browser/shared_prefs/*
    cp -rf /data/data/com.nearme.browser/files/selfSkin.config /data/oppo/common/otasave/Browser/
    rm -rf /data/data/com.nearme.browser/files/selfSkin.config
    #Reader
    mkdir -p /data/oppo/common/otasave/Reader/
    cp -rf /data/data/com.oppo.reader/databases/ /data/oppo/common/otasave/Reader/
    rm -rf /data/data/com.oppo.reader/databases/*
    cp -rf /data/data/com.oppo.reader/shared_prefs/ /data/oppo/common/otasave/Reader/
    rm -rf /data/data/com.oppo.reader/shared_prefs/*

    chmod -R 777 /data/oppo/common/otasave/
    chown -R 1000:1000 /data/oppo/common/otasave/

    #2. remove old apks and data directory
    #Browser
    rm -rf /data/app/com.android.browser-*
    rm -rf /data/app/com.coloros.browser-*
    rm -rf /data/app/com.nearme.browser-*
    rm -rf /data/data/com.android.browser
    rm -rf /data/data/com.coloros.browser
    rm -rf /data/data/com.nearme.browser
    rm -rf /data/user_de/0/com.android.browser
    rm -rf /data/user_de/0/com.coloros.browser
    rm -rf /data/user_de/0/com.nearme.browser

    #Pictorial
    rm -rf /data/app/com.coloros.pictorial-*
    rm -rf /data/data/com.coloros.pictorial
    rm -rf /data/user_de/0/com.coloros.pictorial

    #GlobalSearch
    rm -rf /data/app/com.oppo.quicksearchbox-*
    rm -rf /data/data/com.oppo.quicksearchbox
    rm -rf /data/user_de/0/com.oppo.quicksearchbox

    #Yoli
    rm -rf /data/app/Yoli
    rm -rf /data/app/com.coloros.yoli-*
    rm -rf /data/data/com.coloros.yoli
    rm -rf /data/user_de/0/com.coloros.yoli

    #SpeechAssist
    rm -rf /data/app/com.coloros.speechassist-*
    rm -rf /data/data/com.coloros.speechassist
    rm -rf /data/user_de/0/com.coloros.speechassist

    #KeKeUserCenter
    oppo_usercenter_data_dir="/data/data/com.oppo.usercenter/"
    if [ -d $oppo_usercenter_data_dir ]; then
        rm -rf /data/app/com.oppo.usercenter-*
    fi

    #KeKeMarket
    rm -rf /data/app/com.oppo.market-*
    rm -rf /data/data/com.oppo.market
    rm -rf /data/user_de/0/com.oppo.market

    #CloudService
    rm -rf /data/app/com.coloros.cloud-*
    rm -rf /data/data/com.coloros.cloud
    rm -rf /data/user_de/0/com.coloros.cloud

    #OPPOWallet
    rm -rf /data/app/com.coloros.wallet-*
    rm -rf /data/data/com.coloros.wallet
    rm -rf /data/user_de/0/com.coloros.wallet

    #SmartHome
    rm -rf /data/app/com.oppo.ohome-*
    rm -rf /data/data/com.oppo.ohome
    rm -rf /data/user_de/0/com.oppo.ohome

    #MCS
    rm -rf /data/app/com.coloros.mcs-*
    rm -rf /data/data/com.coloros.mcs
    rm -rf /data/user_de/0/com.coloros.mcs

    #ThemeStore
    rm -rf /data/app/com.nearme.themestore-*
    rm -rf /data/data/com.nearme.themestore
    rm -rf /data/user_de/0/com.nearme.themestore
    rm -rf /data/app/com.nearme.themespace-*
    rm -rf /data/data/com.nearme.themespace
    rm -rf /data/user_de/0/com.nearme.themespace
    chmod -R 777 /data/theme/*

    #Book
    rm -rf /data/app/com.oppo.book-*
    rm -rf /data/data/com.oppo.book
    rm -rf /data/user_de/0/com.oppo.book

    #Reader
    rm -rf /data/app/com.oppo.reader-*
    rm -rf /data/data/com.oppo.reader
    rm -rf /data/user_de/0/com.oppo.reader
    #endif COLOROS_EDIT
fi
#Other fuction
