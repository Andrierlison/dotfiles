#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# JAVA PATH
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
export ANDROID_HOME=~/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH=$PATH:~/android-studio/bin

export PATH="$PATH:`pwd`/flutter/bin"

export EDITOR=vim

export HISTCONTROL=ignoreboth:erasedups

export TERM=xterm-256color

alias vimconf='vim -O ~/.vimrc ~/.vim/coc-settings.json'

alias updateAndClean='sudo pacman -Syu && sudo pacman -Scc && yay -Syu && yay -Scc && rm -r ~/.cache'

set -o vi


