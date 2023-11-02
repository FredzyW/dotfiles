-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
lvim.transparent_window = true
-- vim.g.catppuccin_flavour = "latte"  -- set the flavor
-- lvim.colorscheme = "catppuccin-latte"
-- setup must be called before loading
lvim.builtin.lualine.sections.lualine_b = { "lsp_progress" }
vim.opt.wrap = true 
vim.o.termguicolors = true

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
  {"rafamadriz/neon"},
  -- {"catppuccin/nvim", name = "catppuccin", flavor = "latte"}
}
