# ===============================================================
# PERSONAL $HOME/.bashrc FILE for bash-3.0 (or later)
# By PastLeo
# ===============================================================

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions (if any)
if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

# ================================================
# autostart x at login
# ================================================

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] && hash startx; then
    exec startx 
fi

#--------------------------------------------------------------
#  Automatic setting of $DISPLAY (if not set already).
#  This works for me - your mileage may vary. . . .
#  The problem is that different types of terminals give
#+ different answers to 'who am i' (rxvt in particular can be
#+ troublesome) - however this code seems to work in a majority
#+ of cases.
#--------------------------------------------------------------

hostname &> /dev/null && export HOSTNAME=$(hostname)

function get_xserver ()
{
    case $TERM in
        xterm )
            XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
            # Ane-Pieter Wieringa suggests the following alternative:
            #  I_AM=$(who am i)
            #  SERVER=${I_AM#*(}
            #  SERVER=${SERVER%*)}
            XSERVER=${XSERVER%%:*}
            ;;
            aterm | rxvt)
            # Find some code that works here. ...
            ;;
    esac
}

if [ -z ${DISPLAY:=""} ]; then
    get_xserver
    if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) ||
       ${XSERVER} == "unix" ]]; then
          DISPLAY=":0.0"          # Display on local host.
    else
       DISPLAY=${XSERVER}:0.0     # Display on remote host.
    fi
fi

export DISPLAY

# ================================================
# terminal bash color codes:
# ================================================
# color control unit: "\[\033["+color_code+"m\]"
#
# Color codes:

# Normal Colors (Foreground)
Foregrounds="Black Red Green Yellow Blue Purple Cyan White"

Black="0;30"
Red="0;31"
Green="0;32"
Yellow="0;33"
Blue="0;34"
Purple="0;35"
Cyan="0;36"
White="0;37"

# Bright & Bold (Foreground)
Bolds="BBlack BRed BGreen BYellow BBlue BPurple BCyan BWhite"

BBlack="1;30"
BRed="1;31"
BGreen="1;32"
BYellow="1;33"
BBlue="1;34"
BPurple="1;35"
BCyan="1;36"
BWhite="1;37"


# Background
Backgrounds="bBlack bRed bGreen bYellow bBlue bPurple bCyan bWhite"

bBlack="40"
bRed="41"
bGreen="42"
bYellow="43"
bBlue="44"
bPurple="45"
bCyan="46"
bWhite="47"

_c()
{
    if [[ "$#" -ge 1 ]]; then
        for codes in $@; do
            printf "\033[%sm" "$( eval echo \$$codes )"
        done
    else
        printf "\033[0m"
    fi
}

cprintf()
{
    _c "$1"
    shift
    printf "$@"
    _c
}

cecho()
{
    _c "$1"
    printf "$2"
    _c
    printf "\n"
}

#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

echo -e "Greetings, $(cprintf Green $USER). This is $(cprintf BBlue $(hostname) ) display on [$( cprintf 'BCyan' $DISPLAY )] at $(cprintf Purple "$(date '+%Y/%m/%d %A %H:%M')")"

# You can specify your own greeting message!
if [[ -f "$HOME/.welcomeMsg" ]]; then
    cat ~/.welcomeMsg
fi

function _exit()              # Function to run upon exit of shell.
{
    cecho "BRed" "Hasta la vista, baby"
}
trap _exit EXIT

# ================================================
# path variable
# ================================================

if [[ "$path_sys" ]]; then
    export PATH=$path_sys
fi
add_path()
{
    tmp="$1:${PATH//$1/}"
    export PATH="${tmp//::/:}"
}
add_path "/usr/local/bin"
add_path "/usr/local/sbin"

export path_sys=$PATH

add_path "$HOME/.bin"

# ================================================
# Personal Environment
# ================================================

if [ -f ~/.per_env ]; then
    source ~/.per_env
fi

# #####################################################
# If there is more thing to add for both fish and bash
# put them down below before fish starts
# #####################################################

export GOPATH="~/.golang/"

# ================================================
# my ls by $LS_PARAM
# ================================================
if ls --help 2>&1 | grep -q -- --color; then
    export LS_PARAM='--color -hF'
else
    export LS_PARAM='-Gh'
fi

# ================================================
# less
# ================================================

if [[ "$(which less)" ]]; then
    export PAGER=less
    LESSPIPE=`which src-hilite-lesspipe.sh 2> /dev/null`
    if [[ "$LESSPIPE" ]]; then
        export LESSOPEN="| ${LESSPIPE} %s"
        if [[ "$OSTYPE" == "linux-gnu" ]]; then
            export LESS=' -R '
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            export LESS=' -R -X -F '
        fi
    fi
fi

# ================================================
# Start from out side term workdir by env
# ================================================

if [ -d "$_START_WD" ]; then
    cd "$_START_WD"
fi

# ================================================
# Start advance shell if this machine has
# ================================================

if [ ! $disable_advance_shell ]; then
    if hash zsh 2>/dev/null; then
        zsh
        exit
    fi
fi

# If no advance shell, continue the bash setting...

#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

# Case insensitive
bind "set completion-ignore-case on"

# ================================================
# PastLeo custome static terminal prompt theme:
# (use PS1.* to choose one)
# ================================================

alias PS1.no-color='export PS1="\u | \W $ "'

alias PS1.lagacy='export PS1="\[\e[0;32m\]\u\[\e[0;37m\] | \[\e[0;36m\]\W \[\e[0m\]"$'

