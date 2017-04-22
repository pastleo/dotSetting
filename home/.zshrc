
#-------------------------------------------------------------
# ZPlug: https://zplug.sh
#-------------------------------------------------------------

if ! [ -f ~/.zplug/init.zsh ]; then
    curl -sL zplug.sh/installer | zsh
fi
source ~/.zplug/init.zsh

# About zplug syntax, visit:
# https://github.com/zplug/zplug#example

# Make sure to use double quotes
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "hchbaw/auto-fu.zsh"
zplug "mollifier/cd-gitroot"

if [ -d ~/.rvm ]; then
    zplug "johnhamelink/rvm-zsh"
fi

if [ -s /usr/local/opt/nvm/nvm.sh ]; then
    zplug "lukechilds/zsh-nvm"
fi

if [ -f ~/.homesick/repos/homeshick/homeshick.sh ]; then
    source ~/.homesick/repos/homeshick/homeshick.sh
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
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load # --verbose

# General settings

CASE_SENSITIVE="false"

