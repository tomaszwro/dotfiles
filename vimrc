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
Plug 'editorconfig/editorconfig-vim'
call plug#end()

" camelcasemotion
" e2816c75c3b73f176af3e94576793b342976f0a1
" ctrlp.vim
" 35c9b961c916e4370f97cb74a0ba57435a3dbc25
" dracula
" 0f4ebc51a7b620f07ff51d2d75d536d975b52f55
" fzf.vim
" f0acabf7e837e626c7102c30af890bccf79e33b7
" gruvbox
" cb4e7a5643f7d2dd40e694bcbd28c4b89b185e86
" lightline.vim
" 78c43c144643e49c529a93b9eaa4eda12614f923
" nerdtree
" ed446e5cbe0733a8f98befc88d33e42edebb67d2
" setcolors.vim
" eef7a46d8313c22ba265cdbdfa1892060a33d758
" splitjoin.vim
" 13cf529dbd719365e9ec0dfa96dc1db50b957c85
" taboo.vim
" 1367baf547ff931b63ea6a389e551f4ed280eadf
" vim-airline
" 958f78335eafe419ee002ad58d358854323de33a
" vim-colors-solarized
" 528a59f26d12278698bb946f8fb82a63711eec21
" vim-colorschemes
" eab315701f4627967fd62582eefc4e37a3745786
" vim-commentary
" 89f43af18692d22ed999c3097e449f12fdd8b299
" vim-dispatch
" 4104901e9d6a304a5022b780f8e20d3becc7da93
" vim-easyclip
" 00aae5cc683397ef4c1abd3e6499bdc1a408e17e
" vim-endwise
" d5655263af8b3611a2bcb907a9963831a88d154b
" vim-eunuch
" 10da325fb032a1acfa9222d273459f53bad30ba4
" vim-fugitive
" b82abd5bd583cfb90be63ae12adc36a84577bd45
" vim-gitgutter
" 538e07882a985590027313d23dedfea7e1d19807
" vim-indent-object
" 41d700f14b3decccdde421fbfe49e95a084a2f89
" vim-javascript
" 7cc6baebaf0065fd8c31cc9216c87bfa543eb71a
" vim-jsx-pretty
" 994503b30c929353c107eb9166accd68d35b83b5
" vim-min-git-status
" 2d5fa55a9d2ef790f1e6f241ca656a272b8d5e5d
" vim-multiple-cursors
" c9b95e49a48937903c9fc41d87d9b4c9aded10d7
" vim-repeat
" 8106e142dfdc278ff3eaaadd7b362ad7949d4357
" vim-rhubarb
" 6caad2b61afcc1b7c476b0ae3dea9ee5f2b1d14a
" vim-rsi
" c19aeb88592555d277af56d453ea8b43dc8266de
" vim-ruby
" 15e32500f58c3bb66eb6b1eb4af57d86263895c0
" vim-sensible
" 2d60332fa5b2b1ea346864245569df426052865a
" vim-slim
" 6673e404370e6f3d44be342cf03ea8c26ab02c66
" vim-smooth-scroll
" 0eae2367c70c3415b97869346af1b5e30c123dff
" vim-surround
" e49d6c2459e0f5569ff2d533b4df995dd7f98313
" vim-test
" 062c489781c995f7e81103fec8a3c07bd2ff1f4b
" vim-textobj-entire
" 64a856c9dff3425ed8a863b9ec0a21dbaee6fb3a
" vim-textobj-indent
" deb76867c302f933c8f21753806cbf2d8461b548
" vim-textobj-quotes
" cca9686acf7b21d930ced1801120ecf23fb2f995
" vim-textobj-user
" e231b65797b5765b3ee862d71077e9bd56f3ca3e
" vim-unimpaired
" c77939c4aff30b2ed68deb1752400ec15f17c3a2
" vim-vinegar
" c38ea2195a43747aedf0bb4b7eb5aa8870260296

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

command! -nargs=+ GrepRaw cex system('ag --column --hidden --ignore .git --ignore \*.rbi <args>')
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

" command! FilesModified call fzf#run(fzf#wrap({'source': 'git status -su | cut -c 4-'}))
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
  \| execute '0read ! grep "def\|class\|module\|private\|protected\|attr_\|describe \|it \|specify \|context" ' . expand('#')
  \| normal Gddgg

function! PutInspectStatementForCurrentWordIntoClipboard()
  let @+ = 'puts "----- DEBUGGERER ' . expand('<cword>') . ' #{ ' . expand('<cword>') . '.inspect }"' ."\n"
endfunction

function! SaveCurrentLocationInTodos()
  let @+ = expand("%") . ':' . line('.') . "\n"
  sp todos
  normal ggP
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
    20sp
    " vs
  else
    wincmd w
  endif
  execute "terminal " . a:test_command
  execute "normal G"
  let g:TermTest_last_test = a:test_command
  let g:TermTest_last_buffer = bufnr('%')
  wincmd p
endfunction

command! TermTestAll         call TermTest("echo Running... && be rspec && say green || say red")
command! TermTestAllFailFast call TermTest("echo Please implement me")
" echo Running... && 
command! TermTestFile        call TermTest("bundle exec rspec " . @% . " && say green || say red")
command! TermTestSingle      call TermTest("bundle exec rspec " . @% . ":" . line('.') . " && say green || say red")

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
nnoremap <Leader>ff :FZF<CR>
nnoremap <Leader>fo :call BrowseOldFilesFromCwd()<CR>

nmap     <Leader>i :call PutInspectStatementForCurrentWordIntoClipboard()<CR>
nmap     <Leader>l oputs "----- DEBUGGERER ppp in #{ self.class } #{ __method__ }"<ESC>
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
nmap     <Leader>sh <Plug>(GitGutterStageHunk)
nmap     <Leader>sf :Gwrite<CR>
nnoremap <Leader>sl :call SaveCurrentLocationInTodos()<CR>
nnoremap <Leader>sw :set wrap!<CR>
nnoremap <Leader>sn :set number!<CR>

nmap     <Leader>c  <NOP>
nnoremap <Leader>cf :Gwrite\|Gcommit -v<CR>
nnoremap <Leader>ca :Gcd .<CR>:silent ! git add .<CR>:cd -<CR>:Gcommit -v<CR>
nnoremap <Leader>ch :GitGutterStageHunk<CR>:Gcommit -v<CR>
nnoremap <Leader>cc :Gcommit -v<CR>

nnoremap ff :FZF<CR>
nnoremap fs :FilesModified<CR>

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
" nmap vas jvaioj

nnoremap tm I☐ <Esc>
nnoremap tn o☐ 
nnoremap to o☐ 
nnoremap td ^r☑
nnoremap tt ^r☑
nnoremap tu ^r☐
nnoremap tr ^r☒

