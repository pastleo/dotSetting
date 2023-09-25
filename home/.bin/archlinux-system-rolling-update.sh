#/bin/bash

# archlinux-system-rolling-update.sh
# ==================================
# perform archlinux system rolling update with yay & reflector
# skip steps that already done (according to log file in /tmp/ should be clear after reboot)
#
# this script is intended to be run on terminal for interaction, not cronjob

set -e

log_path="/tmp/archlinux-system-rolling-update.log"
touch $log_path
existing_log=$(cat $log_path)

function log {
  echo "[$(date +"%Y-%m-%dT%H:%M:%S")] $@" | tee -a $log_path
}

log "archlinux-system-rolling-update.sh starting, log_path: $log_path"

if ! [[ "$existing_log" == *"UPDATE_MIRRORLIST"* ]]; then
  log ">> reflector --protocol https --age 48 --country tw,jp,us --sort rate --threads 8 --verbose --save /tmp/pacman-new-mirrorlist"
  reflector --protocol https --age 48 --country tw,jp,us --sort rate --threads 8 --verbose --save /tmp/pacman-new-mirrorlist

  log ">> sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak"
  sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
  log ">> sudo cp /tmp/pacman-new-mirrorlist /etc/pacman.d/mirrorlist"
  sudo cp /tmp/pacman-new-mirrorlist /etc/pacman.d/mirrorlist

  log "UPDATE_MIRRORLIST done"
else
  log "UPDATE_MIRRORLIST already done, skipping..."
fi

if ! [[ "$existing_log" == *"UPDATE_KEYRING"* ]]; then
  log ">> sudo pacman -Sy archlinux-keyring"
  sudo pacman -Sy archlinux-keyring

  log "UPDATE_KEYRING done"
else
  log "UPDATE_KEYRING already done, skipping..."
fi

if ! [[ "$existing_log" == *"YAY_SYU"* ]]; then
  log ">> yay -Syu"
  yay -Syu

  log "YAY_SYU done"
else
  log "YAY_SYU already done, skipping..."
fi

if ! [[ "$existing_log" == *"PACCACHE"* ]]; then
  log ">> paccache -rk3"
  # yay -Sy pacman-contrib # to get paccache
  paccache -rk3 # keep last 3 versions

  log "PACCACHE done"
else
  log "PACCACHE already done, skipping..."
fi
