#!/bin/bash

targets=${@//home/}
targets="home $targets"

cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null
echo "dotSetting at: $(pwd)"
echo ""

echo "Installing symlinks via stow:"
echo "  stow -v -t ~ --no-folding $targets"
echo ""
echo "About stow: https://www.gnu.org/software/stow/"
echo "BTW, if there are existing files not stowed, please delete manually"

read -p "(Press Y to continue) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  stow -v -t ~ --no-folding $targets
  echo "stow done"
else
  echo "exiting..."
  exit
fi

BASHRC_SOURCE='source "$HOME/.config/shrc/bashrc"'
if ! grep -q "$BASHRC_SOURCE" "$HOME/.bashrc"; then
  echo ""
  echo "Injecting .bashrc:"
  echo "  echo \"$BASHRC_SOURCE\" >> \"\$HOME/.bashrc\""
  echo ""

  read -p "(Press Y to continue) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "$BASHRC_SOURCE" >> "$HOME/.bashrc"
    echo ".bashrc injected"
  else
    echo ".bashrc skipped"
  fi
fi

if ! grep -q "$BASHRC_SOURCE" "$HOME/.bash_profile"; then
  echo ""
  echo "Injecting .bash_profile:"
  echo "  echo \"$BASHRC_SOURCE\" >> \"\$HOME/.bash_profile\""
  echo ""

  read -p "(Press Y to continue) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "$BASHRC_SOURCE" >> "$HOME/.bash_profile"
    echo ".bash_profile injected"
  else
    echo ".bash_profile skipped"
  fi
fi

ZSHRC_SOURCE='source "$HOME/.config/shrc/zshrc"'
if ! grep -q "$ZSHRC_SOURCE" "$HOME/.zshrc"; then
  echo ""
  echo "Injecting .zshrc:"
  echo "  echo \"$ZSHRC_SOURCE\" >> \"\$HOME/.zshrc\""
  echo ""

  read -p "(Press Y to continue) " -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "$ZSHRC_SOURCE" >> "$HOME/.zshrc"
    echo ".zshrc injected"
  else
    echo ".zshrc skipped"
  fi
fi
