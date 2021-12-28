![GitHub issues](https://img.shields.io/github/issues/Operational-Sciences-Group/Prussian-Red?logo=Github&style=plastic)
![GitHub top language](https://img.shields.io/github/languages/top/Operational-Sciences-Group/Prussian-Red?logo=Python&style=plastic)
![Version](https://img.shields.io/badge/Version-1.1-sucess?style=plastic)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Operational-Sciences-Group/Prussian-Red?style=plastic)

*"Do you expect a truthful answer?  What kind of trickster do you take this one for?"*

## Table of contents

1. About
2. Installation /usage
3. Disclaimer / Warning
4. License

## About

Rahjin is a bash script for automatically spoofing the MAC address of all external ethernet interfaces on linux systems.  
The intended use case to configure the rahjin script to execute at system startup, however the script can be executed manually via typical script execution methods when physical address reset is desired.
Rahjin will detect all active interfaces (eth0, wlan0, wlan1, etc...) and filter out the loopback address (lo) for spoofing.
Spoofing is comprised of randomizing the three hexadecimal octets that comprise the NIC specific address, and appending them to the OUI address for Realtek ethernet drivers.
The idea is that a recognizable though vague OUI used in a wide range of devices provides a less suspicious address than a purely random one.

## Installation / Usage

Rahjin can be executed manually like other bash scripts when a physical address identity refresh is desired.  However, the intended use case is to execute Rahjin automatically at system start up.

Two example methods to install rahjin to execute at start up are:

# Using crontab:

@ terminal
``` crontab -e ```
``` @reboot sh /path/to/rahjin.sh ```

# Using a rc.local:

Append to rc.local file (directory varies on distribution):
``` sh /path/to/rahjin.sh ```
Ensure rc.local itself is an executable with:
``` chmod +x /path/to/rc.local ```

## Disclaimer / Warning

All the contents of this repository should be used for authorized and/or educational purposes only. Any misuse of this repository will not be the responsibility of the author or of any other collaborator.

## License

[GPL-3.0 License](https://github.com/JoustingZebra/Project-Birddog/blob/main/LICENSE)
