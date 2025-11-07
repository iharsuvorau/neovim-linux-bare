vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Run organize go imports on file save
local gofile_au_group = vim.api.nvim_create_augroup('goimports-on-write', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = gofile_au_group,
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } }, apply = true }
    --vim.lsp.buf.code_action { context = { only = { 'source.fixAll' } }, apply = true }
  end,
  desc = 'Organize Go imports on save',
})


