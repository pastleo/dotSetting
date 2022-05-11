dotSetting
==========

After few years of usage in commandline, I got a lot of setting like `.bashrc`, `.vimrc`, `.tmux.conf`...  
[Homeshick](https://github.com/andsens/homeshick) is used to manage my dotSetting

## Software

* `bash`
  * `zsh` for advance shell
* `git`
* `vim`

> on mac, it is recommanded to install and use `git`, `vim`, `zsh` from [`brew`](https://brew.sh/)

## How to install

Using `curl`:

```
bash <(curl -s https://raw.githubusercontent.com/pastleo/dotSetting/master/install.sh)
```

Or from local disk (this will make a link pointing existing repo)

```
bash path/to/repo/install.sh
```

## Use real file instead of symlink

> `rsync` is required for this

WARNING: This will overwrite existing files!

```
path/to/repo/rsync.sh
```
