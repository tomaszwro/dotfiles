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
