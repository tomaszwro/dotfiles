call plug#begin()
Plug '/usr/local/opt/fzf'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'vim-ruby/vim-ruby'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'michaeljsmith/vim-indent-object'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'bkad/camelcasemotion'
Plug 'svermeulen/vim-easyclip'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'slim-template/vim-slim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------

let $BASH_ENV = "$HOME/.bash_aliases"
let mapleader = " "

set background=dark
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nowrap
set ignorecase              " Case insensitive searching
set smartcase               " But become case sensitive if you type uppercase characters
set hls
set autowriteall
set splitbelow
set splitright
set confirm
set nofixendofline
set noshowmode              " Don't show -- INSERT -- because it's already there in upper status line
set clipboard=unnamed       " To use system clipboard
set updatetime=100          " To make gitgutter refresh quicker
set signcolumn=yes          " Always show sign column
set lazyredraw
set iskeyword+=-
set hidden                  " To allow terminal buffers update in bg
set foldenable              " Enable folding
set foldlevelstart=10       " Open most folds by default
set foldnestmax=10          " 10 nested fold max
set foldmethod=indent       " Fold based on indent level
set mouse=a                 " Enable vim mouse scrolling while in tmux

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------

let g:ruby_indent_block_style = 'do'
let g:ruby_indent_assignment_style = 'variable'

let g:lightline = {
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'readonly', 'relativepath', 'modified' ]
  \   ],
  \   'right': [
  \     [ 'lineinfo' ],
  \     [ 'percent' ],
  \     []
  \   ]
  \ },
  \ }

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------

let g:gitgutter_override_sign_column_highlight = 0
colorscheme solarized

hi Search ctermfg=NONE ctermbg=NONE cterm=underline
hi IncSearch ctermfg=NONE ctermbg=NONE cterm=underline
hi MatchParen ctermbg=NONE ctermfg=green cterm=NONE
hi VertSplit ctermbg=0 ctermfg=0
hi SignColumn ctermbg=bg

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------

command! -nargs=+ GrepRaw cex system('ag --column <args>')
command! -nargs=+ G GrepRaw <args>

