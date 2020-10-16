# PastLeo's ~/.zshrc

printf "  > starting zsh...\n\033[1A"

# -----------------------------
# Shared rc for bash/zsh
# -----------------------------

if [ -f "$HOME/.shrc" ]; then
  source "$HOME/.shrc"
fi

# -----------------------------
# General settings
# -----------------------------

CASE_SENSITIVE="false"

# -----------------------------
# set to zsh for tmux
# -----------------------------

export TMUX_DEFAULT_SHELL="$(which zsh)"

# -----------------------------
# ZPlug: https://zplug.sh
# -----------------------------

export ZPLUG_HOME="$HOME/.zplug"
if ! [ -f "$ZPLUG_HOME/init.zsh" ]; then
  echo "zplug not installed, run this to clone zplug:"
  echo "  git clone https://github.com/zplug/zplug \"$ZPLUG_HOME\""
  echo "for more info: https://github.com/zplug/zplug"
  return
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

type shrc_session_start_report > /dev/null 2>&1 && shrc_session_start_report
