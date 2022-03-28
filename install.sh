#!/bin/bash

# ## How to install

# Using curl:

# ```
# bash <(curl -s https://raw.githubusercontent.com/pastleo/dotSetting/master/install.sh)
# ```

# Or from local disk (this will make a link pointing existing repo)

# ```
# bash path/to/repo/install.sh
# ```

# =============================================================================
# bootstrap script to install Homeshick, pastleo/dotSetting and castles you
# preferred to a new system.
# 
# This file is copied and modified from
# https://github.com/andsens/homeshick/wiki/Simplistic-bootstraping-script

if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
  git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi

source $HOME/.homesick/repos/homeshick/homeshick.sh

if [ -x $0 ]; then
  # executed from local repo
  repo_path="$(cd "$(dirname "$0")"; pwd)"
  repo_name="$(basename $repo_path)"
  ln -s $repo_path "$HOME/.homesick/repos/$repo_name"
  homeshick link $repo_name
else
  # executed from curl or wget
  homeshick clone https://github.com/pastleo/dotSetting.git
fi

tmpfilename="/tmp/${0##*/}.XXXXX"

if type mktemp >/dev/null; then
  tmpfile=$(mktemp $tmpfilename)
else
  tmpfile=$(echo $tmpfilename | sed "s/XX*/$RANDOM/")
fi

trap 'rm -f "$tmpfile"' EXIT

cat <<'EOF' > $tmpfile
# Which Homeshick castles do you want to install?
#
# Each line is passed as the argument(s) to `homeshick clone`.
# Lines starting with '#' will be ignored.
#
# If you remove or comment a line that castle will NOT be installed.
# However, if you remove or comment everything, the script will be aborted.

# Plugin management
#gmarik/Vundle.vim
#tmux-plugins/tpm

# Private castles (commented by default)
EOF

${VISUAL:-vi} $tmpfile

code=$?

if [[ $code -ne 0 ]]; then
  echo "Editor returned ${code}." 1>&2
  exit 1
fi

castles=()

while read line; do
  castle=$(echo "$line" | sed '/^[ \t]*#/d;s/^[ \t]*\(.*\)[ \t]*$/\1/')
  if [[ -n $castle ]]; then
    castles+=("$castle")
  fi
done <$tmpfile

if [[ ${#castles[@]} -eq 0 ]]; then
  echo "No other castles to install. Aborting."
  exit 0
fi

for castle in "${castles[@]}"; do
  homeshick clone "$castle"
done

