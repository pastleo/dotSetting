# vim: set ft=sh:
# PastLeo's ~/.bashrc

printf "  > starting bash...\n\033[1A"

# -----------------------------
# Pre-check and host bashrc
# -----------------------------

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# source global definitions (if any)
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# -----------------------------
# Shared rc for bash/zsh
# -----------------------------

if [ -f "$HOME/.shrc" ]; then
  source "$HOME/.shrc"
fi

# -----------------------------
# Start zsh from bash according to ZSH_STACK
# -----------------------------

if [ -z "$ZSH_STACK" ]; then
  if hash zsh 2>/dev/null; then
    export ZSH_STACK=0
  fi
fi
if [ -n "$TMUX" ]; then
  zsh_stack_should_below=2
else
  zsh_stack_should_below=1
fi
if [ -n "$ZSH_STACK" ] && [ -n "$UTF8_READY" ] && [ "$ZSH_STACK" -lt "$zsh_stack_should_below" ]; then
  zsh
  exit
fi

# To disable zsh inside session / prevent launching zsh from bash:
#   just call `bash` or `sh`
# To disable zsh completely:
#   export ZSH_STACK=2 in $HOME/.shrc.local
# Search ZSH_STACK in .zshrc for more detail

# -----------------------------
# Bash prompt (PS1)
# -----------------------------

PS1.PastLeoDynamicPrompt()
{
  local promptTmp
  local color

  # user type:
  if [[ ${USER} == "root" ]]; then
    # user is root:
    promptTmp="\[\033[41m\]\[\033[30m\] \u "
    color="Red"
  else
    promptTmp="\[\033[42m\]\[\033[30m\] \u "
    color="Green"
  fi

  # shell start from:
  if [ -n "${SSH_CONNECTION}" ]; then
    # via ssh:
    promptTmp=$promptTmp"\[\033[30m\]\[\033[44m\] \H "
    color="Blue"
  elif [[ "${DISPLAY%%:0*}" != "" ]]; then
    # not via ssh:
    promptTmp=$promptTmp"\[\033[30m\]\[\033[45m\] \H "
    color="Purple"
  fi 
  case $color in
    Red)
      promptTmp=$promptTmp"\[\033[1;31m\]\[\033[40m\] \W \[\033[0m\]\[\033[30m\] > \[\033[0m\]"
      ;;
    Green)
      promptTmp=$promptTmp"\[\033[1;32m\]\[\033[40m\] \W \[\033[0m\]\[\033[30m\] > \[\033[0m\]"
      ;;
    Blue)
      promptTmp=$promptTmp"\[\033[1;34m\]\[\033[40m\] \W \[\033[0m\]\[\033[30m\] > \[\033[0m\]"
      ;;
    Purple)
      promptTmp=$promptTmp"\[\033[1;35m\]\[\033[40m\] \W \[\033[0m\]\[\033[30m\] > \[\033[0m\]"
      ;;
  esac

  export PS1=$promptTmp
}

PS1.PastLeoDynamicPrompt

type shrc_session_start_report > /dev/null 2>&1 && shrc_session_start_report
