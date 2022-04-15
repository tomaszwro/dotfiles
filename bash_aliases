# Enable aliases even if it's not an interactive shell. Otherwise aliases won't
# be there if the file is sourced in vim's BASH_ENV.
shopt -s expand_aliases

alias ll='ls -lG'
alias be='bundle exec'
alias r='bundle exec rails'
alias rk='bundle exec rake'
alias mr='multigit'
alias mg='multigit git'

# function git_diff_raw_tracked   { git --no-pager diff --color -w --patience --word-diff=color $*; }
function git_diff_raw_tracked   { git --no-pager diff --color -w --patience $*; }
function git_diff_raw_untracked { git ls-files --other --exclude-standard | xargs cat -n; }
function git_diff_raw_staged    { git_diff_raw_tracked --cached $*; }
function git_diff_raw_all       {
  git_diff_raw_staged  $* | sed 's/^/\>\>\> /'
  git_diff_raw_tracked $* | sed 's/^/\ \ \  /'
  git_diff_raw_untracked  | sed 's/^/\.\.\. /'
}

function gs   { git cherry -v; git status -s $*; }
function gd   { git_diff_raw_all $* | less -S; }
function gc   {            git commit --verbose         $*; }
function gca  { git add .; git commit --verbose         $*; }
function gcaa { git add .; git commit --verbose --amend $*; }
function gcac {            git commit --verbose --amend $*; }

function gsa { git stash save --include-untracked $*; }
function gsl { git stash list $*; }
function gsh { git stash show -p $*; }
function gsp { git stash pop $*; }
function glc { git log -p --color $* | less -iRS +/^commit; }

function gco { git checkout $*; }
function gcb { git checkout -b $*; }

function rtf   { echo "Running tests";                        bundle exec ruby -Itest $* && say green || say red; }
function rta   { echo "Running tests";                        bundle exec rake test      && say green || say red; }
function rtaff { echo "Running tests"; TESTOPTS="--fail-fast" bundle exec rake test      && say green || say red; }

function hdb       { heroku run rails db -p; }
function rdb       { psql     `ruby -ryaml -e 'puts YAML.load_file("config/database.yml")["development"]["database"]'`; }
function rdb_pgcli { pgcli -d `ruby -ryaml -e 'puts YAML.load_file("config/database.yml")["development"]["database"]'`; }

function mgs { multigit gs; }
function mgd { multigitbox git_diff_raw_all | less -r; }

function vg { nvim -c "G $*"; }
function vd { nvim -c Ghunks; }
function vh { nvim -c Ghunks; }
function vo { nvim -c 'execute "normal \<C-O>\<C-O>"'; }
function vs { nvim -c FilesModified; }
function vn { nvim -c OpenNotes; }

function vim_with_no_arg_fallback { test $# -eq 0 && nvim -c "call OpenOldestFileFromCwd()" || nvim $*; }
alias v='vim_with_no_arg_fallback'
alias vi='vim_with_no_arg_fallback'
alias vim='vim_with_no_arg_fallback'

function remove_breakpoints {
  git status -su | cut -c 4- | xargs sed -i '' '/binding\.pry/d'
  git status -su | cut -c 4- | xargs sed -i '' '/puts_debuggerer/d'
}

alias tmoff='tm -o'
alias tmstat='tm -s'
alias tmedit='tm -e'
