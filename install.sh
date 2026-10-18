#!/bin/bash

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 <module> [module ...]"
  echo "Examples: $0 omarchy | $0 home | $0 home macos"
  exit 1
fi

targets=("$@")
stow_options=(-v -t "$HOME" --no-folding --ignore='\.append$')

cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null || exit 1
echo "dotSetting at: $(pwd)"
echo ""

echo "Installing symlinks via stow:"
echo "  stow -v -t ~ --no-folding --ignore='\.append$' ${targets[*]}"
echo ""
echo "About stow: https://www.gnu.org/software/stow/"
echo "Conflicting files can be moved to .bak after individual confirmation."

backup_conflicts() {
  local output line relative path backup index
  local unowned='^  \* existing target is not owned by stow: (.+)$'
  local existing='^  \* cannot stow .+ over existing target (.+) since neither a link nor a directory and --adopt not specified$'
  local directory='^  \* cannot stow non-directory .+ over existing directory target (.+)$'
  local -a conflicts
  local -A seen

  while ! output=$(LC_ALL=C stow --simulate "${stow_options[@]}" "${targets[@]}" 2>&1); do
    conflicts=()
    seen=()
    while IFS= read -r line; do
      if [[ "$line" =~ $unowned || "$line" =~ $existing || "$line" =~ $directory ]]; then
        relative=${BASH_REMATCH[1]}
        path="$HOME/$relative"
        if [[ "$relative" == /* || "/$relative/" == */../* || ! -e "$path" && ! -L "$path" ]]; then
          echo "$output" >&2
          echo "This conflict cannot be resolved by backing up an existing target." >&2
          return 1
        fi
        if [[ ! ${seen[$relative]+exists} ]]; then
          conflicts+=("$path")
          seen[$relative]=1
        fi
      elif [[ "$line" == "  * "* ]]; then
        echo "$output" >&2
        echo "Stow reported a conflict that requires manual resolution." >&2
        return 1
      fi
    done <<< "$output"

    if [ "${#conflicts[@]}" -eq 0 ]; then
      echo "$output" >&2
      return 1
    fi

    for path in "${conflicts[@]}"; do
      backup="$path.bak"
      index=1
      while [[ -e "$backup" || -L "$backup" ]]; do
        backup="$path.bak.$index"
        ((index++))
      done
      echo ""
      printf 'Conflict: %s\n' "$path"
      printf 'Move to:  %s\n' "$backup"
      if ! read -r -p "Back up this conflict? [y/N] " || [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation stopped; conflict left in place."
        return 1
      fi
      mv -- "$path" "$backup" || return 1
    done
  done
}

backup_conflicts || exit 1
stow "${stow_options[@]}" "${targets[@]}" || exit "$?"
echo "stow done"

append_snippets() (
  shopt -s dotglob globstar nullglob
  for target in "${targets[@]}"; do
    for snippet in "$target"/**/*.append; do
      [[ -f "$snippet" ]] || continue
      relative=${snippet#"$target"/}
      path="$HOME/${relative%.append}"
      content=$(<"$snippet")
      [[ -n "$content" ]] || continue

      # Match a literal, complete block of lines, even in a larger file.
      if [[ -f "$path" ]]; then
        existing=$'\n'"$(<"$path")"$'\n'
        [[ "$existing" == *$'\n'"$content"$'\n'* ]] && continue
      fi

      printf '\nAppend %s to %s:\n%s\n' "$snippet" "$path" "$content"
      if read -r -p "Append this snippet? [y/N] " && [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p -- "$(dirname -- "$path")" || return 1
        printf '\n%s\n' "$content" >> "$path" || return 1
        printf '%s appended\n' "$path"
      else
        printf '%s skipped\n' "$path"
      fi
    done
  done
)

append_snippets || exit "$?"
