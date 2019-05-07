#!/bin/sh

# notify-on-new-file.sh
#
# This script watches a directory passed as argument and shows a
# desktop notification when a file is created or moved to it.
# Notification title is the first line of the new file and
# the body is the other lines. After it is displayed the file is
# removed.
#
# Usage:
#   ./notify-on-new-file.sh [directory]
#
# Example:
#   ./notify-on-new-file.sh ./tmp
#   echo -e "Hello, world\nMy first notification." > ./tmp/1.txt

watched_dir=$1

inotifywait=$(which inotifywait)

if [ -z "$inotifywait" ]; then
  echo "inotifywait is not installed. To install it use:"
  echo "  sudo apt install inotify-tools"
  exit 1
fi

$inotifywait -m -q -e create -e moved_to $watched_dir |
  while read path action file; do
    file_path="$watched_dir/$file"
    title=$(head -n 1 $file_path)
    body=$(tail -n +2 $file_path)
    notify-send -t 5000 "$title" "$body"
    rm $file_path
  done
