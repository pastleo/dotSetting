#!/bin/bash

set -e

if [ "$#" -lt 2 ]; then
  echo "Usage:"
  echo "  exiftool-cp.sh path/to/src.mp4 path/to/des.mp4"
  echo "Envs:"
  echo "  DATETIME"
  exit 1
fi

SRC=$1
DES=$2

# datetime exif fields to look for (in order)
# * immich EXIF_DATE_TAGS: https://github.com/immich-app/immich/blob/main/server/src/services/metadata.service.ts#L29
# * gopro player exports with MediaCreateDate as original shooting datetime
EXIF_DATE_TAGS="SubSecDateTimeOriginal DateTimeOriginal SubSecCreateDate MediaCreateDate CreationDate CreateDate SubSecMediaCreateDate DateTimeCreated"

if [ -z "$DATETIME" ]; then
  for TAG in $EXIF_DATE_TAGS
  do
    EXIF_DATETIME=$(exiftool "-${TAG}" -s3 "$SRC")
    if [ "$EXIF_DATETIME" ] && [ "$EXIF_DATETIME" != "0000:00:00 00:00:00" ]; then
      DATETIME="$EXIF_DATETIME"
      echo "DATETIME (${TAG}) from ${SRC}: $DATETIME"
      break
    fi
  done

  if [ -z "$DATETIME" ]; then
    echo "DATETIME extraction failed, please assign Env DATETIME='2025:01:23 12:34:56' command.sh ..."
    exit 2
  fi
else
  echo "DATETIME from Env: $DATETIME"
fi

echo '>' exiftool -TagsFromFile "$SRC" -All:All -AllDates="$DATETIME" "$DES"
exiftool -TagsFromFile "$SRC" -All:All -AllDates="$DATETIME" "$DES"

echo '>' rm "${DES}_original" "# cleaning..."
rm "${DES}_original"
