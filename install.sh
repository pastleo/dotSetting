#!/bin/bash

# ## How to install

# Using curl:

# ```
# bash <(curl -s https://raw.githubusercontent.com/pastleo/dotSetting/master/install.sh)
# ```

# Or from local disk (this will make a link pointing existing repo)

# ```
# bash path/to/repo/install.sh
# ```

if [[ ! -f $HOME/.homesick/repos/homeshick/homeshick.sh ]]; then
  git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi

source $HOME/.homesick/repos/homeshick/homeshick.sh

if [ -x $0 ]; then
  # executed from local repo
  repo_path="$(cd "$(dirname "$0")"; pwd)"
  repo_name="$(basename $repo_path)"
  ln -s $repo_path "$HOME/.homesick/repos/$repo_name"
  homeshick link $repo_name
else
  # executed from curl or wget
  homeshick clone https://github.com/pastleo/dotSetting.git
fi
