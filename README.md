dotSetting
==========

After few years of usage in commandline, I got a lot of setting like `.bashrc`, `.vimrc`, `.tmux.conf`...  
When the time to migrate at a new machine, it might be somehow troubling. So I use [homeshick](https://github.com/andsens/homeshick)

## Requirement

 * bash
 * git
 * curl
 * rsync (if wanting to use `rsync.sh`)

## How to install

Using curl:

```
bash <(curl -s https://raw.githubusercontent.com/pastleo/dotSetting/master/install.sh)
```

Or from local disk (this will make a link pointing existing repo)

```
bash path/to/repo/install.sh
```

## Use real file instead of symlink

WARNING: This will overwrite existing files!

```
path/to/repo/rsync.sh
```

