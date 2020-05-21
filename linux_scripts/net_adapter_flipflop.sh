#!/bin/bash

# ####################################################
# Script simply handles toggling network
# adapters between wifi and local area connnection
# and vice versa on WINDOZE via Cygwin.
#
# Usage: ./net_adapter_flipflop.sh <local_area_conn> <wifi_conn> <ssid>
#   - local_area_conn: LAC connection adapter name
#   - wifi_conn: Wifi connection adapter name
#   - ssid: SSID of wifi access point to connect to if wifi enabled
#
# Note: Must be "run as administrator" on Windoze 
# ####################################################

if [ $# -ne 3 ]; then
  echo "Usage: $0 <local_area_conn> <wifi_conn> <ssid>"
  exit 1
fi

lac_adapter_name=$1
wifi_adapter_name=$2
ssid=$3

which netsh 2> /dev/null

if [ $? -ne 0 ]; then
    echo "netsh command does not exist"
    exit 1
fi

connected=`netsh interface ipv4 show interfaces | grep -w 'connected'`
wifi_conn=`echo $connected | grep -i -w 'wireless network connection'`
lac_conn=`echo $connected | grep -i -w 'local area connection'`

enable_interface_name=		# set to null 
disable_interface_name=		# set to null

if [ -z "$wifi_conn" ]; then
    enable_interface_name="$wifi_adapter_name"
else
    disable_interface_name="$wifi_adapter_name"
fi

if [ -z "$lac_conn" ]; then
    # always fallback to LAC even if both disabled
    enable_interface_name="$lac_adapter_name"
    ssid=
else
    disable_interface_name="$lac_adapter_name"
fi 

if [ ! -z "$disable_interface_name" ]; then
    echo "Disabling $disable_interface_name"
    netsh interface set interface "$disable_interface_name" disable
fi

if [ ! -z "$enable_interface_name" ]; then
    echo "Enabling $enable_interface_name"
    netsh interface set interface "$enable_interface_name" enable
fi

if [ ! -z "$ssid" ]; then
    sleep 2
    echo "Connecting to $ssid"
    netsh wlan connect name="$ssid"
fi

exit 0
