# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

[ -r ~/.git-prompt.sh ] && source ~/.git-prompt.sh


black=$(tput -Txterm setaf 0)
red=$(tput -Txterm setaf 1)
green=$(tput -Txterm setaf 2)
yellow=$(tput -Txterm setaf 3)
dk_blue=$(tput -Txterm setaf 4)
pink=$(tput -Txterm setaf 5)
lt_blue=$(tput -Txterm setaf 6)
lt_green='\e[92m'

bold=$(tput -Txterm bold)
reset=$(tput -Txterm sgr0)

__has_parent_dir () {
    # Utility function so we can test for things like .git/.hg without firing up a
    # separate process
    test -d "$1" && return 0;

    current="."
    while [ ! "$current" -ef "$current/.." ]; do
        if [ -d "$current/$1" ]; then
            return 0;
        fi
        current="$current/..";
    done

    return 1;
}


__vcs_name() {
    if [ -d .svn ]; then
        echo "-[svn]";
    elif __has_parent_dir ".git"; then
        echo "[$(__git_ps1 '%s')]";
    elif __has_parent_dir ".hg"; then
        echo "-[hg $(hg branch)]"
    fi
}

# Nicely formatted terminal prompt
export PS1='\[$bold\]\e[92m\u@\h:\[$dk_blue\]\W \[$red\]$(__vcs_name)\e[92m\$ '

