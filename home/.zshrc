
#-------------------------------------------------------------
# ZPlug: https://zplug.sh
#-------------------------------------------------------------
export ZPLUG_HOME="$HOME/.zplug"
if ! [ -f "$ZPLUG_HOME/init.zsh" ]; then
    git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
    if ! [ -f "$ZPLUG_HOME/init.zsh" ]; then
        echo "zplug not installed successfully, please visit https://github.com/zplug/zplug"
        echo "aborting zsh..."
        exit 251 # special exit code 251 for zsh init failure
    fi
fi
source "$ZPLUG_HOME/init.zsh"

# About zplug syntax, visit:
# https://github.com/zplug/zplug#example

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "hchbaw/auto-fu.zsh"
zplug "mollifier/cd-gitroot"

if type fzf > /dev/null; then
    zplug "junegunn/fzf", dir:"~/.fzf", use:"shell/*.zsh"
fi

if [ -d ~/.rvm ]; then
    echo "use asdf instead of rvm: https://github.com/asdf-vm/asdf, remove rvm if asdf works after 2018/5/1"
    zplug "johnhamelink/rvm-zsh"
fi

if [ -s /usr/local/opt/nvm/nvm.sh ]; then
    echo "use asdf instead of nvm: https://github.com/asdf-vm/asdf, remove nvm if asdf works after 2018/5/1"
    zplug "lukechilds/zsh-nvm"
fi

# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Load theme file
zplug 'pastleo/zsh-theme-past', as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load # --verbose

# General and other settings

CASE_SENSITIVE="false"

# Shared settings between bash and zsh
. $HOME/.zbashrc

