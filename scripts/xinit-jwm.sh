
echo "/usr/bin/jwm" > /tmp/xinitrc.sh
chmod +x /tmp/xinitrc.sh

xinit /tmp/xinitrc.sh -- :$(fgconsole) vt$(fgconsole)
