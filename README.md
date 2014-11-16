dotSetting
==========

After few years of usage in cli, I got a lot of setting like `.bashrc`, `.vimrc`, `.tmux.conf`...  
When the time to migrate at a new machine, it might be somehow troubling. So I make this small provision tool to make it more easy~  
Further more, I share my setting in this repo inside `homeDir` folder while you can still keeping your own settings inside `custom` folder (or fork this repo XDD). 

## Requirement

 * bash
 * git, mostly
 * rsync 

## HOW TO USE THIS?

 * `git clone git@github.com:chgu82837/dotSetting.git` to whatever folder
 * `cd` to the repo you just cloned
 * `mkdir custom` to create the space you can specify (this folder is excluded from git)
 * copy your original setting to the `custom` folder, it is good to look through my setting and modify yours or mine (forking is welcome again XD) to get it work better.
 * `cd` to the root of this repo
 * **backup** your original setting just in case. 
 * `sh install.sh` to provision all of them
 * `source ~/.bashrc` or restart your session to test if it works

## Setting Conponents in this repo

 * bash compatible with OSX since I am a mac user
    * `bashrc`
    * `bash_profile`
    * `welcomeMsg`
 * fish shell
    * `config/fish`
 * git
    * `gitconfig`
    * `gitignore`
 * tmux
    * `tmux.conf`
 * vim
    * `vimrc`
    * `vim/`
 * ssh
    * `ssh/authorized_keys`

## How the `install.sh` works?

Foreach `homeDir` and `custom`, rsyncs each files / folders in it to your home folder with adding the `.` at the beginning of filename.

## Advance usage of the custom folder by git

You might think:  

```
Ehh... I still have to put my own setting which again becomming troubling...  
```

If you got private repos from wherever git server provides. You can use the custom folder like this (like me).  

#### The first time

These steps is how I create my own `custom` folder and put it to the git cloud.  

 * After creating your own setting inside `custom`, `cd` to the root of it.
 * `git init`, `git add .`, `git commit -m "my private setting"`.
 * get one private repo of your own with the remote url.
 * `git remote add origin {private_repo_url}`.
 * `git pull origin master`, `git commit -m "merge"`, `git push origin master`.

#### Provision to other machine (Not first time)

These steps will pull your settings from git clouds easily.  

 * make sure the host has the permission to git clone your private repo (by ssh key for example).
 * `git clone git@github.com:chgu82837/dotSetting.git`.
 * cd to the repo.
 * `git clone {private_repo_url} custom/`.
 * `sh install.sh`.
 * `source ~/.bashrc` or restart your session to test if it works
 * Done, and you can use git to sync all your settings through different machines.

## Forking is welcome

If you got so many differs from me, of course you can just use the auto-provision framework by forking this repo and make changes in homeDir as much as you like!

## CC0 LICENSE

Copy this as much as you like.
