source ~/.bash_aliases

test -f ~/.fzf.bash && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# Restore original history search after fzf changes it
bind '"\C-r": reverse-search-history'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
