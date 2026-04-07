vim.g.augment_disable_completions = true
vim.g.augment_workspace_folders = {
  "/Users/tomaszwrobel/work/taskrabbit/v3",
}

local note_dir = "/Users/tomaszwrobel/snapnote/current"

local function lru_note_path()
  for _, file in ipairs(vim.v.oldfiles) do
    if file:match("^" .. vim.pesc(note_dir)) then
      return file
    end
  end
  return nil
end

vim.keymap.set("n", "tm", "^c2l- ☑️ <Esc>")
vim.keymap.set("n", "to", "o- ☑️ ")
vim.keymap.set("n", "td", "^llr✅")
vim.keymap.set("n", "tu", "^llr☑️")
vim.keymap.set("n", "tr", "^llr✖️")
vim.keymap.set("n", "tp", "^lla❗<Esc>")
vim.keymap.set("n", "ti", "A❗<Esc>")
vim.keymap.set("n", "tq", "A❔<Esc>")
vim.keymap.set("n", "tl", "A⚡️<Esc>")
vim.keymap.set("n", "<leader>ne", function() vim.cmd.split(vim.fn.fnameescape(lru_note_path())) end)
vim.keymap.set("n", "<leader>nf", function() vim.cmd.edit(vim.fn.fnameescape(lru_note_path())) end)

-- " better idea: instead of notes, rely on kind of clipboard stack, or perhaps that builtin thing for marked locations
-- function! SaveCurrentLocationInTodos()
--   let @+ = expand("%") . ':' . line('.') . "\n"
--   call OpenMostRecentFileFromScratchpads()
--   normal Gp
-- endfunction
-- nnoremap <Leader>sl :call SaveCurrentLocationInTodos()<CR>

vim.cmd([[
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

  command! DoubleQuotize :%s/\'/\"/g

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
  cnoremap <expr> %! expand('%')

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
  nnoremap <Leader>r q:?
  nmap     <Leader>t  <NOP>
  "                y
  "                u
  nmap     <Leader>i :call PutInspectStatementForCurrentWordIntoClipboard()<CR>
  "                o
  "                p

  nnoremap <Leader>a <C-^>
  nmap     <Leader>s  <NOP>
  nnoremap <Leader>d :call GoToDefinition()<CR>
  nmap     <Leader>f  <NOP>
  nmap     <Leader>g  <NOP>
  nmap     <Leader>h  <NOP>
  nnoremap <Leader>j <C-w>j
  nnoremap <Leader>k <C-w>k
  nmap     <Leader>l oputs "----- DEBUGGERER -- #{ self.class } -- #{ __method__ } 1"<ESC>h

  nnoremap <Leader>z :qa<CR>
  nmap     <Leader>x  <NOP>
  nmap     <Leader>c  <NOP>
  nnoremap <Leader>v <NOP>
  "                b
  nmap     <Leader>n <NOP>
  nmap     <Leader>m <NOP>

  nnoremap <Leader>gu :GrepRaw -w <c-r><c-w><CR>
  "nnoremap <Leader>gu :GrepRuby -w <c-r><c-w><CR>
  " what were these about?
  nnoremap <Leader>gi :GrepRaw -w "\.<c-r><c-w>"<CR>
  nnoremap <Leader>gr :GrepRaw -w "<c-r><c-w>\."<CR>
  nnoremap <Leader>gh :Ghunks<CR>
  nnoremap <Leader>gd :Gcd .<CR>:terminal git_diff_raw_all<CR>:cd -<CR>
  nnoremap <Leader>gs :exec '!subl -w ' . expand('%') . ':' . line('.') . ':' . col('.')<CR><CR>
  nnoremap <Leader>gv :exec '!code -g ' . expand('%') . ':' . line('.') . ':' . col('.')<CR><CR>
  nnoremap <Leader>gb :GrepRaw "binding.irb"<CR>
  nnoremap <Leader>gp :GrepRaw "DEBUGGERER"<CR>
  vnoremap <Leader>gu "zy:GrepRaw "<C-R>z"<CR>

  nnoremap <Leader>fa <C-^>
  nnoremap <Leader>ff :FZF<CR>
  nnoremap <Leader>fo :call BrowseOldFilesFromCwd()<CR>

  nnoremap <Leader>mq :MapNextToQuickFix<CR>

  nnoremap <Leader>ta :TermTestAll<CR>
  nnoremap <Leader>tf :TermTestFile<CR>
  nnoremap <Leader>tt :TermTestSingle<CR>
  nnoremap <Leader>tr :TermTestRetry<CR>
  nnoremap <Leader>tv :TermTestView<CR>

  nmap     <Leader>hn <Plug>GitGutterNextHunk
  nmap     <Leader>hN <Plug>GitGutterPrevHunk
  nnoremap <Leader>hf gg:GitGutterNextHunk<CR>zz:MapNextToGitGutterHunk<CR>
  nnoremap <Leader>hg :Ghunks<CR>

  nmap     <Leader>sh <Plug>(GitGutterStageHunk)
  nmap     <Leader>sf :Gwrite<CR>
  nnoremap <Leader>sw :set wrap!<CR>
  nnoremap <Leader>sn :set number!<CR>

  nnoremap <Leader>cf :Gwrite\|Git commit -v<CR>
  nnoremap <Leader>ca :Gcd .<CR>:silent ! git add .<CR>:cd -<CR>:Git commit -v<CR>
  nnoremap <Leader>ch :GitGutterStageHunk<CR>:Git commit -v<CR>
  nnoremap <Leader>cc :Git commit -v<CR>
  nnoremap <Leader>cp :call CopyFilePath()<CR>
  nnoremap <Leader>cl :call CopyFilePathWithLine()<CR>

  nnoremap <Leader>xn :te<CR>a
  nnoremap <Leader>xx :sp\|te<CR>a
  nnoremap <Leader>xt :tabnew\|te<CR>a

  nnoremap <Leader>vc :Augment chat 
  nnoremap <Leader>vd :let g:augment_disable_completions = v:true<CR>
  nnoremap <Leader>ve :let g:augment_disable_completions = v:false<CR>
  nnoremap <Leader>vi :call InsertTimestamp()<CR>
  nnoremap <Leader>vx :Xsnapnote<CR>
  nnoremap <Leader>vr :call RunShellCommandInCurrentLine()<CR>

  nnoremap <Leader><Leader> gF


  nnoremap ff :FZF<CR>
  nnoremap fs :FilesModified<CR>

  nmap vai vaI
  nmap vis jvii
  nmap vas jvai

  nnoremap j gj
  nnoremap k gk

  augroup MyTermMappings
    autocmd!
    autocmd TermOpen * nnoremap <buffer> o    gF:only<CR>
    autocmd TermOpen * nnoremap <buffer> <CR> gF:only<CR>
    autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
  augroup END

  autocmd FileType markdown setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
  autocmd FileType markdown setlocal foldmethod=expr foldexpr=MarkdownFold()
  "autocmd FileType markdown setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()
]])
-- nmap fmn ]m
-- nmap fme ]M
-- nmap fmb [m
-- nmap fmp [M
-- nmap fmf gg]m
-- vmap fmn ]m
-- vmap fme ]M
-- vmap fmb [m
-- vmap fmp [M
-- vmap fmf gg]m

-- nmap fcn ]]
-- nmap fce ][
-- nmap fcb [[
-- nmap fcp []
-- nmap fcf gg]]
-- vmap fcn ]]
-- vmap fce ][
-- vmap fcb [[
-- vmap fcp []
-- vmap fcf gg]]
