-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

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

