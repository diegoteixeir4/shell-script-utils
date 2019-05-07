#!/bin/sh

# public-ip-to-clipboard
# 
# This script gets the public IP adress from ipify.org
# then copy it to clipboard.
#
# Usage:
#   ./public-ip-to-clipboard

api="https://api.ipify.org"
ip=$(wget -qO- $api)
status=$?

if [ $status -ne 0 ] || [ -z "$ip" ]; then
  echo "It was not possible to obtain public IP."
  exit 1
fi

# xclip is an utility to copy stdin to clipboard and
# to print clipboard content (with -o parameter).
# To install it use:
#   sudo apt install xclip

echo $ip | xclip -selection clipboard
echo "Public IP: $ip"
echo "It was copied to clipboard."
