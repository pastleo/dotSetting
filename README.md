dotSetting
==========

home dot setting files managed by [GNU stow](https://www.gnu.org/software/stow/)

## How to install

First install `stow` via `pacman`, `yay` or `brew`, then:

```bash
mkdir -p ~/.config/
git clone https://github.com/pastleo/dotSetting.git ~/.config/dotSetting
cd ~/.config/dotSetting
./install.sh
```

### Uninstall installed modules

```
cd ~/.config/dotSetting
stow -v -t ~ -D home [other modules ...]
```
