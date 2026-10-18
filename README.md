dotSetting
==========

home dot setting files managed by [GNU stow](https://www.gnu.org/software/stow/)

## How to install

First install `stow` via `pacman`, `yay` or `brew`, then:

```bash
mkdir -p ~/.config/
git clone https://github.com/pastleo/dotSetting.git ~/.config/dotSetting
cd ~/.config/dotSetting
./install.sh home
```

The installer requires explicit module names and installs only those modules.
For Omarchy, use `./install.sh omarchy` instead of the legacy `home` module;
see [the Omarchy setup notes](omarchy/README.md).

For a legacy setup with additional modules, use e.g. `./install.sh home macos`.

Before installing, the script runs a Stow dry run and asks whether to move each
conflicting file, symlink, or directory to `<path>.bak`. Existing backups are
preserved by using `.bak.1`, `.bak.2`, etc. Declining a backup stops installation;
any backups already approved remain in place. Conflicts between selected modules
may require manual resolution.

### Append snippets

Files ending in `.append` are excluded from Stow. After linking, the installer
offers to append each snippet in the selected modules to its matching path under
`$HOME`, with the `.append` suffix removed. For example, `home/.bashrc.append`
adds the shared shell initialization line to `~/.bashrc`.

This works for nested paths and multiline snippets in any module. Existing
contents are preserved, missing parent directories/files are created on approval,
and an exact block already present is skipped on subsequent runs. Declining a
snippet leaves its destination unchanged. Snippets are appended literally; shell
variables such as `$HOME` are expanded only when the resulting shell file runs.

Use `./install.sh` for modules containing snippets so they are processed rather
than symlinked. Removing a module with Stow does not remove appended contents.

### Uninstall installed modules

```
cd ~/.config/dotSetting
stow -v -t ~ -D home [other modules ...]
```
