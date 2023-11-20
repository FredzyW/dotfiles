vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"
lvim.transparent_window = true
-- vim.g.catppuccin_flavour = "latte"  -- set the flavor
-- lvim.colorscheme = "catppuccin-latte"
-- setup must be called before loading
lvim.builtin.lualine.options.theme = "dracula"
lvim.builtin.lualine.sections.lualine_b = { "lsp_progress" }
vim.opt.wrap = true 
vim.o.termguicolors = true


vim.cmd[[
  let g:jupytext_fmt = 'py'
  let g:jupytext_style = 'hydrogen'

  nmap ]x ctrih/^# %%<CR><CR>
]]

vim.keymap.set('n', '<space>r', '<cmd>MagmaEvaluateOperator<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>MagmaEvaluateLine<cr>')
vim.keymap.set('x', '<space>r', ':<C-u>MagmaEvaluateVisual<CR>', { silent = true })
vim.keymap.set('n', '<space>rc', '<cmd>MagmaReevaluateCell<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

vim.cmd[[
  function! SyncJupytext()
    execute '!jupytext --sync %:p'
  endfunction

  command! JupytextSync call SyncJupytext()
]]

vim.cmd[[

  " nnoremap <silent><expr> <LocalLeader>r  :MagmaEvaluateOperator<CR>
  " nnoremap <silent>       <LocalLeader>rr :MagmaEvaluateLine<CR>
  " xnoremap <silent>       <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>
  " nnoremap <silent>       <LocalLeader>rc :MagmaReevaluateCell<CR>
  " nnoremap <silent>       <LocalLeader>rd :MagmaDelete<CR>
  " nnoremap <silent>       <LocalLeader>ro :MagmaShowOutput<CR>

  let g:magma_automatically_open_output = v:false
  let g:magma_image_provider = "kitty"
]]

vim.cmd [[
  function! s:AutoCompileMarkdown()
    " Set up the autocmd to run the script after saving a markdown file
    autocmd BufWritePost *.md !/home/fwastring/scripts/md2pdf/MarkdownCompile.sh %
    autocmd BufWritePost *.md ++once !/home/fwastring/scripts/md2pdf/MarkdownView.sh %
    echo "Markdown auto-compilation enabled"
  endfunction

  " Define the MarkdownCompile command
  command! MarkdownCompile call s:AutoCompileMarkdown()


  " Clear the autocmd when the file is first loaded (optional, but recommended)
  autocmd BufRead *.md autocmd! BufWritePost *.md
]]

-- This ensures that the Vim command is added after Neovim has fully started
vim.cmd([[autocmd VimEnter * command! MarkdownView :w !/home/fwastring/scripts/md2pdf/MarkdownView.sh %]])


vim.wo.relativenumber = true  -- Enable relative line numbers
vim.wo.number = true          -- Show the current line number

lvim.plugins = {
  {"lervag/vimtex"},
  { 'dccsillag/magma-nvim', build = ':UpdateRemotePlugins' },
  {'untitled-ai/jupyter_ascending.vim'},

}

