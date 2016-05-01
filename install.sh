#!/bin/bash
# auto_install_setting
# Author: PastLeo
# Date: 20141115
# ==========================

oriPwd="$PWD"

exeDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function ask()
{
        echo "Do you want to $1?"
        echo ' Your choise: [y/n] ' ; read ans
        case "$ans" in
            y*|Y*) shift; $@ ;;
        esac
}

function remove_after_confirm()
{
    if ! [[ -a $1 ]]; then
        return
    fi
    if [[ -d $1 ]]; then
        ask "remove $1" rm -Rvf $1
    fi
}

if [ ! $1 ]; then
    echo "dotSetting installer"
    echo "=========================="
    echo "Usage:"
    echo "    sh $0 [folder_1 [folder_2 ...]]"
    echo ""

    src_folders="homeDir custom"
else
    src_folders=$@
fi

# Update all submodules
cd $exeDIR

for src in $src_folders; do
    echo "====================================================="
    echo "Processing all files under"
    echo "$exeDIR/$src"

    cd "$exeDIR/$src" &> /dev/null;

    if [[ ! "$?" -eq "0" ]]; then
        echo "The $src folder does not exists!"
        echo "You can specify your own setting under the folder"
        echo "====================================================="
        echo ""
        continue
    fi
    echo "====================================================="

    for f in *
    do
        if [[ -d "$exeDIR/$src/$f" ]]; then
            echo "rsync -av $exeDIR/$src/$f/ $HOME/.$f"
            rsync -av "$exeDIR/$src/$f/" "$HOME/.$f"
        else
            case $f in
            README*)
                ;;
            *.sh)
                ;;
            *)
                echo "rsync -av $exeDIR/$src/$f $HOME/.$f"
                rsync -av "$exeDIR/$src/$f" "$HOME/.$f"
                ;;
            esac
        fi
    done
    echo ""
done

# Specify some other fix here
# Mostly are permission fix

if [[ -f "$HOME/.ssh/authorized_keys" ]]; then
    chmod 700 "$HOME/.ssh"
    chmod 600 "$HOME/.ssh/authorized_keys"
    echo "~/.ssh/authorized_keys permission set!"
fi

chmod -R u+x "$HOME/.bin/"

echo "$HOME/.bin/ exec permission added!"

cd $oriPwd

remove_after_confirm $HOME/.oh-my-fish
remove_after_confirm $HOME/.local/share/omf

plug_vim_dir=$HOME/.vim/autoload
mkdir -p $plug_vim_dir
cd $plug_vim_dir
curl -fLo plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ask "install vim plugins" vim +PlugInstall +qall 
# ask "install vim plugins" vim +PluginInstall +qall

echo "============= dotSetting auto installation completed! ============="
echo " >> You need to restart the session to apply the config!"
