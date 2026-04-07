set rtp+=/opt/homebrew/opt/fzf

call plug#begin()
" Plug 'augmentcode/augment.vim'
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
call plug#end()

let $BASH_ENV = "$HOME/.zsh_aliases"
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
set nomodeline

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
"colorscheme vim
colorscheme solarized
set notermguicolors

hi Search ctermfg=NONE ctermbg=NONE cterm=underline
hi IncSearch ctermfg=NONE ctermbg=NONE cterm=underline
hi MatchParen ctermbg=NONE ctermfg=green cterm=NONE
hi VertSplit ctermbg=0 ctermfg=0
hi SignColumn ctermbg=bg

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------

command! -nargs=+ GrepRaw cex system('ag --column --hidden --ignore .git --ignore \*.rbi <args>')
command! -nargs=+ GrepRuby cex system('ag --column --ruby <args>')
command! -nargs=+ G GrepRaw <args>

" command! FilesModified call fzf#run(fzf#wrap({'source': 'git status -su | cut -c 4-'}))
" git status -su | awk '{print $2 " " $1}' | sort
command! FilesModified
  \  enew
  \| setlocal buftype=nofile
  \| setlocal bufhidden=hide
  \| setlocal noswapfile
  \| execute '0read ! gss'
  \| execute 'normal G"_ddgg'
  \| execute 'nnoremap <silent> <buffer> <CR> gf<CR>'
  \| execute 'nnoremap <silent> <buffer>    o gf<CR>'

function! PutInspectStatementForCurrentWordIntoClipboard()
  let @+ = 'puts "----- DEBUGGERER ' . expand('<cword>') . ' #{ ' . expand('<cword>') . '.class } #{ ' . expand('<cword>') . '.pretty_inspect }"' ."\n"
endfunction

function! LastNChars(str, n)
  return "..." . strpart(a:str, max([0, strlen(a:str) - a:n]))
endfunction

function! CopyFilePathAbsolute()
  let @+ = expand('%:p')
  echo "Copied: " . LastNChars(@+, 120)
endfunction

function! CopyFilePath()
  let @+ = expand('%:.')
  echo "Copied: " . LastNChars(@+, 120)
endfunction

function! CopyFilePathWithLine()
  let @+ = expand("%:.") . ':' . line('.')
  echo "Copied: " . LastNChars(@+, 120)
endfunction

function! CopyFilePathWithLineAndColumn()
  let @+ = expand("%:.") . ':' . line('.') . ':' . col('.')
  echo "Copied: " . LastNChars(@+, 120)
endfunction

function! RunShellCommandInCurrentLine()
  " execute 'silent !' . getline('.')
  execute '!' . getline('.')
endfunction

" TODO: can be faster with non-shell thing?
function! InsertTimestamp()
  execute 'r ! date "+\%-m/\%-d \%H:\%M"'
  normal I### 
  normal A ###
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
  let scratchpads_dir = '/Users/tomaszwrobel/snapnote/current'
  for file in v:oldfiles
    if (match(file, current_dir) == 0 || match(file, scratchpads_dir) == 0) && !(file =~ '\.git/COMMIT_EDITMSG$') && !(file =~ '\.git/rebase-merge/git-rebase-todo$')
      execute "edit " . file
      break
    endif
  endfor
endfunction

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------


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

"-------------------------------------------------
"-------------------------------------------------
"-------------------------------------------------


lua require("init")
