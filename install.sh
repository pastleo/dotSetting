#!/bin/bash

# Run this by path/to/this/repo/install.sh or
# curl -sSL ... | bash

# bootstrap script to install Homeshick and you preferred castles to a new
# system.

if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
  git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
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
#sukima/muttrc
#secret@example.org:securerc.git
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

