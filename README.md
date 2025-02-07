dotSetting
==========

After many years of usage in commandline, I got a lot of setting like `.bashrc`, `.vimrc`, `.tmux.conf`...

[GNU stow](https://www.gnu.org/software/stow/) is used to manage my dotSetting

## How to install

First install `stow` via `yay` or `brew`, then:

```bash
mkdir -p ~/.config/
git clone https://github.com/pastleo/dotSetting.git ~/.config/dotSetting
cd ~/.config/dotSetting
stow -t ~ --no-folding home [other modules ...]
```

### Uninstall installed modules

```
cd ~/.config/dotSetting
stow -t ~ -D home [other modules ...]
```
