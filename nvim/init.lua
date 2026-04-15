local note_dir = "/Users/tomaszwrobel/snapnote/current"
local work_file_path = "/Users/tomaszwrobel/snapnote/current/A_tr_aaa_auth_zero.md"
local priv_file_path = "/Users/tomaszwrobel/snapnote/current/y26_my_monthly_plate_one_pager.md"

local function current_path_with_pos()
  return vim.fn.expand('%') .. ':' .. vim.fn.line('.') .. ':' .. vim.fn.col('.')
end

vim.cmd([[
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
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
  call plug#end()
]])

vim.cmd([[
  let $BASH_ENV = "$HOME/.zsh_aliases"
  let mapleader = " "
]])

vim.cmd([[
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
]])

vim.cmd([[
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


]])

vim.cmd([[
  let g:gitgutter_override_sign_column_highlight = 0
  "colorscheme vim
  colorscheme solarized
  set notermguicolors

  hi Search ctermfg=NONE ctermbg=NONE cterm=underline
  hi IncSearch ctermfg=NONE ctermbg=NONE cterm=underline
  hi MatchParen ctermbg=NONE ctermfg=green cterm=NONE
  hi VertSplit ctermbg=0 ctermfg=0
  hi SignColumn ctermbg=bg
]])

vim.cmd([[
  command! -nargs=+ GrepRaw cex system('ag --column --hidden --ignore .git --ignore \*.rbi --ignore \*.log <args>')
  command! -nargs=+ GrepRuby cex system('ag --column --ruby <args>')
  command! -nargs=+ GrepRubyApp cex system('ag --column --ruby --ignore \*_spec.rb <args>')
  command! -nargs=+ G GrepRaw <args>
]])

vim.cmd([[

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

  command! FilesModifiedInBranch
    \  enew
    \| setlocal buftype=nofile
    \| setlocal bufhidden=hide
    \| setlocal noswapfile
    \| execute '0read ! g_current_branch_status'
    \| execute 'normal G"_ddgg'
    \| execute 'nnoremap <silent> <buffer> <CR> gf<CR>'
    \| execute 'nnoremap <silent> <buffer>    o gf<CR>'
]])

vim.cmd([[
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
]])

-- " better idea: instead of notes, rely on kind of clipboard stack, or perhaps that builtin thing for marked locations
-- function! SaveCurrentLocationInTodos()
--   let @+ = expand("%") . ':' . line('.') . "\n"
--   call OpenMostRecentFileFromScratchpads()
--   normal Gp
-- endfunction
-- nnoremap <leader>sl :call SaveCurrentLocationInTodos()<CR>

vim.cmd([[
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
]])

vim.cmd([[
  function! OpenOldestFileFromCwd()
    let current_dir = getcwd() . '/'
    " TODO: use note_dir once converted to lua
    let scratchpads_dir = '/Users/tomaszwrobel/snapnote/current'
    for file in v:oldfiles
      " if (match(file, current_dir) == 0 || match(file, scratchpads_dir) == 0) && !(file =~ '\.git/COMMIT_EDITMSG$') && !(file =~ '\.git/rebase-merge/git-rebase-todo$')
      if (match(file, current_dir) == 0) && !(file =~ '\.git/COMMIT_EDITMSG$') && !(file =~ '\.git/rebase-merge/git-rebase-todo$')
        execute "edit " . file
        break
      endif
    endfor
  endfunction
]])

vim.cmd([[
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
    else
      wincmd w
    endif
    execute "terminal " . a:test_command
    execute "normal G"
    let g:TermTest_last_test = a:test_command
    let g:TermTest_last_buffer = bufnr('%')
    wincmd p
  endfunction

  command! TermTestAll         call TermTest("echo Running... && be rspec && say -v Zosia działa || say -v Zosia nie działa")
  command! TermTestFile        call TermTest("echo Running... && be rspec -fd " . @% . " && say -v Zosia działa || say -v Zosia nie działa")
  "command! TermTestFile        call TermTest("echo Running... && npm test " . @% . " && say -v Zosia działa || say -v Zosia nie działa")
  command! TermTestSingle      call TermTest("echo Running... && be rspec -fd " . @% . ":" . line('.') . " && say -v Zosia działa || say -v Zosia nie działa")
  command! TermTestRetry       call TermTest(g:TermTest_last_test)
  command! TermTestView        exec 'buf ' . g:TermTest_last_buffer
]])

vim.cmd([[
  function! GoToDefinition()
    if search('\<def ' . expand("<cword>") . '\>', 's') == 0
      " that's why it was broken such a long time
      "execute 'GrepRaw -w "(def \|class \|module )' . expand("<cword>") . '"'
      execute 'GrepRuby -w "(def |class |module )' . expand("<cword>") . '"'
      " or do it sequentially? first def, then class, then module? esp with further tweaks
      if len(getqflist()) > 1
        copen
        wincmd w
      endif
    else
      normal zz
    endif
  endfunction
]])

