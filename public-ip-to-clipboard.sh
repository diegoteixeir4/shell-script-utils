#!/bin/sh

# public-ip-to-clipboard
# 
# This script gets the public IP adress from ipify.org
# then copy it to clipboard.
#
# Usage:
#   ./public-ip-to-clipboard


# xclip is an utility to copy stdin to clipboard and
# to print clipboard content (with -o parameter).
xclip=$(which xclip)

if [ -z "$xclip" ]; then
  echo "xclip is not installed. To install it use:"
  echo "  sudo apt install xclip"
  exit 1
fi

api="https://api.ipify.org"
ip=$(wget -qO- $api)
status=$?

if [ $status -ne 0 ] || [ -z "$ip" ]; then
  echo "It was not possible to obtain public IP."
  exit 1
fi

echo $ip | $xclip -selection clipboard
echo "Public IP: $ip"
echo "It was copied to clipboard."
