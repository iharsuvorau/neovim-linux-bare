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

vim.keymap.set('n', '<Esc>', ':nohlsearch<cr>')
vim.keymap.set('n', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- LSP and completion config

vim.pack.add({"https://github.com/neovim/nvim-lspconfig"})
vim.lsp.enable({ "lua_ls", "ruby_lsp", "gopls", "emmet_language_server" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end
})
vim.cmd("set completeopt+=noselect")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Plugins

vim.pack.add({ "https://github.com/vague2k/vague.nvim" })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

vim.pack.add({"https://github.com/mason-org/mason.nvim"})
require("mason").setup()
vim.keymap.set("n", "<leader>m", ":Mason<cr>")

vim.pack.add({"https://github.com/stevearc/oil.nvim"})
require("oil").setup()
vim.keymap.set("n", "-", ":Oil<cr>")

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
})
vim.keymap.set("n", "<leader>gg", ":LazyGit<cr>")

vim.pack.add({
  "https://github.com/echasnovski/mini.ai",
  "https://github.com/echasnovski/mini.pick",
  "https://github.com/echasnovski/mini.surround",
  "https://github.com/echasnovski/mini.pairs",
  "https://github.com/echasnovski/mini.notify",
})
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
vim.keymap.set("n", "<leader>sf", ":Pick files<cr>")
vim.keymap.set("n", "<leader><leader>", ":Pick buffers<cr>")
vim.keymap.set("n", "<leader>sh", ":Pick help<cr>")
vim.keymap.set("n", "<leader>sg", ":Pick grep_live<cr>")
vim.keymap.set("n", "<leader>sr", ":Pick resume<cr>")

require("mini.notify").setup()
vim.notify = require("mini.notify").make_notify()

vim.pack.add({"https://github.com/lewis6991/gitsigns.nvim"})
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end)

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })

    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

    map("n", "<leader>hb", function()
      gitsigns.blame_line({ full = true })
    end, { desc = "Blame line" })

    map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })

    map("n", "<leader>hD", function()
      gitsigns.diffthis("~")
    end, { desc = "Diff with the last commit" })

    map("n", "<leader>hQ", function()
      gitsigns.setqflist("all")
    end, { desc = "Show changes in quickfix list (all)" })
    map("n", "<leader>hq", gitsigns.setqflist, { desc = "Show changes in quickfix list" })

    -- Toggles
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
    map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk)
  end,
})

vim.pack.add({"https://github.com/folke/which-key.nvim"})
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = true })
end, { desc = "Buffer local keymaps" })

