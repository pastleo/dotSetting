#!/bin/bash

set -e

module=${2:-home}

if [[ -z "$1" ]]; then
  echo "Usage: $0 <file> [module]"
  echo "  file: path to the file to track (absolute or relative)"
  echo "  module: stow module to use (default: home)"
  exit 1
fi

# cd to SCRIPT_DIR
cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null
repo_dir="$(pwd)"

# resolve the file path
file_path="$(realpath "$1")"

if [[ ! -e "$file_path" ]]; then
  echo "Error: $file_path does not exist"
  exit 1
fi

if [[ -L "$file_path" ]]; then
  echo "Error: $file_path is already a symlink"
  exit 1
fi

# get path relative to home
if [[ "$file_path" != "$HOME"/* ]]; then
  echo "Error: $file_path is not under \$HOME"
  exit 1
fi

rel_path="${file_path#$HOME/}"
dest_path="$repo_dir/$module/$rel_path"

echo "Will do:"
echo "  mkdir -p $(dirname "$dest_path")"
echo "  mv $file_path $dest_path"
echo "  stow -t ~ --no-folding $module"
echo ""

read -p "(Press Y to continue) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

mkdir -p "$(dirname "$dest_path")"
mv "$file_path" "$dest_path"
stow -t ~ --no-folding "$module"
echo "Done. $rel_path is now tracked in $module"
