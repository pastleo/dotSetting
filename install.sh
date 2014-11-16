#!/bin/bash
# auto_install_setting
# Author: PastLeo
# Date: 20141115
# ==========================

oriPwd="$PWD"

exeDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for src in homeDir custom; do
    echo "====================================================="
    echo "Processing all files under"
    echo "$exeDIR/$src"

    cd "$exeDIR/$src" &> /dev/null;

    if [[ ! "$?" -eq "0" ]]; then
        echo "This folder does not exists!"
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
            echo "rsync -av $exeDIR/$src/$f $HOME/.$f"
            rsync -av "$exeDIR/$src/$f" "$HOME/.$f"
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
