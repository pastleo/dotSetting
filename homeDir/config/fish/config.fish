# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme pastfish

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins autojump bundler sendprompt

# Path to your custom folder (default path is $FISH/custom)
set fish_custom $HOME/.config/fish/custom


if test -d $fish_path
  echo (set_color white)"}{} }{} "(set_color red)"<(^O^)> "(set_color yellow)"Enabling OH_MY_FISH "(set_color red)"<(^O^)> "(set_color white)"{}{ {}{"
else
  echo (set_color red)"==========================================================="
  echo (set_color yellow)">>>>>  oh-my-fish not installed... trying to grab...  <<<<<"
  echo (set_color red)"==========================================================="
  type git >/dev/null
  and git clone https://github.com/bpinto/oh-my-fish.git ~/.oh-my-fish
  or begin
      echo (set_color -b red -o purple)" <*)))<"(set_color -b red -o black)" git not installed. Skip enabling oh-my-fish "(set_color -b red -o purple)">(((*> "
      exit
  end
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
# Load oh-my-fish configuration.
# ====================================================
. $fish_path/oh-my-fish.fish


