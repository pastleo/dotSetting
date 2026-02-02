#!/bin/bash

targets=${@:-home}

# cd to SCRIPT_DIR
cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null
echo "pwd: $(pwd)"

echo "Will do:"
echo "  stow -t ~ --no-folding $targets"
echo ""
echo "BTW, if there are existing files not stowed, please delete manually"

read -p "(Press Y to continue) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

stow -t ~ --no-folding $targets
echo "Done."

