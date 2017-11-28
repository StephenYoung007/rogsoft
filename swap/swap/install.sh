#! /bin/sh
cd /tmp
cp -rf /tmp/swap/bin/* /koolshare/bin/
cp -rf /tmp/swap/scripts/* /koolshare/scripts/
cp -rf /tmp/swap/init.d/* /koolshare/init.d/
cp -rf /tmp/swap/webs/* /koolshare/webs/
cp -rf /tmp/swap/res/* /koolshare/res/
cd /
rm -rf /tmp/swap* >/dev/null 2>&1

if [ ! -f "/jffs/scripts/post-mount" ];then
	cat > /jffs/scripts/post-mount <<-EOF
	#!/bin/sh
	/koolshare/bin/ks-mount-start.sh start
	EOF
else
	STARTCOMAND=`cat /jffs/scripts/post-mount | grep ks-mount-start`
	if [ -z "$STARTCOMAND" ];then
		echo "/koolshare/bin/ks-mount-start.sh start" >> /jffs/scripts/post-mount
	fi
fi
chmod +x /jffs/scripts/post-mount
chmod +X /koolshare/bin/*
chmod +X /koolshare/scripts/swap*
chmod +X /koolshare/init.d/*

