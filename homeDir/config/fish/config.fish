# Remove fish default greeting
set --erase fish_greeting

# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/.config/fish/custom

# Test if oh-my-fish is installed
if test -d $fish_path
  echo (set_color white)"}{} }{} "(set_color red)"<(^O^)> "(set_color yellow)"Enabling OH_MY_FISH "(set_color red)"<(^O^)> "(set_color white)"{}{ {}{"
else
  echo (set_color red)"==========================================================="
  echo (set_color yellow)">>>>>  oh-my-fish not installed... trying to grab...  <<<<<"
  echo (set_color red)"==========================================================="
  type git >/dev/null
  and git clone https://github.com/bpinto/oh-my-fish.git ~/.oh-my-fish
  and set _initing 1
  or begin
    echo (set_color -b red -o purple)" <*)))<"(set_color -b red -o black)" git not installed. Skip enabling oh-my-fish "(set_color -b red -o purple)">(((*> "
    exit
  end
end

# ====================================================
# Load oh-my-fish configuration.
# ====================================================
. $fish_path/oh-my-fish.fish

# Theme
# set fish_theme pastfish
Theme "pastfish"

# Which plugins would you like to load? set them in the variable `_fish_plugins` below
set _fish_plugins tmux extract jump ssh z brew rvm

for p in $_fish_plugins
    Plugin $p
end

if [ $_initing ]
    omf install
end

#-------------------------------------------------------------
# The fuck from https://github.com/nvbn/thefuck
#-------------------------------------------------------------
function fuck
    eval (thefuck $history[1])
end

#-------------------------------------------------------------
# Tailoring 'less' from bashrc
#-------------------------------------------------------------

alias more='less'

#-------------------------------------------------------------
# Spelling typos from bashrc
#-------------------------------------------------------------

alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'


# ====================================================
# z (autojump tool) is required from
#     https://github.com/rupa/z
#     https://github.com/rupa/z/raw/master/z.sh
set -g Z_SCRIPT_PATH ~/.bin/z.sh # Overwrite the z path to bin folder at home
if not test \( -x $Z_SCRIPT_PATH \) -a \( -f $Z_SCRIPT_PATH \)
    # if $Z_SCRIPT_PATH (/usr/local/etc/profile.d/z.sh) is not executable
    echo Installing z - jump around tool to $Z_SCRIPT_PATH
    rm -rf $Z_SCRIPT_PATH
    wget -v -O $Z_SCRIPT_PATH https://github.com/rupa/z/raw/master/z.sh
    chmod u+x $Z_SCRIPT_PATH
end
# ====================================================
