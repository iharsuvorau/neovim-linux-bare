vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.winborder = 'rounded'
vim.o.splitright = true
vim.o.splitbelow = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- For local config and plugin development
vim.keymap.set("n", "<leader>s", ":source<cr>", { desc = "Source selection or buffer" })

-- Faster navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>t', ':split +terminal<cr>', { desc = "Open terminal at the bottom" })
vim.keymap.set('n', '<Esc>', ':nohlsearch<cr>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Plugins

require("config.lsp")
require("config.mini")
require("config.gitsigns")
require("config.treesitter")

vim.pack.add({ "https://github.com/vague2k/vague.nvim" })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup()
vim.keymap.set("n", "<leader>m", ":Mason<cr>")

vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("oil").setup()
vim.keymap.set("n", "-", ":Oil<cr>")

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
})
vim.keymap.set("n", "<leader>gg", ":LazyGit<cr>")

vim.pack.add({ "https://github.com/folke/which-key.nvim" })
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = true })
end, { desc = "Buffer local keymaps" })

vim.pack.add({ "https://github.com/windwp/nvim-ts-autotag" })
require("nvim-ts-autotag").setup({})

