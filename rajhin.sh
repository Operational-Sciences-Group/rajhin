#!/bin/bash
#OSG -> RAJHIN
# ⌨ >= ⚔
#    ______      ____    ____        ____   ____            ____           ____  ____  
#  >   /  /___/ /___    /___/ /   / /___/  /___/  / / \  / / __    /    / /___/ /___/ <
# >   /  /   / /___    /     /___/ /   \  /   \  / /   \/ /___/   /__  / /   / /   \ <

sudo echo "Executing Rajhin"

if [[ $UID == 0 ]]; then

        function RandHex(){
                OneByte=$(tr -dc 'A-F0-9' < /dev/random | head -c2)
                echo "$OneByte"
        }

        function RandInt(){
                shuf -i 1-9 -n 1
        }

        # check uuidgen installed
        if [ "$(which uuidgen &>/dev/null)" != "" ]; then
                echo "Installing uuidgen"
                apt-get install uuid-runtime
                echo -e "\n"
        fi

        # pick random hostname
        DesktopHost=("DESKTOP-$(RandInt)$(RandInt)$(RandInt)$(RandInt)$(RandInt)$(RandInt)")
        LaptopHost=("LAPTOP-$(RandInt)$(RandInt)$(RandInt)$(RandInt)$(RandInt)$(RandInt)")
        OldHostname=$(cut -d' ' -f1 /etc/hostname)
        echo "Old hostname: " "$OldHostname"
        declare -a Hostnames=($DesktopHost $LaptopHost)
        HostnameArraySize=${#Hostnames[@]}
        i=$((RANDOM % HostnameArraySize ))
        NewHostname=${Hostnames[$i]}
        echo "New hostname:" "$NewHostname"
        sed -i "s/$OldHostname/$NewHostname/g" /etc/hostname
        sed -i "s/$OldHostname/$NewHostname/g" /etc/hosts
        hostnamectl set-hostname "$NewHostname"

        # Enforce RFC 4941 (AKA "Privacy Extensions") 
        # This decouples the last three fields of the IPv6 StateLess Address Auto-Config (SLAAC) from the EUI-48 on default net adapters. 
        sysctl -w net.ipv6.conf.default.use_tempaddr=2

        # Enable RFC 7217 (AKA "Semantically Opaque Interface Identifiers")
        # This makes the IPv6 SLAAC from an opaque hash.
        # This address is still "static" per network.
        # Yes, it changes every time you run the script.
        SecretKey=$(uuidgen | sed "s/-//g; s/..../:&/g; s/^://")
        sysctl -w net.ipv6.conf.default.stable_secret="$SecretKey"

        # Add list of vendors
        declare -a OUIarray=(00:50:E4 00:56:CD 10:A5:1D 00:e0:4c)
        OUI=$(shuf -n1 -e "${OUIarray[@]}")

        interfaces=($(find /sys/class/net/* | grep -v "lo" | cut -d'/' -f5))
        for i in "${interfaces[@]}"
        do
                # of the interface is up
                AdapterStatus=$(cat /sys/class/net/"$i"/operstate)
                if [[ $AdapterStatus == "up" ]]; then
			NewMAC="$OUI":"$(RandHex):"$(RandHex):"$(RandHex)"
                        ifconfig "$i" down
                        ifconfig "$i" hw ether "$NewMAC"
                        ifconfig "$i" up
                        echo New EUI-48 for "$i" = "$NewMAC"
                fi
        done

else
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"

fi
