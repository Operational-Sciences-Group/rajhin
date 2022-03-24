#!/bin/bash
#OSG -> RAJHIN
# ⌨ >= ⚔
#    ______      ____    ____        ____   ____            ____           ____  ____  
#  >   /  /___/ /___    /___/ /   / /___/  /___/  / / \  / / __    /    / /___/ /___/ <
# >   /  /   / /___    /     /___/ /   \  /   \  / /   \/ /___/   /__  / /   / /   \ <

sudo echo "Executing Rajhin"

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

function RandHex(){
	OneByte=$(tr -dc 'A-F0-9' < /dev/random | head -c2)
	echo "$OneByte"
}

# Add list of vendors
declare -a OUIarray=(00:50:E4 00:56:CD 10:A5:1D 00:e0:4c)
OUI=$(shuf -n1 -e "${OUIarray[@]}")

# Cryptographically secure, because you know it.
SecretKey=$(uuidgen | sed "s/-//g; s/..../:&/g; s/^://")

# Enforce RFC 4941 (AKA "Privacy Extensions") 
# This decouples the last three fields of the IPv6 StateLess Address Auto-Config (SLAAC) from the EUI-48 on default net adapters. 
sysctl -w net.ipv6.conf.default.use_tempaddr=2


# Enable RFC 7217 (AKA "Semantically Opaque Interface Identifiers")
# This makes the IPv6 SLAAC from an opaque hash.
# This address is still "static" per network.
# Yes, it changes every time you run the script.

sysctl -w net.ipv6.conf.default.stable_secret="$SecretKey"

interfaces=($(find /sys/class/net/* | grep -v "lo" | cut -d'/' -f5))
for i in "${interfaces[@]}"
do
	# of the interface is up
	AdapterStatus=$(cat /sys/class/net/"$i"/operstate)
	if [[ $AdapterStatus == "up" ]]; then
		ifconfig "$i" down
		ifconfig "$i" hw ether "$OUI":"$(RandHex)":"$(RandHex)":"$(RandHex)"
		ifconfig "$i" up
		echo New EUI-48 for "$i" = "$OUI":"$(RandHex)":"$(RandHex)":"$(RandHex)"
	fi
done
