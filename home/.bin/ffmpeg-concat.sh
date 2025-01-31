#!/bin/bash

set -e

if [ "$#" -lt 3 ]; then
  echo "Usage:"
  echo "  ffmpeg-concat.sh path/to/output.mp4 path/to/xxxx1.mp4 path/to/xxxx2.mp4 [path/to/xxxx3.mp4 ...]"
  echo "Envs:"
  echo "  EXIF_CP=1 to enable exiftool-cp.sh (DATETIME)"
  exit 1
fi

DES=$1
echo "DES: $DES"
shift

FIRST_SRC=$1
LIST_FILE="/tmp/ffmpeg-concat-$(date +%s).txt"

for SRC in $@
do
  echo "file '$(realpath $SRC)'" >> $LIST_FILE
done

echo "LIST_FILE: $LIST_FILE"

echo '>' ffmpeg -y -f concat -safe 0 -i "$LIST_FILE" -c copy "$DES"
ffmpeg -y -f concat -safe 0 -i "$LIST_FILE" -c copy "$DES"
  
if [ $EXIF_CP ]; then
  echo '>' exiftool-cp.sh "$FIRST_SRC" "$DES"
  exiftool-cp.sh "$FIRST_SRC" "$DES"
fi

echo "OK: => $DES"