" vimscript escapes ' => '' and | to \|
" bash escapes ' => '\'' and then vim escaped
command! Ghunks
  \  cex system('git diff \| perl -e ''
  \    use strict;
  \    use warnings;
  \    my $filename;
  \    my $line;
  \    my $offset = 0;
  \    my $printed = 0;
  \    while (<STDIN>) {
  \      if (m(^\+\+\+ b/(.*)$)) {
  \        $printed = 0;
  \        $filename = $1;
  \      } elsif (m(^@@ -\d+(?:,\d+)? \+(\d+))) {
  \        $line = $1;
  \        $offset = 0;
  \        $printed = 0;
  \      } elsif (m(^\+(.*)$)) {
  \        my $data = $1 \|\| ''\''''-''\'''';
  \        print "$filename:" . ($offset + $line) . ":$data\n" unless $printed;
  \        $offset++;
  \        $printed = 1;
  \      } elsif (m(^ )) {
  \        $printed = 0;
  \        $offset++;
  \      }
  \    }
  \  ''')

command! FilesModified
  \  new
  \| setlocal buftype=nofile
  \| setlocal bufhidden=hide
  \| setlocal noswapfile
  \| execute '0read ! git status -su'
  \| execute 'normal G"_ddgg'
  \| execute 'nnoremap <silent> <buffer> <CR> $gf:only<CR>'
  \| execute 'nnoremap <silent> <buffer>    o $gf:only<CR>'

command! MethodOverview
  \  enew
  \| setlocal buftype=nofile
  \| setlocal bufhidden=hide
  \| setlocal noswapfile
  \| setfiletype ruby
  \| execute '0read ! grep "def\|class\|module\|private\|protected\|attr_\|describe \|it \|specify " ' . expand('#')
  \| normal Gddgg

function! PutInspectStatementForCurrentWordIntoClipboard()
  let @+ = 'puts "----- DEBUGGERER ' . expand('<cword>') . ' #{ ' . expand('<cword>') . '.inspect }"' ."\n"
endfunction

function! PutLocationStatementForCurrentWordIntoClipboard()
  let @+ = 'puts "----- DEBUGGERER in ' . expand('<cword>') . '"' . "\n"
endfunction

function! BrowseOldFilesFromCwd()
  let current_dir = getcwd() . '/'
  new
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  for file in v:oldfiles
    if match(file, current_dir) == 0 && !(file =~ '\.git/COMMIT_EDITMSG$')
      put =strpart(file, strlen(getcwd()) + 1)
    endif
  endfor
  normal ggdd
  setlocal nomodifiable
  nnoremap <buffer> <CR> gf:only<CR>
  nnoremap <buffer>    o gf:only<CR>
endfunction

function! OpenOldestFileFromCwd()
  let current_dir = getcwd() . '/'
  for file in v:oldfiles
    if match(file, current_dir) == 0 && !(file =~ '\.git/COMMIT_EDITMSG$')
      execute "edit " . file
      break
    endif
  endfor
endfunction

command! OpenNotes
  \  cd ~/snapnote
  \| call OpenOldestFileFromCwd()

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------

function! TermTest(test_command)
  " call TermTestBuffer(a:test_command)
  call TermTestWindow(a:test_command)
endfunction

function! TermTestBuffer(test_command)
  silent update
  execute "terminal " . a:test_command
  let g:TermTest_last_test = a:test_command
  let g:TermTest_last_buffer = bufnr('%')
  silent b#
  echo "Running " . a:test_command
endfunction

function! TermTestWindow(test_command)
  silent update
  if winnr('$') == 1
    13sp
  else
    wincmd w
  endif
  execute "terminal " . a:test_command
  execute "normal G"
  let g:TermTest_last_test = a:test_command
  let g:TermTest_last_buffer = bufnr('%')
  wincmd p
endfunction

command! TermTestAll         call TermTest("echo Running... && bin/rails t")
command! TermTestAllFailFast call TermTest("echo Please implement me")
command! TermTestFile        call TermTest("echo Running... && bin/rails t " . @%)
command! TermTestSingle      call TermTest("echo Running... && bin/rails t " . @% . ":" . line('.'))

command! TermTestRetry       call TermTest(g:TermTest_last_test)
command! TermTestView        exec 'buf ' . g:TermTest_last_buffer

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------

augroup my_vimrc

  autocmd!

  " This sets up an auto command that fires after any filetype-specific plugin;
  " the command removes the three flags from the 'formatoptions' option that
  " control the automatic insertion of comments. With this in your vimrc, a
  " comment character will not be automatically inserted in the next line under
  " any situation.
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  " From :h last-position-jump
  " This autocommand jumps to the last known position in a file
  " just after opening it, if the '" mark is set: >
  autocmd BufReadPost *
    \   if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' 
    \ |   exe "normal! g`\""
    \ | endif

  " From: https://github.com/junegunn/fzf/blob/master/README-VIM.md#hide-statusline
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

augroup end

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------

" Stolen from (slightly modified):
" https://github.com/thoughtbot/dotfiles/blob/21055dff633feea87bc9526efb5b2fcc04bc025e/vimrc#L101

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-p>

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------

function! GoToDefinition()
  if search('\<def ' . expand("<cword>") . '\>', 's') == 0
    execute 'GrepRaw -w "(def \|class \|module )' . expand("<cword>") . '"'
    if len(getqflist()) > 1
      copen
      wincmd w
    endif
  else
    normal zz
  endif
endfunction

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------

nnoremap <silent> § :call search('\<')<CR>
nnoremap <silent> £ :call search('\<', 'b')<CR>

command! MapNextToQuickFix
  \  nnoremap n :cn<CR>zz
  \| nnoremap N :cp<CR>zz
  \| normal zz

command! MapNextToDefault
  \  nnoremap n n
  \| nnoremap N N

command! MapNextToGitGutterHunk
  \  nnoremap n :GitGutterNextHunk<CR>zz
  \| nnoremap N :GitGutterPrevHunk<CR>zz

augroup my_vimrc_map_next_to_quick_fix
  autocmd!
  autocmd QuickFixCmdPost * MapNextToQuickFix
augroup end

nnoremap /  :MapNextToDefault<CR>/
nnoremap ?  :MapNextToDefault<CR>?
nnoremap *  :MapNextToDefault<CR>*
nnoremap #  :MapNextToDefault<CR>#
nnoremap g* :MapNextToDefault<CR>g*
nnoremap g# :MapNextToDefault<CR>g#

nmap     M <Plug>MoveMotionEndOfLinePlug
nnoremap <silent> K i<CR><ESC>k:s/\s\+$//e<CR>:nohl<CR>j

nnoremap <C-d> 15j
nnoremap <C-u> 15k

cnoremap <expr> %% expand('%:h').'/'

nnoremap <silent> <Esc> <Esc>:nohl<CR>

" From: http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" From: http://vim.wikia.com/wiki/Insert_a_single_character
nnoremap <silent> \ :exec "normal i".nr2char(getchar())."\e"<CR>

map <silent> gw <Plug>CamelCaseMotion_w
map <silent> gb <Plug>CamelCaseMotion_b
map <silent> ge <Plug>CamelCaseMotion_e
map <silent> ; <Plug>CamelCaseMotion_w
map <silent> , <Plug>CamelCaseMotion_b

nmap              s  <NOP>
nnoremap          so o<esc>
nnoremap          sO O<esc>
nnoremap <silent> ss :silent up<CR>
nnoremap          sa ^
nnoremap          se $
vnoremap          sa ^
vnoremap          se $h
" Allow recursive to trigger MapNextToDefault
nmap              su *N
vmap              su "zy/<C-R>z<CR>N

tnoremap <C-b> <C-\><C-n>

nmap     <Leader>  <NOP>
nnoremap <Leader>q <C-w>q
nnoremap <Leader>w <C-w>w
nnoremap <Leader>e <C-w>o
nnoremap <Leader>d :call GoToDefinition()<CR>
nnoremap <Leader>a <C-^>
nnoremap <Leader>r q:?
nnoremap <Leader>z :qa<CR>

nmap     <Leader>g  <NOP>
nnoremap <Leader>gu :GrepRaw -w <c-r><c-w><CR>
nnoremap <Leader>gi :GrepRaw -w "\.<c-r><c-w>"<CR>
nnoremap <Leader>gr :GrepRaw -w "<c-r><c-w>\."<CR>
nnoremap <Leader>gh :Ghunks<CR>
nnoremap <Leader>gd :Gcd .<CR>:terminal git_diff_raw_all<CR>:cd -<CR>
nnoremap <Leader>gs :exec '!subl -w ' . expand('%') . ':' . line('.') . ':' . col('.')<CR><CR>
nnoremap <Leader>gb :GrepRaw "binding.pry"<CR>
nnoremap <Leader>gp :GrepRaw "DEBUGGERER"<CR>
vnoremap <Leader>gu "zy:GrepRaw "<C-R>z"<CR>

nmap     <Leader>f  <NOP>
nnoremap <Leader>fa <C-^>
nnoremap <Leader>fs :FilesModified<CR>
nnoremap <Leader>ff :FZF<CR>
nnoremap <Leader>fo :call BrowseOldFilesFromCwd()<CR>

nmap     <Leader>i :call PutInspectStatementForCurrentWordIntoClipboard()<CR>
nmap     <Leader>l :call PutLocationStatementForCurrentWordIntoClipboard()<CR>

nmap     <Leader>n <NOP>
nnoremap <Leader>ne :sp todos<CR>
nnoremap <Leader>nf :e todos<CR>
nnoremap <Leader>ni :e ~/snapnote/inbox<CR>
nnoremap <Leader>na :e ~/snapnote/inbox<CR>Go<Esc>o
nnoremap <Leader>on :OpenNotes<CR>

nmap     <Leader>t  <NOP>
nnoremap <Leader>ta :TermTestAll<CR>
nnoremap <Leader>ts :TermTestAllFailFast<CR>
nnoremap <Leader>tf :TermTestFile<CR>
nnoremap <Leader>tt :TermTestSingle<CR>
nnoremap <Leader>tr :TermTestRetry<CR>
nnoremap <Leader>tv :TermTestView<CR>

nmap     <Leader>h  <NOP>
nmap     <Leader>hn <Plug>GitGutterNextHunk
nmap     <Leader>hN <Plug>GitGutterPrevHunk
nnoremap <Leader>hf gg:GitGutterNextHunk<CR>zz:MapNextToGitGutterHunk<CR>
nnoremap <Leader>hg :Ghunks<CR>

nmap     <Leader>s  <NOP>
nmap     <Leader>sh <Plug>GitGutterStageHunk
nmap     <Leader>sf :Gwrite<CR>
nnoremap <Leader>sw :set wrap!<CR>

nmap     <Leader>c  <NOP>
nnoremap <Leader>cf :Gwrite\|Gcommit -v<CR>
nnoremap <Leader>ca :Gcd .<CR>:silent ! git add .<CR>:cd -<CR>:Gcommit -v<CR>
nnoremap <Leader>ch :GitGutterStageHunk<CR>:Gcommit -v<CR>
nnoremap <Leader>cc :Gcommit -v<CR>

nnoremap ff :FZF<CR>

augroup MyTermMappings
  autocmd!
  autocmd TermOpen * nnoremap <buffer> o    gF:only<CR>
  autocmd TermOpen * nnoremap <buffer> <CR> gF:only<CR>
  autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END

nmap fmn ]m
nmap fme ]M
nmap fmb [m
nmap fmp [M
nmap fmf gg]m
vmap fmn ]m
vmap fme ]M
vmap fmb [m
vmap fmp [M
vmap fmf gg]m

nmap fcn ]]
nmap fce ][
nmap fcb [[
nmap fcp []
nmap fcf gg]]
vmap fcn ]]
vmap fce ][
vmap fcb [[
vmap fcp []
vmap fcf gg]]

nmap vai vaI
nmap vis jvii
nmap vas jvai
