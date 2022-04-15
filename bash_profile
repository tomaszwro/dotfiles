source ~/.bashrc
source ~/.bash_dev_env

export PATH="$PATH:$HOME/bin:/usr/local/Cellar/libpq/11.1/bin"
export PS1='\[\e[32m\]\j \W ⎇  $(test -d .git && git rev-parse --abbrev-ref HEAD) >\[\e[m\] '
export PAGER="/usr/bin/less -S"
export LESS="iRSM"
export EDITOR="nvim"
export GIT_EDITOR="nvim"

# probably the best advice: https://unix.stackexchange.com/a/18443
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTIGNORE="tm *"
shopt -s histappend
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

export PATH="/usr/local/opt/node@14/bin:$PATH"
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

eval "$(rbenv init -)"
