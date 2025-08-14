vim.pack.add({
  "https://github.com/echasnovski/mini.ai",
  "https://github.com/echasnovski/mini.pick",
  "https://github.com/echasnovski/mini.files",
  "https://github.com/echasnovski/mini.surround",
  "https://github.com/echasnovski/mini.pairs",
  "https://github.com/echasnovski/mini.notify",
  "https://github.com/echasnovski/mini.icons",
})
require("mini.ai").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.icons").setup()
require("mini.files").setup()
vim.keymap.set("n", "\\", function()
  if not MiniFiles.close() then MiniFiles.open() end
end)
require("mini.pick").setup({
  mappings = {
    choose_marked = "<C-CR>"
  }
})
vim.keymap.set("n", "<leader>sf", ":Pick files<cr>")
vim.keymap.set("n", "<leader><leader>", ":Pick buffers<cr>")
vim.keymap.set("n", "<leader>sh", ":Pick help<cr>")
vim.keymap.set("n", "<leader>sg", ":Pick grep_live<cr>")
vim.keymap.set("n", "<leader>sr", ":Pick resume<cr>")

require("mini.notify").setup()
vim.notify = require("mini.notify").make_notify()
