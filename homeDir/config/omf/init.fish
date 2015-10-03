
# ===========================================================
# _   _       _   _
# | \ | |     | | (_)
# |  \| | ___ | |_ _  ___ ___
# | . ` |/ _ \| __| |/ __/ _ \
# | |\  | (_) | |_| | (_|  __/
# \_| \_/\___/ \__|_|\___\___|
#
# This script is used as my post-installer for my oh-my-fish
# ===========================================================

# Fish config and oh-my-fish path
set -gx FISH_CONFIG $HOME/.config/fish
set -gx OMF_CONFIG $HOME/.config/omf
set -gx OMF_PATH $HOME/.local/share/omf

echo (set_color blue)">> Post-processing ..."

mv -vf $FISH_CONFIG/config.deployed.fish $FISH_CONFIG/config.fish
mv -vf $OMF_CONFIG/init.deployed.fish $OMF_CONFIG/init.fish
rm -vf $FISH_CONFIG/config.*.copy

echo (set_color cyan)"<(^O^)>"(set_color green)"        Done! Enjoy the shell!        "(set_color cyan)"<(^O^)>"
echo (set_color black)"==================================================="

source $FISH_CONFIG/config.fish
exit
