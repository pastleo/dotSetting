#!/bin/bash
# auto_install_setting
# Author: PastLeo
# Date: 20141115
# ==========================

oriPwd="$PWD"

exeDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

echo "~/.bin/ exec permission added!"

cd $oriPwd

echo "============= dotSetting auto installation completed! ============="
