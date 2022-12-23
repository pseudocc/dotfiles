# ~/.bash_profile: executed by bash(1) for login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

for file in $HOME/.{path,bash_aliases,bash_prompt,exports,misc}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file;

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

if [ -x /usr/bin/tput ] && tput setaf 1>& /dev/null; then
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\u@\h:\w\$ '
fi

set -o vi
