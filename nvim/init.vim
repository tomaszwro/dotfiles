set rtp+=/opt/homebrew/opt/fzf

call plug#begin()
Plug 'augmentcode/augment.vim'
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

lua require("init")
