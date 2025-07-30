vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }
})
require("nvim-treesitter").install({ "html", "css", "go", "ruby", "javascript", "sql", "python" })
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'html', 'css', 'ruby', 'go', 'javascript', 'sql', 'python' },
--   callback = function()
--     -- syntax highlighting, provided by Neovim
--     vim.treesitter.start()
--     -- folds, provided by Neovim
--     vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--     -- indentation, provided by nvim-treesitter
--     vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--   end,
-- })
-- vim.treesitter.language.register("html", { "erb", "eruby" })
