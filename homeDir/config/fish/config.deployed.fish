# Fish config and oh-my-fish path
set -gx FISH_CONFIG $HOME/.config/fish
set -gx OMF_CONFIG $HOME/.config/omf
set -gx OMF_PATH $HOME/.local/share/omf

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
