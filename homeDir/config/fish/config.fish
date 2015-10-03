
# ===========================================================
# _   _       _   _
# | \ | |     | | (_)
# |  \| | ___ | |_ _  ___ ___
# | . ` |/ _ \| __| |/ __/ _ \
# | |\  | (_) | |_| | (_|  __/
# \_| \_/\___/ \__|_|\___\___|
#
# This script is used as my installer for my oh-my-fish
# ===========================================================

# Fish config and oh-my-fish path
set -gx FISH_CONFIG $HOME/.config/fish
set -gx OMF_CONFIG $HOME/.config/omf
set -gx OMF_PATH $HOME/.local/share/omf

function die -a msg
  printf (set_color -b red -o purple)" <*)))<"(set_color -b red -o black)" %-35s "(set_color -b red -o purple)">(((*> \n" "$msg Skipping."
  exit 1
end

echo  (set_color black)"==================================================="

if not type git 2> /dev/null 1> /dev/null
  die "Git not installed."
end
if type wget 2> /dev/null 1> /dev/null
  set wget_or_curl "wget -qO-"
else if type curl 2> /dev/null 1> /dev/null
  set wget_or_curl "curl -L"
else
  die "Both wget and curl are not installed."
end

echo (set_color white)"}{}"(set_color yellow)"   Install oh-my-fish and awsome stuff ...   "(set_color white)"{}{"

# ====================================================
# z (autojump tool) is required from
#   https://github.com/rupa/z
#   https://github.com/rupa/z/raw/master/z.sh
set -g Z_SCRIPT_PATH ~/.bin/z.sh
echo (set_color green)">> Installing z ..."
mkdir -p (dirname $Z_SCRIPT_PATH)
rm -rf $Z_SCRIPT_PATH
eval "$wget_or_curl https://github.com/rupa/z/raw/master/z.sh >> $Z_SCRIPT_PATH"

# ====================================================
# install oh-my-fish
#   https://github.com/oh-my-fish/oh-my-fish
if test -f $OMF_PATH/init.fish
  echo (set_color blue)">> oh-my-fish already installed, clean up ..."
  mv -vf $FISH_CONFIG/config.deployed.fish $FISH_CONFIG/config.fish
  source $FISH_CONFIG/config.fish
else
  echo (set_color green)">> Installing oh-my-fish ..."
  rm -vf $FISH_CONFIG/config.fish
  eval "$wget_or_curl https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish"

  echo (set_color black)"==================================================="
  echo  (set_color cyan)">      use 'exit' (again) to exit the shell       <"
  echo (set_color black)"==================================================="
  exit
end