vim.cmd([[
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
  augroup end

  augroup MyTermMappings
    autocmd!
    autocmd TermOpen * nnoremap <buffer> o    gF:only<CR>
    autocmd TermOpen * nnoremap <buffer> <CR> gF:only<CR>
    autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
  augroup END

  autocmd FileType markdown setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 linebreak
  "breakindent showbreak textwidth=120 -- what these should do?
  autocmd FileType markdown setlocal foldmethod=expr foldexpr=MarkdownFold()
  "autocmd FileType markdown setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
]])

vim.cmd([[
  command! MapNextToQuickFix
    \  nnoremap n :cn<CR>zz
    \| nnoremap N :cp<CR>zz
    \| normal zz

  command! MapNextToDefault
    \  nnoremap n n
    \| nnoremap N N

  command! DoubleQuotize :%s/\'/\"/g

  augroup my_vimrc_map_next_to_quick_fix
    autocmd!
    autocmd QuickFixCmdPost * MapNextToQuickFix
  augroup end

]])

vim.keymap.set("n", "/",  ":MapNextToDefault<CR>/")
vim.keymap.set("n", "?",  ":MapNextToDefault<CR>?")
vim.keymap.set("n", "*",  ":MapNextToDefault<CR>*")
vim.keymap.set("n", "#",  ":MapNextToDefault<CR>#")
vim.keymap.set("n", "g*", ":MapNextToDefault<CR>g*")
vim.keymap.set("n", "g#", ":MapNextToDefault<CR>g#")
vim.keymap.set("n", "M", "<Plug>MoveMotionEndOfLinePlug", { remap = true })
vim.keymap.set("n", "K", "i<CR><ESC>k:s/\\s\\+$//e<CR>:nohl<CR>j", { silent = true })
vim.keymap.set("c", "%%", function() return vim.fn.expand('%:h') .. '/' end, { expr = true })
vim.keymap.set("c", "%!", function() return vim.fn.expand('%') end, { expr = true })
vim.keymap.set("n", "<Esc>", "<Esc>:nohl<CR>", { silent = true })
vim.keymap.set("n", "gp", function() return '`[' .. vim.fn.strpart(vim.fn.getregtype(), 0, 1) .. '`]' end, { expr = true })
vim.keymap.set("", "gw", "<Plug>CamelCaseMotion_w", { silent = true, remap = true })
vim.keymap.set("", "gb", "<Plug>CamelCaseMotion_b", { silent = true, remap = true })
vim.keymap.set("", "ge", "<Plug>CamelCaseMotion_e", { silent = true, remap = true })
vim.keymap.set("", ";",  "<Plug>CamelCaseMotion_w", { silent = true, remap = true })
vim.keymap.set("", ",",  "<Plug>CamelCaseMotion_b", { silent = true, remap = true })
vim.keymap.set("t", "<C-b>", "<C-\\><C-n>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "vai", "vaI", { remap = true })
vim.keymap.set("n", "vis", "jvii", { remap = true })
vim.keymap.set("n", "vas", "jvai", { remap = true })

vim.keymap.set("n", "s",  "<NOP>")
vim.keymap.set("n", "so", "o<Esc>")
vim.keymap.set("n", "sO", "O<Esc>")
vim.keymap.set("n", "ss", ":silent up<CR>", { silent = true })
vim.keymap.set("n", "sa", "^")
vim.keymap.set("n", "se", "$")
vim.keymap.set("v", "sa", "^")
vim.keymap.set("v", "se", "$h")
vim.keymap.set("n", "su", "*N", { remap = true }) -- Allow recursive to trigger MapNextToDefault
vim.keymap.set("v", "su", '"zy/<C-R>z<CR>N', { remap = true })
vim.keymap.set("n", "sq", "ysiw`", { remap = true })

vim.keymap.set("n", "tm", "^c2l- ☑️ <Esc>")
vim.keymap.set("n", "to", "o- ☑️ ")
vim.keymap.set("n", "td", "^llr✅")
vim.keymap.set("n", "tu", "^llr☑️")
vim.keymap.set("n", "tr", "^llr✖️")
vim.keymap.set("n", "tp", "^lla❗<Esc>")
vim.keymap.set("n", "ti", "A❗<Esc>")
vim.keymap.set("n", "tq", "A❔<Esc>")
vim.keymap.set("n", "tl", "A⚡️<Esc>")

vim.keymap.set("n", "ff", ":FZF<CR>")
vim.keymap.set("n", "fs", ":FilesModified<CR>")
vim.keymap.set("n", "fW", function() vim.cmd.edit(vim.fn.fnameescape(work_file_path)) end)
vim.keymap.set("n", "fp", function() vim.cmd.split(vim.fn.fnameescape(priv_file_path)) end)
vim.keymap.set("n", "fP", function() vim.cmd.edit(vim.fn.fnameescape(priv_file_path)) end)
vim.keymap.set("n", "fd", function() vim.cmd('bd') end)

vim.keymap.set("n", "<leader>",  "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>q", "<C-w>q")
vim.keymap.set("n", "<leader>w", "<C-w>w")
vim.keymap.set("n", "<leader>e", "<C-w>o")
vim.keymap.set("n", "<leader>r", "q:?")
vim.keymap.set("n", "<leader>t", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>y", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>u", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>i", function() vim.fn.PutInspectStatementForCurrentWordIntoClipboard() end)
vim.keymap.set("n", "<leader>o", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>p", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>a", "<C-^>")
vim.keymap.set("n", "<leader>s", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>d", function() vim.fn.GoToDefinition() end)
vim.keymap.set("n", "<leader>f", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>g", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>h", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>j", "<NOP>")
vim.keymap.set("n", "<leader>k", "<NOP>")
vim.keymap.set("n", "<leader>l", 'oputs "----- DEBUGGERER -- #{ self.class } -- #{ __method__ } 1"<ESC>h', { remap = true })
vim.keymap.set("n", "<leader>z", ":qa<CR>")
vim.keymap.set("n", "<leader>x", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>c", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>v", "<NOP>")
vim.keymap.set("n", "<leader>b", "<NOP>")
vim.keymap.set("n", "<leader>n", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>ne", function() vim.cmd.split(vim.fn.fnameescape(work_file_path)) end)
vim.keymap.set("n", "<leader>nf", function() vim.cmd.edit(vim.fn.fnameescape(work_file_path)) end)
vim.keymap.set("n", "<leader>m", "<NOP>", { remap = true })
vim.keymap.set("n", "<leader>gu", ":GrepRubyApp -w <C-r><C-w><CR>:cw<CR>")
vim.keymap.set("n", "<leader>gd", ":Gcd .<CR>:terminal git_diff_raw_all<CR>:cd -<CR>")
vim.keymap.set("n", "<leader>gs", function() vim.cmd('silent !' .. 'subl -w ' .. current_path_with_pos()) end)
vim.keymap.set("n", "<leader>gv", function() vim.cmd('silent !' .. 'code -g ' .. current_path_with_pos()) end)
vim.keymap.set("v", "<leader>gu", '"zy:GrepRaw "<C-R>z"<CR>')
vim.keymap.set("n", "<leader>fo", function() vim.fn.BrowseOldFilesFromCwd() end)
vim.keymap.set("n", "<leader>mq", ":MapNextToQuickFix<CR>")
vim.keymap.set("n", "<leader>ta", ":TermTestAll<CR>")
vim.keymap.set("n", "<leader>tf", ":TermTestFile<CR>")
vim.keymap.set("n", "<leader>tt", ":TermTestSingle<CR>")
vim.keymap.set("n", "<leader>tr", ":TermTestRetry<CR>")
vim.keymap.set("n", "<leader>tv", ":TermTestView<CR>")
vim.keymap.set("n", "<leader>sh", "<Plug>(GitGutterStageHunk)", { remap = true })
vim.keymap.set("n", "<leader>sf", ":Gwrite<CR>")
vim.keymap.set("n", "<leader>sw", ":set wrap!<CR>")
vim.keymap.set("n", "<leader>cf", ":Gwrite | Git commit -v<CR>")
vim.keymap.set("n", "<leader>ca", ":Gcd .<CR>:silent ! git add .<CR>:cd -<CR>:Git commit -v<CR>")
vim.keymap.set("n", "<leader>ch", ":GitGutterStageHunk<CR>:Git commit -v<CR>")
vim.keymap.set("n", "<leader>cc", ":Git commit -v<CR>")
vim.keymap.set("n", "<leader>cp", function() vim.fn.CopyFilePath() end)
vim.keymap.set("n", "<leader>cl", function() vim.fn.CopyFilePathWithLine() end)
vim.keymap.set("n", "<leader>xx", ":sp | term<CR>a")
vim.keymap.set("n", "<leader>vc", ":Augment chat ")
vim.keymap.set("n", "<leader>vd", function() vim.g.augment_disable_completions = true end)
vim.keymap.set("n", "<leader>ve", function() vim.g.augment_disable_completions = false end)
vim.keymap.set("n", "<leader>vi", function() vim.fn.InsertTimestamp() end)
vim.keymap.set("n", "<leader>vr", function() vim.fn.RunShellCommandInCurrentLine() end)
vim.keymap.set("n", "<leader><leader>", "gF")

vim.g.augment_disable_completions = true
vim.g.augment_workspace_folders = {
  "/Users/tomaszwrobel/work/taskrabbit/v3",
}

