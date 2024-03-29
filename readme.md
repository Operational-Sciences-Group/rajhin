## *Rajhin - The Purring Liar*
*"Do you expect a truthful answer?  What kind of trickster do you take this one for?"*

![GitHub issues](https://img.shields.io/github/issues/Operational-Sciences-Group/rajhin?logo=Github&style=plastic)
![GitHub top language](https://img.shields.io/github/languages/top/Operational-Sciences-Group/rajhin?logo=Bash&style=plastic)
![Version](https://img.shields.io/badge/Version-1.2-sucess?style=plastic)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Operational-Sciences-Group/rajhin?style=plastic)

## Table of contents

1. About
2. Installation / Usage
3. Disclaimer / Warning
4. License

## About

Rajhin is a bash script for automatically spoofing the EUI-48 address of all external ethernet interfaces on linux systems. Additionally, it enables [RFC 4941](https://datatracker.ietf.org/doc/html/rfc4941) and [RFC 7217](https://datatracker.ietf.org/doc/html/rfc7217) features within the linux kernel.
The intended use case to configure the rajhin script to execute at system startup, however the script can be executed manually via typical script execution methods when physical address reset is desired.
Rajhin will detect all active interfaces (eth0, wlan0, wlan1, etc.) and filter out the loopback address (lo) for spoofing.
Spoofing is comprised of randomizing the three hexadecimal octets that comprise the NIC specific address, and appending them to the OUI address for common vendors.
The idea is that a recognizable though vague OUI (Organizationally Unique Identifier) used in a wide range of devices provides a less suspicious address than a purely random one.
It also dynamically assigns pseudorandom hostnames using the template "DESKTOP-XXXXXX" or "LAPTOP-XXXXXX" where "X" is an integer. No reboot required.

## Installation / Usage

Rajhin can be executed manually like other bash scripts when a physical address identity refresh is desired.  However, the intended use case is to execute rajhin automatically at system start up.

Two example methods to install rajhin to execute at start up are:

## Using crontab:

@ terminal

``` crontab -e ```

``` @reboot sh /path/to/rajhin.sh ```

## Using rc.local:

Append to rc.local file (directory varies on distribution):

``` sh /path/to/rajhin.sh ```

Ensure rc.local itself is an executable with:

``` chmod +x /path/to/rc.local ```

## Disclaimer / Warning

All the contents of this repository should be used for authorized and/or educational purposes only. Any misuse of this repository will not be the responsibility of the author or of any other collaborator.

## License

[GPL-3.0 License](https://www.gnu.org/licenses/gpl-3.0.html)
