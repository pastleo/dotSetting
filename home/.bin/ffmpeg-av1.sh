#!/bin/bash

set -e

if [ "$#" -lt 2 ]; then
  echo "Usage:"
  echo "  ffmpeg-av1.sh vaapi|nvenc path/to/xxxx1.mp4 [path/to/xxxx2.mp4 ...]"
  echo "  # path/to/xxxx1.mp4 => path/to/xxxx1-av1.mp4"
  echo "  # path/to/xxxx2.mp4 => path/to/xxxx2-av1.mp4"
  echo "Envs:"
  echo "  WIDTH"
  echo "  EXIF_CP=1 to enable exiftool-cp.sh (DATETIME)"
  exit 1
fi

ENC=$1
echo "ENC: $ENC"
shift

for SRC in $@
do
  filename=$(basename -- "$SRC")
  filename="${filename%.*}"
  DES="$(dirname "$SRC")/$filename-av1.mp4"

  echo "============="
  echo "SRC: $SRC"
  echo "DES: $DES"

  case "$ENC" in
    "nvenc")
      if [ "$WIDTH" ]; then
        FILTER="-vf scale_cuda=${WIDTH}:-1"
      fi
      echo '>' ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i "$SRC" $FILTER -c:v av1_nvenc -cq 31 -strict unofficial -movflags +faststart "$DES"
      ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i "$SRC" $FILTER -c:v av1_nvenc -cq 31 -strict unofficial -movflags +faststart "$DES"
      ;;

    "vaapi")
      if [ "$WIDTH" ]; then
        FILTER="-vf scale_vaapi=${WIDTH}:-1"
      fi
      echo '>' ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi -i "$SRC" "$FILTER" -c:v av1_vaapi -q 117 -tiles 4x2 -tile_groups 2 -async_depth 4 -strict unofficial -movflags +faststart "$DES"
      ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi -i "$SRC" $FILTER -c:v av1_vaapi -q 117 -tiles 4x2 -tile_groups 2 -async_depth 4 -strict unofficial -movflags +faststart "$DES"
      ;;

    *)
      echo "$ENC is not one of vaapi|nvenc"
      exit 1
      ;;
  esac

  if [ $EXIF_CP ]; then
    echo '>' exiftool-cp.sh "$SRC" "$DES"
    exiftool-cp.sh "$SRC" "$DES"
  fi

  echo "OK: $SRC => $DES"
  echo ""
done

