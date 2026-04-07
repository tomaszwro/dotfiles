# echo ".zshrc"

eval "$(rbenv init - zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# function git_branch() {
#     local branch=$(git symbolic-ref HEAD 2>/dev/null | sed 's|refs/heads/||')
#     if [ -n "$branch" ]; then
#         echo " ($branch)"
#     fi
# }

# export PS1='%n@%m:%~$(git_branch)%# '

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

function rails_next_env {
  if [ -z "$RAILS_NEXT" ]
  then
      echo "{current rails}"
  else 
      echo "{next rails}"
  fi
}

COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
# export PROMPT='${COLOR_DIR}%1d ${COLOR_GIT}$(parse_git_branch) ${COLOR_USR}$(rails_next_env) ${COLOR_DEF}:: '
export PROMPT='${COLOR_DIR}%1d ${COLOR_GIT}$(parse_git_branch) ${COLOR_DEF}:: '


#
# FORMERLY BASHRC
#

# # source ~/.bash_aliases
# source ~/.zsh_aliases

# test -f ~/.fzf.bash && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='ag --nocolor --hidden --ignore .git --ignore sorbet --ignore \*.rbi --ignore node_modules -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# # -----
# # parts copied from: https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

# is_in_git_repo() {
#   git rev-parse HEAD > /dev/null 2>&1
# }

# fzf-down() {
#   fzf --height 50% --min-height 20 --border --bind ctrl-/:toggle-preview "$@"
# }

# _gb() {
#   is_in_git_repo || return
#   git branch --color=always | grep -v '/HEAD\s' | sort |
#   fzf-down --ansi --multi --tac --preview-window right:70% \
#     --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
#   sed 's/^..//' | cut -d' ' -f1 |
#   sed 's#^remotes/##'
# }

# if [[ $- =~ i ]]; then
#   bind '"\er": redraw-current-line'
#   bind '"\C-g\C-b": "$(_gb)\e\C-e\er"'
# fi
# # -----

# # Restore original history search after fzf changes it
# bind '"\C-r": reverse-search-history'

# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

##
##
##
##
## formerly BASH ALIASES
##
##
##
##


## alias ll='ls -lG'
#alias be='bundle exec'
## alias r='bundle exec rails'
## alias rk='bundle exec rake'
## alias mr='multigit'
## alias mg='multigit git'

## # function git_diff_raw_tracked   { git --no-pager diff --color -w --patience --word-diff=color $*; }
#function git_diff_raw_tracked   { git --no-pager diff --color -w --patience $*; }
#function git_diff_raw_untracked { git ls-files --other --exclude-standard | xargs -I% cat -n %; }
#function git_diff_raw_staged    { git_diff_raw_tracked --cached $*; }
#function git_diff_raw_all       {
#  git_diff_raw_staged  $* | sed 's/^/\>\>\> /'
#  git_diff_raw_tracked $* | sed 's/^/\ \ \  /'
#  git_diff_raw_untracked  | sed 's/^/\.\.\. /'
#}

#function gs   { git cherry -v; git status -s $*; }
#function gss  { git status -su | awk '{print $2 " " $1}' | sort; }
#function gd   { git_diff_raw_all $* | less -S; }
#function gc   {            git commit --verbose         $*; }
#function gca  { git add .; git commit --verbose         $*; }
#function gcaa { git add .; git commit --verbose --amend $*; }
#function gcac {            git commit --verbose --amend $*; }
#function gs_files { git status -su | cut -c 4-; }

#function gsa { git stash save --include-untracked $*; }
#function gsl { git stash list $*; }
#function gsh { git stash show -p $*; }
#function gsp { git stash pop $*; }
#function glc { git log -p --color $* | less -iRS +/^commit; }
#function gcp { git cherry-pick $*; }
#function glo { git log --oneline $*; }
#function gco { git checkout $*; }
#function gcb { git checkout -b $*; }

## function rtf   { echo "Running tests";                        bundle exec ruby -Itest $* && say green || say red; }
## function rta   { echo "Running tests";                        bundle exec rake test      && say green || say red; }
## function rtaff { echo "Running tests"; TESTOPTS="--fail-fast" bundle exec rake test      && say green || say red; }

## function hdb       { heroku run rails db -p; }
## function rdb       { psql     `ruby -ryaml -e 'puts YAML.load_file("config/database.yml")["development"]["database"]'`; }
## function rdb_pgcli { pgcli -d `ruby -ryaml -e 'puts YAML.load_file("config/database.yml")["development"]["database"]'`; }

## function mgs { multigit gs; }
## function mgd { multigitbox git_diff_raw_all | less -r; }

## function vg { nvim -c "G $*"; }
## function vd { nvim -c Ghunks; }
## function vh { nvim -c Ghunks; }
## function vo { nvim -c 'execute "normal \<C-O>\<C-O>"'; }
## function vs { nvim -c FilesModified; }
## function vn { nvim -c OpenNotes; cd ~/snapnote; gca -mupdate && git push; cd -; }

#function vim_with_no_arg_fallback { test $# -eq 0 && nvim -c "call OpenOldestFileFromCwd()" || nvim $*; }
#alias v='vim_with_no_arg_fallback'
#alias vi='vim_with_no_arg_fallback'
#alias vim='vim_with_no_arg_fallback'

## function remove_breakpoints {
##   git status -su | cut -c 4- | xargs sed -i '' '/binding\.pry/d'
##   git status -su | cut -c 4- | xargs sed -i '' '/puts_debuggerer/d'
## }

## alias tmoff='tm -o'
## alias tmstat='tm -s'
## alias tmedit='tm -e'

## # Enable aliases even if it's not an interactive shell. Otherwise aliases won't
## # be there if the file is sourced in vim's BASH_ENV.
## shopt -s expand_aliases
#setopt aliases

# commented out in favor of nvm
export PATH="/opt/homebrew/opt/node/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="/Users/tomaszwrobel/.local/bin:$PATH"

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