alias PS1.hostname_on-fancy='export PS1="\[\033[42m\]\[\033[1;30m\]\u\[\033[1;32m\]\[\033[44m\]◤ \[\033[1;30m\]\H\[\033[1;34m\]\[\033[40m\]◤ \[\033[1;36m\]\W\[\033[0m\]\[\033[1;30m\]◤ \[\033[0m\]"'
alias PS1.hostname_off-fancy='export PS1="\[\033[42m\]\[\033[1;30m\]\u\[\033[1;32m\]\[\033[40m\]◤ \W\[\033[0m\]\[\033[1;30m\]◤ \[\033[0m\]"'
alias PS1.fullpath-fancy='export PS1="\[\033[42m\]\[\033[1;30m\]\u\[\033[1;32m\]\[\033[40m\]◤ \w\[\033[0m\]\[\033[1;30m\]◤ \[\033[0m\]"'

alias PS1.hostname_off='export PS1="\[\033[42m\]\[\033[1;30m\]\u \[\033[1;32m\]\[\033[40m\] \W \[\033[0m\]\[\033[1;30m\] > \[\033[0m\]"'
alias PS1.hostname_on='export PS1="\[\033[42m\]\[\033[1;30m\]\u \[\033[1;30m\]\[\033[44m\] \H \[\033[1;34m\]\[\033[40m\] \W \[\033[0m\]\[\033[1;30m\] > \[\033[0m\]"'

# =============================================================
# PastLeo Dynamic Shell Prompt (Not Support when ssh or su!)
# Only detect if is remote...
# =============================================================
#
# Format:
#    User  Host  PWD  >
#    [   ][    ][   ][ ]
#
# USER:
#    Green     == normal user
#    Yellow    == SU to user
#    Red       == root
# HOST:
#    Hidden    == local session
#    Blue      == secured remote connection (via ssh)
#    Red       == unsecured remote connection
# PWD:
#    Black
# >:
#    Black
#
#    Command is added to the history file each time you hit enter,
#    so it's available to all shells (using 'history -a').

PS1.PastLeoDynamicPrompt()
{
    local promptTmp
    local color

    # promptTmp="$(c BBlack)"

    # Test user type:
    if [[ ${USER} == "root" ]]; then
        # User is root.
        promptTmp="\[\033[41m\]\[\033[1;30m\]\u "
        color="Red"
    elif [[ ${USER} != $(logname) ]]; then
        # User is not login user.
        promptTmp="\[\033[43m\]\[\033[1;30m\]\u "
        color="Yellow"
    else
        # User is normal (well ... most of us are).
        promptTmp="\[\033[42m\]\[\033[1;30m\]\u "
        color="Green"
    fi
    # promptTmp=$promptTmp"$(c b$color)\u "

    # Test connection type:
    if [ -n "${SSH_CONNECTION}" ]; then
        # Connected on remote machine, via ssh (good).
        # promptTmp=$promptTmp"$(c bBlue) \H "
        promptTmp=$promptTmp"\[\033[1;30m\]\[\033[44m\] \H "
        color="Blue"
    elif [[ "${DISPLAY%%:0*}" != "" ]]; then
        # Connected on remote machine, not via ssh (bad).
        # promptTmp=$promptTmp"$(c bPurple) \H "
        promptTmp=$promptTmp"\[\033[1;30m\]\[\033[45m\] \H "
        color="Purple"
    fi 
    case $color in
        Red)
        promptTmp=$promptTmp"\[\033[1;31m\]\[\033[40m\] \W \[\033[0m\]\[\033[1;30m\] > \[\033[0m\]"
            ;;
        Yellow)
        promptTmp=$promptTmp"\[\033[1;33m\]\[\033[40m\] \W \[\033[0m\]\[\033[1;30m\] > \[\033[0m\]"
            ;;
        Green)
        promptTmp=$promptTmp"\[\033[1;32m\]\[\033[40m\] \W \[\033[0m\]\[\033[1;30m\] > \[\033[0m\]"
            ;;
        Blue)
        promptTmp=$promptTmp"\[\033[1;34m\]\[\033[40m\] \W \[\033[0m\]\[\033[1;30m\] > \[\033[0m\]"
            ;;
        Purple)
        promptTmp=$promptTmp"\[\033[1;35m\]\[\033[40m\] \W \[\033[0m\]\[\033[1;30m\] > \[\033[0m\]"
            ;;
    esac
    # promptTmp=$promptTmp"$(c B$color bBlack) \W $(c Black) > $(c)"

    export PS1=$promptTmp
}

# =============================================================
# Default PS1:
PS1.PastLeoDynamicPrompt
# =============================================================

# =============================================================
# 3rd party components Settings
# =============================================================

# ruby version manager, rvm
# https://rvm.io/
if [[ -s ~/.rvm/scripts/rvm ]]; then
    source ~/.rvm/scripts/rvm
    add_path "$HOME/.rvm/bin"
fi

# node version manager, nvm
# https://github.com/creationix/nvm
export NVM_DIR="$HOME/.nvm"
if [[ -s /usr/local/opt/nvm/nvm.sh ]]; then
    . /usr/local/opt/nvm/nvm.sh
fi

# homeshick: git dotfiles synchronizer written in bash
# https://github.com/andsens/homeshick
if [ -f ~/.homesick/repos/homeshick/homeshick.sh ]; then
    source ~/.homesick/repos/homeshick/homeshick.sh
fi

