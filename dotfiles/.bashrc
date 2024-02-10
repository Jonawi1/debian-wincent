# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Show neofetch when starting therminal.
#clear
#printf "\n"
#neofetch

# Allow vi commands on command line.
#set -o vi

# Ignore duplicate and lines starting with space in the history.
HISTCONTROL=ignoreboth

# Set number of lines in active history and in Bash history.
HISTSIZE=2000
HISTFILESIZE=2000

# Append to the history file, don't overwrite it.
shopt -s histappend

# Check window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

source ~/.config/fancy-prompt.sh

# Enable color support to ls.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Alias
alias sudo='sudo '
alias v=nvim
alias ll='ls -lhA'
alias la='ls -a'

alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gps='git push'
alias gpl='git pull'
alias gb='git checkout -b'
alias gd='git diff'
alias gf='git fetch'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c='clear'
alias h='history'
alias mkdir='mkdir -p -v'

alias clip='xclip -selection clipboard'
