#!/bin/sh


while true; do
  STATUS=''
  TIME="$(date +'%a %b %d %R:%S')"
#  CHARGE="$(acpi | sed 's/.*: \(.*%\).*/\1/g')"
  MEM="$(free -m | grep Mem: | awk '{print $7}')M"
  WINDOW="$(swaymsg -t get_tree | grep -A30 '"focused": true,' | grep name | awk -F'"' '{print $4}')"
  WORKSPACE="$(swaymsg -t get_tree | grep current_workspace | awk -F'"' '{print $4}')"
  SOUND=''
#  WLAN="$(nmcli device show wlp1s0 | grep CONNECTION | awk '{print $2}')"
  HDD=''


#  STATUS="$WINDOW | $WORKSPACE | $MEM | $CHARGE | $WLAN | $TIME "
  STATUS="$WINDOW | $WORKSPACE | $MEM ϟϪ | $TIME "
  echo -e "$STATUS"

  if [ x"$1" == 'x1' ]; then
    break
  fi

  sleep 1
done
