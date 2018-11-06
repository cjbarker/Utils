#!/usr/bin/env bash

# #################################################################################### #
# IP Address Open Source Intelligience Script
#
# Can handle single IP cmdline arg or file of IPs to process
#
# Usage: ./ip-osint.sh [ip-address] | [file-name]
#	ip-address: IP address to perform OSINT on
#	filename: Filename with IP address carriage return separated to perform OSINT on
#
#  echo $?
#
# Exit return code == 0 then successful
# Exit return code != 0 then failed
#
# #################################################################################### #

# Required built-ins
declare -a CMDS
CMDS[0]='ping'
CMDS[1]='grep'
CMDS[2]='cut'
CMDS[3]='whois'
CMDS[4]='dig'

function echoerr {
    echo "$@" 1>&2
}

function usage() {
    echo -e "Usage: $0 [ip-address] | [file-name]"
    echo -e "\tip-address: IP address to perform OSINT on"
    echo -e "\tfilename: Filename with IP address carriage return separated to perform OSINT on"
	exit 1
}

function cmd_exists {
    local cmd=$1
    local result=`which $cmd`

    if [ -n "$result" ]; then
        echo 0
    else
        echoerr "Command ${1} does not exist. Unable to execute script."
        echo 1
    fi
}

function process() {
    local ip=$1
    local domain=""
    local resolved_domains=""
    local http_on="N"
    local https_on="N"

    # resolve hostname to IP if ip not passed
    tmp=$(dig +short ${ip})
    if [ -n "${tmp}" ]; then
        domain=${ip}
        ip=${tmp}
    fi
    resolved_domains=$(dig +short -x 216.58.216.46 | paste -sd "," -)

    # Ping - Readchable
    ping -W 3 -c 3 -q ${ip} 2>/dev/null 1>/dev/null
    if [ $? -eq 0 ]; then
        is_pingable="Y"
    else
        is_pingable="N"
    fi
    # continue even if not pingable - might be blocking ICMP

    resolved_domains=$(dig +short -x 216.58.216.46 | paste -sd "," -)
    tmp=$(nc -z -n -v -G 2 ${ip} 80 2>&1 | grep succeeded)
    if [ $? -eq 0 ]; then
        http_on="Y"
    fi
    tmp=$(nc -z -n -v -G 2 ${ip} 443 2>&1 | grep succeeded)
    if [ $? -eq 0 ]; then
        https_on="Y"
    fi

    # WhoIs
    org=$(whois ${ip} | grep -i "organization" | cut -d':' -f2 | xargs)

    # Geo-IP
    tmp=$(curl -s -H "Accept: application/json" "https://tredir.go.com/capmon/GetDE?ip=${ip}&getProxy=true")
    city=`echo $tmp | jq -r .geoDecoder.city`
    region=`echo $tmp | jq -r .geoDecoder.region.name`
    country=`echo $tmp | jq -r .geoDecoder.country.name`
    proxyType=`echo $tmp | jq -r .proxyDecoder.proxyType`

    if [ "${proxyType}" == "?" ]; then
        proxyType="None"
    fi

    # Tor Exit node
    fnd=$(echo $TOR_EXIT_NODES | grep "${ip}")
    if [ $? -eq 0 ]; then
        is_exit_node="Y"
    else
        is_exit_node="N"
    fi

    # TOD - add banner grab

    echo -e "${ip}|${domain}|${is_pingable}|${resolved_domains}|${http_on}|${https_on}|${org}|${city}|${region}|${country}|${proxyType}|${is_exit_node}"
}

function print_file_headers() {
    echo -e "IP|DOMAIN|PINGABLE|RESOLVED-DOMAINS|HTTP-ON|HTTPS-ON|WHOIS|CITY|REGION|COUNTRY|PROXY-TYPE|TOR-EXIT-NODE"
}

# validate binaries
for cmd in "${CMDS[@]}"
do
    #echo ${cmd}
    rc=`cmd_exists ${cmd}`
    if [ "$rc" -ne "0" ]; then
        exit $rc
    fi
done

# call usage() function if filename not supplied
[[ $# -eq 0 ]] && usage
[[ $# -ne 1 ]] && usage

# Get Proxy Exist Nodes
TOR_EXIT_NODES=$(curl -s https://check.torproject.org/exit-addresses | grep -i "ExitAddress" | cut -d' ' -f2)

# validate is file
print_file_headers

if [ -f "${1}" ]; then
    # process IPs per line in file
    while read -r line
    do
        #echo "Line: ${line}"
        process ${line}
    done < "${1}"
else
    process ${1}
fi

exit 0
