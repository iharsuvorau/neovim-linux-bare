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

-- Autosave
vim.cmd(
  "autocmd BufHidden,FocusLost,WinLeave,CursorHold * if &buftype=='' && filereadable(expand('%:p')) | silent lockmarks update ++p | endif")

-- For local config and plugin development
-- vim.keymap.set("n", "<leader>s", ":source<cr>", { desc = "Source selection or buffer" })

-- Faster navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-S-j>', ':cnext<CR>', { desc = 'Next quicklist item' })
vim.keymap.set('n', '<C-S-k>', ':cprev<CR>', { desc = 'Next quicklist item' })

vim.keymap.set('n', '<leader>t', ':split +terminal<cr>', { desc = "Open terminal at the bottom" })
vim.keymap.set('n', '<Esc>', ':nohlsearch<cr>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Plugins

require("config.lsp")
require("config.mini")
require("config.gitsigns")
require("config.treesitter")

vim.pack.add({
  "https://github.com/vague2k/vague.nvim",
  "https://github.com/rose-pine/neovim",
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/ribru17/bamboo.nvim",
})
-- vim.cmd("colorscheme vague")
-- vim.cmd("colorscheme rose-pine-dawn")
-- vim.cmd("colorscheme gruvbox")
vim.cmd("colorscheme bamboo")
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

vim.pack.add({ "https://github.com/prettier/vim-prettier" })

vim.pack.add({ "https://github.com/Saghen/blink.cmp" })

vim.pack.add({ "https://github.com/dmtrKovalenko/fff.nvim" })
-- Needed to go inside the plugin's location and build it with "cargo build --release"
local fff = require("fff")
fff.setup()
vim.keymap.set("n", "ff", fff.find_files, { desc = "Open yet another file picker" })
vim.keymap.set("n", "fd", function()
  function get_dir(str)
    return str:match("(.*[/\\])")
  end

  local buf_path = vim.api.nvim_buf_get_name(0)
  local cur_dir = get_dir(buf_path)
  fff.find_files_in_dir(cur_dir)
end, { desc = "Open yet another file picker in a dir" })
-- require('fff').find_files()                         -- Find files in current directory
-- require('fff').find_in_git_root()                   -- Find files in the current git repository
-- require('fff').scan_files()                         -- Trigger rescan of files in the current directory
-- require('fff').refresh_git_status()                 -- Refresh git status for the active file lock
-- require('fff').find_files_in_dir(path)              -- Find files in a specific directory
-- require('fff').change_indexing_directory(new_path)  -- Change the base directory for the file picker
