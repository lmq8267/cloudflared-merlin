#! /bin/sh

source /jffs/softcenter/scripts/base.sh
eval `dbus export cloudflared`

en=`dbus get cloudflared_enable`
bin=`dbus get cloudflared_path`
if [ "${en}"x = "1"x ] ; then
    sh /jffs/softcenter/scripts/cloudflared_config.sh stop
fi
rm -rf $bin
confs=`dbus list cloudflared|cut -d "=" -f1`

for conf in $confs
do
	dbus remove $conf
done

sleep 1
rm -rf /jffs/softcenter/scripts/cloudflared*
rm -rf /jffs/softcenter/bin/cloudflared*
rm -rf /jffs/softcenter/init.d/?99cloudflared.sh
rm -rf /jffs/softcenter/webs/Module_cloudflared.asp
rm -rf /jffs/softcenter/res/icon-cloudflared.png

echo "【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】: 卸载完成，江湖有缘再见~"
rm -rf /jffs/softcenter/scripts/uninstall_cloudflared.sh
